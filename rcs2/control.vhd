----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
    Port ( CLK : in  STD_LOGIC;
           INIT : in  STD_LOGIC;
           TRAFO : in STD_LOGIC;
           EN125 : out  STD_LOGIC;
           EN346 : out  STD_LOGIC;
           EN78 : out  STD_LOGIC;
           RESULT : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(1 downto 0);
           S_T: out STD_LOGIC_VECTOR(1 downto 0));	
end control;

architecture Behavioral of control is
	
	--3 bit counter signal to store internal state
	--initialized with "111" as per instructions
	signal internal_state: unsigned(2 downto 0) := "111"; 

begin

	counter: process(CLK)
   begin
        if rising_edge(CLK) then
            if internal_state = "111" then
                if INIT = '1' then
                    internal_state <= "000";  -- reset when state at 111 and INIT = 1
                else
                    internal_state <= "111";  -- hold at 111 
                end if;
            else
                internal_state <= internal_state + 1; -- increment until 111
            end if;
        end if;
    end process;
		

				
	state_logic: process(internal_state, CLK)
	begin
		case internal_state is
			when "000" =>
				EN125 <= '1';
				EN346 <= '0';
				EN78 <= '0';
				RESULT <= '0';
				S <= "00";
				S_T <= "00";
			when "001" =>
				EN125 <= '0';
				EN346 <= '0';
				EN78 <= '0';
				RESULT <= '0';
				S <= "00";
				S_T <= "00";
			when "010" =>
				EN125 <= '0';
				EN346 <= '1';
				EN78 <= '0';
				RESULT <= '0';
				S <= "01";
				S_T <= "00";
			when "011" =>
				EN125 <= '0';
				EN346 <= '0';
				EN78 <= '0';
				RESULT <= '0';
				S <= "01";
				S_T <= "00";
			when "100" =>
				EN125 <= '0';
				EN346 <= '0';
				EN78 <= '1';
				RESULT <= '0';
				S <= "10";
				S_T <= "00";
			when "101" =>
				EN125 <= '0';
				EN346 <= '0';
				EN78 <= '0';
				RESULT <= '0';
				S <= "10";
				S_T <= "00";
			when "110" =>
				EN125 <= '0';
				EN346 <= '0';
				EN78 <= '0';
				RESULT <= '1';
				S <= "11";
				S_T <= "00";
			when "111" =>
				EN125 <= '0';
				EN346 <= '0';
				EN78 <= '0';
				RESULT <= '0';
				S <= "11";
				S_T <= "00";
			when others =>
				EN125 <= 'X';
				EN346 <= 'X';
				EN78 <= 'X';
				RESULT <= 'X';
				S <= "XX";
				S_T <= "XX";
		end case;
	end process;

end Behavioral;

