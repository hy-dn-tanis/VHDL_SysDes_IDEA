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
	
	--shifted keys/round
	signal ZR2:STD_LOGIC_VECTOR(127 downto 0);
	signal ZR3:STD_LOGIC_VECTOR(127 downto 0);
	signal ZR4:STD_LOGIC_VECTOR(127 downto 0);
	signal ZR5:STD_LOGIC_VECTOR(127 downto 0);
	signal ZR6:STD_LOGIC_VECTOR(127 downto 0);
	signal ZR7:STD_LOGIC_VECTOR(127 downto 0);
	signal ZR8:STD_LOGIC_VECTOR(127 downto 0);
	signal ZOUT_TRAFO:STD_LOGIC_VECTOR(127 downto 0);
	
	
	--partial keys for each round
	signal Z11, Z12, Z13, Z14, Z15, Z16 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z21, Z22, Z23, Z24, Z25, Z26 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z31, Z32, Z33, Z34, Z35, Z36 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z41, Z42, Z43, Z44, Z45, Z46 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z51, Z52, Z53, Z54, Z55, Z56 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z61, Z62, Z63, Z64, Z65, Z66 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z71, Z72, Z73, Z74, Z75, Z76 : STD_LOGIC_VECTOR(15 downto 0);
	signal Z81, Z82, Z83, Z84, Z85, Z86 : STD_LOGIC_VECTOR(15 downto 0);
	signal ZO1, ZO2, ZO3, ZO4: STD_LOGIC_VECTOR(15 DOWNTO 0); -- output transformation keys	
	
begin 

	ZR2 <= KEY(102 downto 0) & KEY(127 downto 103);
	ZR3 <= ZR2(102 downto 0) & ZR2(127 downto 103);
	ZR4 <= ZR3(102 downto 0) & ZR3(127 downto 103);
	ZR5 <= ZR4(102 downto 0) & ZR4(127 downto 103);
	ZR6 <= ZR5(102 downto 0) & ZR5(127 downto 103);
	ZR7 <= ZR6(102 downto 0) & ZR6(127 downto 103);
	ZR8 <= ZR7(102 downto 0) & ZR7(127 downto 103);
	ZOUT_TRAFO <= ZR8(102 downto 0) & ZR8(127 downto 103);

	    -- Round 1 
    Z11 <= KEY(127 downto 112);
    Z12 <= KEY(111 downto 96);
    Z13 <= KEY(95  downto 80);
    Z14 <= KEY(79  downto 64);
    Z15 <= KEY(63  downto 48);
    Z16 <= KEY(47  downto 32);

    -- Round 2 
    Z21 <= ZR2(127 downto 112);
    Z22 <= ZR2(111 downto 96);
    Z23 <= ZR2(95  downto 80);
    Z24 <= ZR2(79  downto 64);
    Z25 <= ZR2(63  downto 48);
    Z26 <= ZR2(47  downto 32);

    -- Round 3 
    Z31 <= ZR3(127 downto 112);
    Z32 <= ZR3(111 downto 96);
    Z33 <= ZR3(95  downto 80);
    Z34 <= ZR3(79  downto 64);
    Z35 <= ZR3(63  downto 48);
    Z36 <= ZR3(47  downto 32);

    -- Round 4 
    Z41 <= ZR4(127 downto 112);
    Z42 <= ZR4(111 downto 96);
    Z43 <= ZR4(95  downto 80);
    Z44 <= ZR4(79  downto 64);
    Z45 <= ZR4(63  downto 48);
    Z46 <= ZR4(47  downto 32);

    -- Round 5 
    Z51 <= ZR5(127 downto 112);
    Z52 <= ZR5(111 downto 96);
    Z53 <= ZR5(95  downto 80);
    Z54 <= ZR5(79  downto 64);
    Z55 <= ZR5(63  downto 48);
    Z56 <= ZR5(47  downto 32);

    -- Round 6
    Z61 <= ZR6(127 downto 112);
    Z62 <= ZR6(111 downto 96);
    Z63 <= ZR6(95  downto 80);
    Z64 <= ZR6(79  downto 64);
    Z65 <= ZR6(63  downto 48);
    Z66 <= ZR6(47 downto 32);

    -- Round 7
    Z71 <= ZR7(127 downto 112);
    Z72 <= ZR7(111 downto 96);
    Z73 <= ZR7(95  downto 80);
    Z74 <= ZR7(79  downto 64);
    Z75 <= ZR7(63  downto 48);
    Z76 <= ZR7(47 downto 32);

    -- Round 8
    Z81 <= ZR8(127 downto 112);
    Z82 <= ZR8(111 downto 96);
    Z83 <= ZR8(95  downto 80);
    Z84 <= ZR8(79  downto 64);
    Z85 <= ZR8(63  downto 48);
    Z86 <= ZR8(47 downto 32);
    
    -- Output Transformation
    ZO1 <= ZOUT_TRAFO(127 DOWNTO 112);
    ZO2 <= ZOUT_TRAFO(111 DOWNTO 96);
    ZO3 <= ZOUT_TRAFO(95 DOWNTO 80);
	ZO4 <= ZOUT_TRAFO(79 DOWNTO 64);
     	
	R1: ROUND port map(
		X_1, X_2, X_3, X_4,
		Z11, Z12, Z13, Z14, Z15, Z16,
		R_11, R_12, R_13, R_14);

	R2: ROUND port map(
		R_11, R_12, R_13, R_14,
		Z21, Z22, Z23, Z24, Z25, Z26,
		R_21, R_22, R_23, R_24);

	R3: ROUND port map(
		R_21, R_22, R_23, R_24,
		Z31, Z32, Z33, Z34, Z35, Z36,
		R_31, R_32, R_33, R_34);

	R4: ROUND port map(
		R_31, R_32, R_33, R_34,
		Z41, Z42, Z43, Z44, Z45, Z46,
		R_41, R_42, R_43, R_44);

	R5: ROUND port map(
		R_41, R_42, R_43, R_44,
		Z51, Z52, Z53, Z54, Z55, Z56,
		R_51, R_52, R_53, R_54);

	R6: ROUND port map(
		R_51, R_52, R_53, R_54,
		Z61, Z62, Z63, Z64, Z65, Z66,
		R_61, R_62, R_63, R_64);

	R7: ROUND port map(
		R_61, R_62, R_63, R_64,
		Z71, Z72, Z73, Z74, Z75, Z76,
		R_71, R_72, R_73, R_74	);

	R8: ROUND port map(
		R_71, R_72, R_73, R_74,
		Z81, Z82, Z83, Z84, Z85, Z86,
		R_81, R_82, R_83, R_84);

	OUTPUT_TRAFO: TRAFO port map(R_81, R_82, R_83, R_84, Y_1, Y_2, Y_3, Y_4, ZO1, ZO2, ZO3, ZO4);

end Structural;

