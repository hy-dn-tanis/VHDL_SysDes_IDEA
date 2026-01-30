--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:54:47 01/16/2026
-- Design Name:   
-- Module Name:   /nas/lrz/home/ge48lin/VHDL_SysDes_IDEA/rcs2/roundcounter_tb.vhd
-- Project Name:  idea_rcs2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: roundcounter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_roundcounter is
end tb_roundcounter;

architecture behavior of tb_roundcounter is
  -- UUT ports
  signal CLK    : std_logic := '0';
  signal START  : std_logic := '0';
  signal RESULT : std_logic := '0';
  signal READY  : std_logic;
  signal S_i    : std_logic;
  signal INIT   : std_logic;
  signal TRAFO  : std_logic;
  signal ROUND  : std_logic_vector(3 downto 0);

  constant CLK_PERIOD : time := 10 ns;

  -- helper procedure: wait for rising edge and settle
  procedure tick is
  begin
    wait until rising_edge(CLK);
    wait for 1 ns; -- allow combinational outputs to settle
  end procedure;

  function slv4(i : integer) return std_logic_vector is
  begin
    return std_logic_vector(to_unsigned(i, 4));
  end function;

begin
  -- clock
  clk_proc : process
  begin
    CLK <= '0';
    wait for CLK_PERIOD/2;
    CLK <= '1';
    wait for CLK_PERIOD/2;
  end process;

  -- UUT
  uut: entity work.roundcounter
    port map (
      CLK    => CLK,
      START  => START,
      RESULT => RESULT,
      READY  => READY,
      S_i    => S_i,
      INIT   => INIT,
      TRAFO  => TRAFO,
      ROUND  => ROUND
    );

  -- stimulus and checks
  stim_proc : process
    variable expected_round : integer := 8; -- 1000
  begin
    -- initial idle (sleep)
    START  <= '0';
    RESULT <= '0';
    tick;

    assert READY = '1' report "Expected READY=1 in Sleep state" severity error;
    assert INIT  = '0' report "Expected INIT=0 in Sleep state" severity error;
    assert ROUND = "1000" report "Expected ROUND=1000 at reset/sleep" severity error;
    assert S_i   = '1' report "Expected S_i=1 at ROUND=1000" severity error;
    assert TRAFO = '0' report "Expected TRAFO=0 at ROUND=1000" severity error;

    -- start pulse to enter Setup
    START <= '1';
    tick;
    START <= '0';

    -- now in Setup (Init=1, Ready=0) and ROUND reset to 0000
    assert INIT  = '1' report "Expected INIT=1 in Setup state" severity error;
    assert READY = '0' report "Expected READY=0 in Setup state" severity error;
    assert ROUND = "0000" report "Expected ROUND=0000 after Start" severity error;
    assert S_i   = '1' report "Expected S_i=1 at ROUND=0000" severity error;

    -- Setup -> Calc
    tick;
    assert INIT  = '0' report "Expected INIT=0 in Calc state" severity error;
    assert READY = '0' report "Expected READY=0 in Calc state" severity error;
    assert ROUND = "0000" report "Expected ROUND to stay 0000 when RESULT=0" severity error;

    -- step rounds 0001..0111
    for i in 1 to 7 loop
      -- in Calc, request next round
      RESULT <= '1';
      tick;

      -- enter Setup, round should have incremented
      assert INIT  = '1' report "Expected INIT=1 in Setup after RESULT=1" severity error;
      assert READY = '0' report "Expected READY=0 in Setup after RESULT=1" severity error;
      assert ROUND = slv4(i) report "ROUND did not increment as expected" severity error;

      if i = 7 then
        assert TRAFO = '1' report "Expected TRAFO=1 at ROUND=0111" severity error;
      else
        assert TRAFO = '0' report "Expected TRAFO=0 for rounds other than 0111" severity error;
      end if;

      assert S_i = '0' report "Expected S_i=0 for rounds 1..7" severity error;

      -- back to Calc
      RESULT <= '0';
      tick;
      assert INIT  = '0' report "Expected INIT=0 in Calc" severity error;
      assert READY = '0' report "Expected READY=0 in Calc" severity error;
    end loop;

    -- increment to 1000
    RESULT <= '1';
    tick;
    assert INIT  = '1' report "Expected INIT=1 in Setup at ROUND=1000" severity error;
    assert ROUND = "1000" report "Expected ROUND=1000 after last increment" severity error;
    assert S_i   = '1' report "Expected S_i=1 at ROUND=1000" severity error;
    assert TRAFO = '0' report "Expected TRAFO=0 at ROUND=1000" severity error;

    -- Setup -> Calc with ROUND=1000
    RESULT <= '0';
    tick;
    assert INIT  = '0' report "Expected INIT=0 in Calc at ROUND=1000" severity error;
    assert READY = '0' report "Expected READY=0 in Calc at ROUND=1000" severity error;

    -- in Calc, RESULT=1 and ROUND=1000 should return to Sleep
    RESULT <= '1';
    tick;
    assert READY = '1' report "Expected READY=1 returning to Sleep at ROUND=1000" severity error;
    assert INIT  = '0' report "Expected INIT=0 in Sleep" severity error;
    assert ROUND = "1000" report "Expected ROUND to remain 1000 in Sleep" severity error;

    report "Testbench completed." severity note;
    wait;
  end process;

end behavior;