----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    idea_single - Structural 
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

entity idea_single is
    Port ( CLOCK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           KEY : in  STD_LOGIC_VECTOR (127 downto 0);
           X_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X_4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y_1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y_4 : out  STD_LOGIC_VECTOR (15 downto 0);
           READY : out  STD_LOGIC);
end idea_single;

architecture Structural of idea_single is

component round
   Port ( X1 : in STD_LOGIC_VECTOR(15 downto 0);
           X2 : in  STD_LOGIC_VECTOR(15 downto 0);
           X3 : in STD_LOGIC_VECTOR(15 downto 0);
           X4 : in STD_LOGIC_VECTOR(15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z2 : in STD_LOGIC_VECTOR(15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z5 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z6 : in  STD_LOGIC_VECTOR(15 downto 0);
           Y1 : out STD_LOGIC_VECTOR(15 downto 0);
           Y2 : out STD_LOGIC_VECTOR(15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

component trafo
   Port ( X1 : in  STD_LOGIC_VECTOR(15 downto 0);
           X2 : in  STD_LOGIC_VECTOR(15 downto 0);
           X3 : in  STD_LOGIC_VECTOR(15 downto 0);
           X4 : in  STD_LOGIC_VECTOR(15 downto 0);
           Y1 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y2 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR(15 downto 0);
           Y4 : out STD_LOGIC_VECTOR(15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z2 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR(15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR(15 downto 0));
end component;

component mux2x1
   Port ( S : in  STD_LOGIC;
           D0 : in  STD_LOGIC_VECTOR(15 downto 0);
           D1 : in  STD_LOGIC_VECTOR(15 downto 0);
           O : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

component register_16bit
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR(15 downto 0);
           Q : out  STD_LOGIC_VECTOR(15 downto 0));
			  
end component;

component control
  Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           ROUND : out  STD_LOGIC_VECTOR (3 downto 0);
           READY : out  STD_LOGIC;
           EN : out  STD_LOGIC;
           S : out  STD_LOGIC);
end component;

component keygen
    Port ( round : in  STD_LOGIC_VECTOR(3 downto 0);
           key : in  STD_LOGIC_VECTOR(127 downto 0);
           part_key1 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key2 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key3 : out  STD_LOGIC_VECTOR(15 downto 0);
			  part_key4 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key5 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key6 : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

--create signals

--control unit signals
signal round_sel:STD_LOGIC_VECTOR(3 downto 0);
signal enable, sel, rdy:STD_LOGIC; --outputs from control unit

--en goes to register, sel goes to multiplexer

--round module
signal IN1, IN2, IN3, IN4:STD_LOGIC_VECTOR(15 downto 0); --multiplexer output
signal KEY1, KEY2, KEY3, KEY4, KEY5, KEY6:STD_LOGIC_VECTOR(15 downto 0); --output from keygen and input for round module
signal OUT1, OUT2, OUT3, OUT4:STD_LOGIC_VECTOR(15 downto 0); --becomes the input to the 16 bit register

--register outputs
signal Q1, Q2, Q3, Q4:STD_LOGIC_VECTOR(15 downto 0);

begin

--instantiate components

	cont_mod: control port map(CLOCK, START, round_sel, rdy, enable, sel);
	-- multiplexer selects between plain text input (X_i) and the vectors looped from previous round output saved in the registers (Qi)
	-- multiplexer outputs signal that goes into the round module (INi)
	mux1: mux2x1 port map(sel,X_1, Q1, IN1);
	mux2: mux2x1 port map(sel, X_2,Q2,IN2);
	mux3: mux2x1 port map(sel,X_3,Q3,IN3);
	mux4: mux2x1 port map(sel,X_4,Q4,IN4);
	
	--key generator
	key_gen: keygen port map(round_sel,KEY,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6); --outputs partial key, input for round module
	
	--round module
	--takes the output of the multiplexer, partial keys from key generator, and saves the output into register
	round_mod: round port map(IN1,IN2,IN3,IN4,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,OUT1,OUT2,OUT3,OUT4);
	
	--16 bit register
	R1: register_16bit port map(CLOCK, enable, OUT1, Q1);
	R2: register_16bit port map(CLOCK, enable, OUT2, Q2);
	R3: register_16bit port map(CLOCK, enable, OUT3, Q3);
	R4: register_16bit port map(CLOCK, enable, OUT4, Q4);
	
	--output transformation
	--takes in the keys from keygen, saved values in register from final round, and outputs final cipher text (Y_i)
	output_tf: trafo port map(Q1, Q2, Q3, Q4, Y_1,Y_2,Y_3, Y_4, KEY1, KEY2, KEY3, KEY4);

	READY <= rdy;
end Structural;

