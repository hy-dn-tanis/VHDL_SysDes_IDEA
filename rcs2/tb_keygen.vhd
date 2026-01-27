--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:35:35 12/08/2025
-- Design Name:   
-- Module Name:   /nas/lrz/home/ge48lin/submit/rcs1/tb_keygen.vhd
-- Project Name:  idea_rcs1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keygen
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
 
ENTITY tb_keygen IS
END tb_keygen;
 
ARCHITECTURE behavior OF tb_keygen IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keygen
    PORT(
         round : IN  std_logic_vector(3 downto 0);
         key : IN  std_logic_vector(127 downto 0);
         part_key1 : OUT  std_logic_vector(15 downto 0);
         part_key2 : OUT  std_logic_vector(15 downto 0);
         part_key3 : OUT  std_logic_vector(15 downto 0);
         part_key4 : OUT  std_logic_vector(15 downto 0);
         part_key5 : OUT  std_logic_vector(15 downto 0);
			part_key6 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal round : std_logic_vector(3 downto 0) := "0000";
   signal key : std_logic_vector(127 downto 0) := x"00010002000300040005000600070008";

 	--Outputs
   signal part_key1 : std_logic_vector(15 downto 0);
   signal part_key2 : std_logic_vector(15 downto 0);
   signal part_key3 : std_logic_vector(15 downto 0);
   signal part_key4 : std_logic_vector(15 downto 0);
   signal part_key5 : std_logic_vector(15 downto 0);
   signal part_key6 : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keygen PORT MAP (
          round => round,
          key => key,
          part_key1 => part_key1,
          part_key2 => part_key2,
          part_key3 => part_key3,
          part_key4 => part_key4,
			 part_key5 => part_key5,
          part_key6 => part_key6
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
