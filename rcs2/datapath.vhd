----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:11 12/12/2025 
-- Design Name: 
-- Module Name:    datapath - Structural 
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

entity datapath is
    Port ( CLOCK : in  STD_LOGIC;
           EN125 : in  STD_LOGIC;
           EN346 : in  STD_LOGIC;
           EN78 : in  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR(1 downto 0);
			  S_T: in STD_LOGIC_VECTOR(1 downto 0);
           X1 : in  STD_LOGIC_VECTOR(15 downto 0);
           X2 : in  STD_LOGIC_VECTOR(15 downto 0);
           X3 : in  STD_LOGIC_VECTOR(15 downto 0);
           X4 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z2 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z5 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z6 : in  STD_LOGIC_VECTOR(15 downto 0);
           Y1 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y2 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR(15 downto 0);
			  Y1_TRAFO : out  STD_LOGIC_VECTOR(15 downto 0);
			  Y2_TRAFO : out  STD_LOGIC_VECTOR(15 downto 0);
			  Y3_TRAFO : out  STD_LOGIC_VECTOR(15 downto 0);
			  Y4_TRAFO : out  STD_LOGIC_VECTOR(15 downto 0));
end datapath;

architecture Structural of datapath is

--components used in the datapath are: 
-- multiplier (mulop), adder (addop), xor (xorop)
-- 4x1 multiplexer (mux4x1), 16 bit register (register_16bit), 
component mux4x1
	   Port ( S : in  STD_LOGIC_VECTOR(1 downto 0);
           D0 : in  STD_LOGIC_VECTOR(15 downto 0);
           D1 : in  STD_LOGIC_VECTOR(15 downto 0);
           D2 : in  STD_LOGIC_VECTOR(15 downto 0);
           D3 : in  STD_LOGIC_VECTOR(15 downto 0);
           O : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

component register_16bit
		  Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR(15 downto 0);
           Q : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

component mulop
   Port ( I_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O_1 : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component addop
    Port ( IN1,IN2 : in  STD_LOGIC_VECTOR(15 downto 0);
           OUT_SUM : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

component xorop
	Port ( IN1 : in  STD_LOGIC_VECTOR(15 downto 0);
           IN2 : in  STD_LOGIC_VECTOR(15 downto 0);
           OUT1 : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

--signals

-- Multiplexer 1-4 outputs MUX_OUTi, i = 1...4
signal MUX_OUT1, MUX_OUT2, MUX_OUT3, MUX_OUT4: std_logic_vector(15 downto 0);
-- output of inner components
signal MULT_OUT, ADD_OUT, XOR_OUT: std_logic_vector(15 downto 0);

--register saved values (Qi)
signal Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8: std_logic_vector(15 downto 0);

begin

	MULT: mulop port map(MUX_OUT1, MUX_OUT2, MULT_OUT);
	ADD: addop port map(MUX_OUT3, MUX_OUT4, ADD_OUT);
	
	R1: register_16bit port map(CLOCK, EN125, MULT_OUT, Q1);
	R2: register_16bit port map(CLOCK, EN125, ADD_OUT, Q2);
	R3: register_16bit port map(CLOCK, EN346, ADD_OUT, Q3);
	R4: register_16bit port map(CLOCK, EN346, MULT_OUT, Q4);
	R5: register_16bit port map(CLOCK, EN125, XOR_OUT, Q5);
	R6: register_16bit port map(CLOCK, EN346, XOR_OUT, Q6);
	R7: register_16bit port map(CLOCK, EN78, MULT_OUT, Q7);
	R8: register_16bit port map(CLOCK, EN78, ADD_OUT, Q8);
	
	--multiplexers
	MUX1: mux4x1 port map(SEL,X1,X4,Z5,Z6, MUX_OUT1);
	MUX2: mux4x1 port map(SEL,Z1,Z4,Q5,Q8,MUX_OUT2);
	MUX3: mux4x1 port map(SEL,X3,X2,Q6,Q7,MUX_OUT3);
	MUX4: mux4x1 port map(S_T,Z3,Z2,MULT_OUT,MULT_OUT,MUX_OUT4);

	--xor modules
	XOR_ROUND: xorop port map(MULT_OUT, ADD_OUT, XOR_OUT);
	XOR_1: xorop port map(Q1,MULT_OUT, Y1);
	XOR_2: xorop port map(Q2,MULT_OUT, Y2);
	XOR_3: xorop port map(Q3,ADD_OUT, Y3);
	XOR_4: xorop port map(Q4,ADD_OUT, Y4);
	
	--trafo signals are taken directly from the outputs of register 1-4
	Y1_TRAFO <= Q1;
	Y2_TRAFO <= Q2;
	Y3_TRAFO <= Q3;
	Y4_TRAFO <= Q4;
	

end Structural;




