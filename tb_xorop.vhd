--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:57:03 11/10/2025
-- Design Name:   
-- Module Name:   /nas/lrz/home/ge48lin/submit/direct/tb_xorop.vhd
-- Project Name:  idea
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: xorop
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
 
ENTITY tb_xorop IS
END tb_xorop;
 
ARCHITECTURE behavior OF tb_xorop IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT xorop
    PORT(
         IN1 : IN  STD_LOGIC_VECTOR(15 downto 0);
         IN2 : IN  STD_LOGIC_VECTOR(15 downto 0);
         OUT1 : OUT  STD_LOGIC_VECTOR(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal IN1 : STD_LOGIC_VECTOR(15 downto 0) := x"0101";
   signal IN2 : STD_LOGIC_VECTOR(15 downto 0) := x"0011";

 	--Outputs
   signal OUT1 : STD_LOGIC_VECTOR(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: xorop PORT MAP (
          IN1 => IN1,
          IN2 => IN2,
          OUT1 => OUT1
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 

      wait;
   end process;

END;
