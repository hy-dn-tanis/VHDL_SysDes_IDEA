--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:35:53 12/12/2025
-- Design Name:   
-- Module Name:   /nas/lrz/home/ge48lin/submit/rcs2/tb_mux4x1.vhd
-- Project Name:  idea_rcs2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux4x1
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
--USE ieee.numeric_std.ALL;
 
ENTITY tb_mux4x1 IS
END tb_mux4x1;
 
ARCHITECTURE behavior OF tb_mux4x1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux4x1
    PORT(
         S : IN  std_logic_vector(1 downto 0);
         D0 : IN  std_logic_vector(15 downto 0);
         D1 : IN  std_logic_vector(15 downto 0);
         D2 : IN  std_logic_vector(15 downto 0);
         D3 : IN  std_logic_vector(15 downto 0);
         O : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic_vector(1 downto 0) := "00";
   signal D0 : std_logic_vector(15 downto 0) := x"0000";
   signal D1 : std_logic_vector(15 downto 0) := x"1111";
   signal D2 : std_logic_vector(15 downto 0) := x"2222";
   signal D3 : std_logic_vector(15 downto 0) := x"3333";

 	--Outputs
   signal O : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux4x1 PORT MAP (
          S => S,
          D0 => D0,
          D1 => D1,
          D2 => D2,
          D3 => D3,
          O => O
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		S <= "01";

      wait for 100 ns;	
		S <= "10";


      wait for 100 ns;	
		S <= "11";


      wait for 100 ns;
		S <= "00";
		

      -- insert stimulus here 

      wait;
   end process;

END;
