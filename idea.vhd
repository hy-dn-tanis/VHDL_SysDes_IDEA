----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    idea - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity idea is
    Port ( KEY : in  STD_LOGIC_VECTOR (127 downto 0);
           X_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y_1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_4 : out  STD_LOGIC_VECTOR (15 downto 0));
end idea;

architecture Structural of idea is
	-- components
	component TRAFO
		-- output transformation input
		 X1 : IN  std_logic_vector(15 downto 0);
         X2 : IN  std_logic_vector(15 downto 0);
         X3 : IN  std_logic_vector(15 downto 0);
         X4 : IN  std_logic_vector(15 downto 0);
         -- output
         Y1 : OUT  std_logic_vector(15 downto 0);
         Y2 : OUT  std_logic_vector(15 downto 0);
         Y3 : OUT  std_logic_vector(15 downto 0);
         Y4 : OUT  std_logic_vector(15 downto 0);
         -- output transformation partial key
         Z1 : IN  std_logic_vector(15 downto 0);
         Z2 : IN  std_logic_vector(15 downto 0);
         Z3 : IN  std_logic_vector(15 downto 0);
         Z4 : IN  std_logic_vector(15 downto 0)
	end component;
	
	component ROUND
		Port ( 
		-- input vectors
			X1 : in STD_LOGIC_VECTOR(15 downto 0);
           X2 : in  STD_LOGIC_VECTOR(15 downto 0);
           X3 : in STD_LOGIC_VECTOR(15 downto 0);
           X4 : in STD_LOGIC_VECTOR(15 downto 0);
           --partial keys
           Z1 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z2 : in STD_LOGIC_VECTOR(15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z5 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z6 : in  STD_LOGIC_VECTOR(15 downto 0);
           --output
           Y1 : out STD_LOGIC_VECTOR(15 downto 0);
           Y2 : out STD_LOGIC_VECTOR(15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	-- intermediate signals are outputs from each round module
	signal R_11, R_12, R_13, R_14: STD_LOGIC_VECTOR(15 downto 0);
	signal R_21, R_22, R_23, R_24: STD_LOGIC_VECTOR(15 downto 0);
	signal R_31, R_32, R_33, R_34: STD_LOGIC_VECTOR(15 downto 0);
	signal R_41, R_42, R_43, R_44: STD_LOGIC_VECTOR(15 downto 0);
	signal R_51, R_52, R_53, R_54: STD_LOGIC_VECTOR(15 downto 0);
	signal R_61, R_62, R_63, R_64: STD_LOGIC_VECTOR(15 downto 0);
	signal R_71, R_72, R_73, R_74: STD_LOGIC_VECTOR(15 downto 0);
	
	--output from last round module -> input to trafo module
	signal R_81, R_82, R_83, R_84: STD_LOGIC_VECTOR(15 downto 0);
	
	--partial keys
	
	
begin

	R1: ROUND port map()

end Structural;

