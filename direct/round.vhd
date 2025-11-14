----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:03 11/10/2025 
-- Design Name: 
-- Module Name:    round - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity round is
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
end round;

architecture Behavioral of round is
--include modules 
	component xorop
		  Port ( IN1 : in  STD_LOGIC_VECTOR(15 downto 0);
        IN2 : in  STD_LOGIC_VECTOR(15 downto 0);
          OUT1 : out  STD_LOGIC_VECTOR(15 downto 0));
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
	
		signal OM1, OM2, OM3, OM4, OA1, OA2, OA3, OA4, OX1, OX2: STD_LOGIC_VECTOR (15 downto 0); 
	
	begin
	--component net list
	----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:03 11/10/2025 
-- Design Name: 
-- Module Name:    round - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity round is
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
end round;

architecture Behavioral of round is

-- internal signals

	signal OM1, OM2, OM3, OM4, OA1, OA2, OA3, OA4, OX1, OX2: STD_LOGIC_VECTOR (15 downto 0); 


--include modules 
	component xorop
		  Port ( IN1 : in  STD_LOGIC_VECTOR(15 downto 0);
        IN2 : in  STD_LOGIC_VECTOR(15 downto 0);
          OUT1 : out  STD_LOGIC_VECTOR(15 downto 0));
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
begin

		M1: mulop port map(X1, Z1, OM1);
		A1: addop port map(X2, Z2, OA1);
		A2: addop port map(X3, Z3, OA2);
		M2: mulop port map(X4, Z4, OM2);
		
		XOR1: xorop port map(OM1, OA2, OX1);
		XOR2: xorop port map(OA1, OM2, OX2);
		
		M3: mulop port map(OX1, Z5, OM3);
		A3: addop port map(OX2, OM3, OA3);
		M4: mulop port map(OA3, Z6, OM4);
		A4: addop port map(OM3, OM4, OA4);
		
		XOR3: xorop port map(OM1, OM4, Y1);
		XOR4: xorop port map(OA2, OM4, Y2);
		XOR5: xorop port map(OA1, OA4, Y3);
		XOR6: xorop port map(OA4, OM2, Y4);
	
end Behavioral;



	
end Behavioral;


