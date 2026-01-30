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

  -- helper procedure: wait for rising edge and settle --AI generated idea
  procedure tick is
  begin
    wait until rising_edge(CLK);
    wait for 1 ns; -- allow combinational outputs to settle
  end procedure;

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
  begin
    -- initial idle (sleep)
    START  <= '0';
    RESULT <= '0';
    tick;

    -- start pulse to enter Setup
    START <= '1';
    tick;
    START <= '0';

 
    wait;
  end process;

end behavior;