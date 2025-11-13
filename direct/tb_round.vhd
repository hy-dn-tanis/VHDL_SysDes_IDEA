--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:39:55 11/10/2025
-- Design Name:   
-- Module Name:   /nas/lrz/home/ge48lin/submit/direct/tb_round.vhd
-- Project Name:  idea
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: round
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY tb_round IS
END tb_round;
      
ARCHITECTURE behavior OF tb_round IS 
   
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT round
    PORT(
         X1 : IN  STD_LOGIC_VECTOR(15 downto 0);
         X2 : IN  STD_LOGIC_VECTOR(15 downto 0);
         X3 : IN  STD_LOGIC_VECTOR(15 downto 0);
         X4 : IN  STD_LOGIC_VECTOR(15 downto 0);
         Z1 : IN  STD_LOGIC_VECTOR(15 downto 0);
         Z2 : IN  STD_LOGIC_VECTOR(15 downto 0);
         Z3 :IN  STD_LOGIC_VECTOR(15 downto 0);
         Z4 : IN  STD_LOGIC_VECTOR(15 downto 0);
         Z5 : IN  STD_LOGIC_VECTOR(15 downto 0);
         Z6 : IN  STD_LOGIC_VECTOR(15 downto 0);
         Y1 :OUT STD_LOGIC_VECTOR(15 downto 0);
         Y2 : OUT STD_LOGIC_VECTOR(15 downto 0);
         Y3 : OUT STD_LOGIC_VECTOR(15 downto 0);
         Y4 : OUT STD_LOGIC_VECTOR(15 downto 0)
    );
    END COMPONENT;

    -- Inputs
    signal X1 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal X2 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal X3 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal X4 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal Z1 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal Z2 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal Z3 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal Z4 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal Z5 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
    signal Z6 : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

    -- Outputs
    signal Y1 : STD_LOGIC_VECTOR(15 downto 0);
    signal Y2 : STD_LOGIC_VECTOR(15 downto 0);
    signal Y3 : STD_LOGIC_VECTOR(15 downto 0);
    signal Y4 : STD_LOGIC_VECTOR(15 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: round PORT MAP (
          X1 => X1,
          X2 => X2,
          X3 => X3,
          X4 => X4,
          Z1 => Z1,
          Z2 => Z2,
          Z3 => Z3,
          Z4 => Z4,
          Z5 => Z5,
          Z6 => Z6,
          Y1 => Y1,
          Y2 => Y2,
          Y3 => Y3,
          Y4 => Y4
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	



      wait;
   end process;

END;
