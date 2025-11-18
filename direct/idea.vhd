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
	PORT(
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
         Z4 : IN  std_logic_vector(15 downto 0));
	end component;
	
	component ROUND
		PORT ( 
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
	--round1 output = round2 input
	signal R_21, R_22, R_23, R_24: STD_LOGIC_VECTOR(15 downto 0);
	signal R_31, R_32, R_33, R_34: STD_LOGIC_VECTOR(15 downto 0);
	signal R_41, R_42, R_43, R_44: STD_LOGIC_VECTOR(15 downto 0);
	signal R_51, R_52, R_53, R_54: STD_LOGIC_VECTOR(15 downto 0);
	signal R_61, R_62, R_63, R_64: STD_LOGIC_VECTOR(15 downto 0);
	signal R_71, R_72, R_73, R_74: STD_LOGIC_VECTOR(15 downto 0);
	signal R_81, R_82, R_83, R_84: STD_LOGIC_VECTOR(15 downto 0); 
	--round 8 output = trafo module input	
	--output from last round module -> input to trafo module


	-- array of keys (implementation helped by AI)
	type key_array is array(0 to 51) of STD_LOGIC_VECTOR(15 downto 0);
	signal keys : key_array;
	

	
begin 

	--generate partial keys in a process
	subkeys : process(KEY)
	
	-- in total: 52 subkeys, 48 subkeys for 8 round modules (6 keys each) + 4 subkeys for the output transformation	
	--generate 48 16 bit subkeys for round module
	
	variable input_key : STD_LOGIC_VECTOR(127 downto 0);
	
	begin
		--partial keys for each roudn module
		input_key := KEY;
		for i in 0 to 5 loop --6 cyclic rotations
			for j in 0 to 7 loop --per cyclic rotation 8 partial key (128/16 = 8)
				keys(8*i + j) <= input_key((127 - 16*j) downto (112-16*j)) ;
			end loop;
			input_key := input_key(102 downto 0) & input_key(127 downto 103);
		end loop;
	
		--output transformation keys
		for n in 0 to 3 loop
			keys(48 + n) <= input_key((127 - 16 * n) downto (112 - 16*n));
		end loop;
	end process subkeys;
	
	-- instantiate components
	-- ai helps with the formatting of the port map parameters
	R1 : ROUND port map(X_1,  X_2,  X_3,  X_4,  keys(0),  keys(1),  keys(2),  keys(3),  keys(4),  keys(5),  R_11, R_12, R_13, R_14);
    R2 : ROUND port map(R_11, R_12, R_13, R_14, keys(6),  keys(7),  keys(8),  keys(9),  keys(10), keys(11), R_21, R_22, R_23, R_24);
    R3 : ROUND port map(R_21, R_22, R_23, R_24, keys(12), keys(13), keys(14), keys(15), keys(16), keys(17), R_31, R_32, R_33, R_34);
    R4 : ROUND port map(R_31, R_32, R_33, R_34, keys(18), keys(19), keys(20), keys(21), keys(22), keys(23), R_41, R_42, R_43, R_44);
    R5 : ROUND port map(R_41, R_42, R_43, R_44, keys(24), keys(25), keys(26), keys(27), keys(28), keys(29), R_51, R_52, R_53, R_54);
    R6 : ROUND port map(R_51, R_52, R_53, R_54, keys(30), keys(31), keys(32), keys(33), keys(34), keys(35), R_61, R_62, R_63, R_64);
    R7 : ROUND port map(R_61, R_62, R_63, R_64, keys(36), keys(37), keys(38), keys(39), keys(40), keys(41), R_71, R_72, R_73, R_74);
    R8 : ROUND port map(R_71, R_72, R_73, R_74, keys(42), keys(43), keys(44), keys(45), keys(46), keys(47), R_81, R_82, R_83, R_84);
    
	TF_OUT: TRAFO port map(R_81, R_82, R_83, R_84, Y_1, Y_2, Y_3, Y_4, keys(48), keys(49), keys(50), keys(51));
     	

end Structural;

