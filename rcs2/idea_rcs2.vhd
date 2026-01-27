----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    idea_rcs2 - Structural 
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

entity idea_rcs2 is
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
end idea_rcs2;

architecture Structural of idea_rcs2 is


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

component roundcounter
	 Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           RESULT : in  STD_LOGIC;
           READY : out  STD_LOGIC;
           S_i : out  STD_LOGIC;
           INIT : out  STD_LOGIC;
           TRAFO : out  STD_LOGIC;
           ROUND : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component clockedround
	    Port ( CLK : in  STD_LOGIC;
           INIT : in  STD_LOGIC;
           TRAFO : in STD_LOGIC;
           X1 : in  STD_LOGIC_VECTOR (15 downto 0);
           X2 : in  STD_LOGIC_VECTOR (15 downto 0);
           X3 : in  STD_LOGIC_VECTOR (15 downto 0);
           X4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z3 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z4 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z5 : in  STD_LOGIC_VECTOR (15 downto 0);
           Z6 : in  STD_LOGIC_VECTOR (15 downto 0);
           Y1 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y2 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y3 : out  STD_LOGIC_VECTOR (15 downto 0);
           Y4 : out  STD_LOGIC_VECTOR (15 downto 0);
           RESULT : out STD_LOGIC;
           Y1_TRAFO : out  STD_LOGIC_VECTOR (15 downto 0);
           Y2_TRAFO : out  STD_LOGIC_VECTOR (15 downto 0);
           Y3_TRAFO : out  STD_LOGIC_VECTOR (15 downto 0);
           Y4_TRAFO : out  STD_LOGIC_VECTOR (15 downto 0));
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

--signals
signal Y1_CALC, Y2_CALC, Y3_CALC, Y4_CALC : STD_LOGIC_VECTOR(15 downto 0); --output of each round module saved in registers R1-R4
signal Q1, Q2, Q3, Q4: STD_LOGIC_VECTOR(15 downto 0); --output of registers 1-4
signal X1_MUX, X2_MUX, X3_MUX, X4_MUX: STD_LOGIC_VECTOR(15 downto 0); --output of multiplexer, input to clocked round

signal PK1, PK2, PK3, PK4, PK5, PK6: STD_LOGIC_VECTOR(15 downto 0); -- partial keys
signal RES: STD_LOGIC; --result signal from clocked round
signal S_i: STD_LOGIC; --select signal for 2x1 multiplexers
signal INIT: STD_LOGIC;
signal TRAFO: STD_LOGIC;
signal ROUND : STD_LOGIC_VECTOR(3 downto 0); --4 bit signal for round, outputted from round counter, input to keygen

begin
 

--concurrent structural assignments 

	clocked_round_mod: clockedround port map(CLOCK, INIT, TRAFO, X1_MUX, X2_MUX, X3_MUX, X4_MUX
															,PK1, PK2, PK3, PK4, PK5, PK6,
															Y1_CALC, Y2_CALC, Y3_CALC, Y4_CALC, RES, Y_1, Y_2, Y_3, Y_4);
															
	round_counter_mod : roundcounter port map(CLOCK, START, RES,READY, S_i, INIT, TRAFO, ROUND);
		
	keygen_mod: keygen port map(ROUND,KEY, PK1, PK2, PK3, PK4, PK5, PK6);
	
	MUX1: mux2x1 port map(S_i,Q1,X_1,X1_MUX);
	MUX2: mux2x1 port map(S_i,Q2,X_2,X2_MUX);
	MUX3: mux2x1 port map(S_i,Q3,X_3,X3_MUX);
	MUX4: mux2x1 port map(S_i,Q4,X_4,X4_MUX);
	
	REG1: register_16bit port map(CLOCK,RES,Y1_CALC, Q1);
	REG2: register_16bit port map(CLOCK,RES,Y2_CALC, Q2);
	REG3: register_16bit port map(CLOCK,RES,Y3_CALC, Q3);
	REG4: register_16bit port map(CLOCK,RES,Y4_CALC, Q4);
	
end Structural;

