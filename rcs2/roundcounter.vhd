----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    roundcounter - Behavioral 
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

entity roundcounter is
    Port ( CLK : in  STD_LOGIC;
           START : in  STD_LOGIC;
           RESULT : in  STD_LOGIC;
           READY : out  STD_LOGIC;
           S_i : out  STD_LOGIC;
           INIT : out  STD_LOGIC;
           TRAFO : out  STD_LOGIC;
           ROUND : out  STD_LOGIC_VECTOR (3 downto 0));
end roundcounter;

architecture Behavioral of roundcounter is
	type state is (sleep, calc, setup);
	signal ROUND_i: unsigned(3 downto 0):= "1000"; --
	signal current_state, next_state : state:= sleep; --set initial state to sleep
begin
	
	
	round_count: process(CLK)
	begin
		if rising_edge(CLK) then 
				if (ROUND_i /= "1000") then
					if (RESULT = '1') then
						ROUND_i <= ROUND_i + 1;
					else
						ROUND_i <= ROUND_i;
					end if;
				elsif (ROUND_i = "1000") then
					if (START = '1') then
						ROUND_i <= "0000";
					else
						ROUND_i <= "1000";
					end if;
				end if;
		end if;
	end process;
	
	state_register: process(CLK) -- state register, change state at rising edge of clock
	begin
		if rising_edge(CLK) then
			current_state <= next_state;
		end if;
	end process;
	
	next_state_logic: process(current_state, START, ROUND_i, RESULT)
	begin
		next_state <= current_state;
		case current_state is
			when sleep =>
				INIT <= '0';
				READY <= '1';
				if START = '1' then
					next_state <= setup;
				end if;
			when setup =>
				INIT <= '1';
				READY <= '0';
				next_state <= calc;
			when calc =>
				INIT <= '0';
				READY <= '0';
				if (RESULT = '0') then
					next_state <= calc;
				elsif (RESULT = '1' and ROUND_i = "1000") then
					next_state <= sleep;
				else
					next_state <= setup;
				end if;
		end case;
		
		--select signals
		if (ROUND_i = "0000" or ROUND_i = "1000") then
			S_i <= '1';
		else
			S_i <= '0';
		end if;
		
		--trafo signal enabled only on last round
		if (ROUND_i = "0111") then
			TRAFO <= '1';
		else
			TRAFO <= '0';
		end if;
	end process;
	
	ROUND <= std_logic_vector(ROUND_i);
	
--	round_outputlogic: process(ROUND_i)
--	begin
--		case ROUND_i is
--			when "1000" =>
--				S_i <= '1';
--				TRAFO<= '0';
--			when  "0000" =>
--				S_i <= '1';
--				TRAFO<= '0';
--			when "0001" =>
--				S_i <= '0';
--				TRAFO<= '0';
--			when  "0010" =>
--				S_i <= '0';
--				TRAFO<= '0';
--			when "0011" =>
--				S_i <= '0';
--				TRAFO<= '0';
--			when "0100" =>
--				S_i <= '0';
--				TRAFO<= '0';
--			when "0101" =>
--				S_i <='0';
--				TRAFO<= '0'; 
--			when "0110" =>
--				S_i <= '0';
--				TRAFO<= '0';
--			when "0111" =>
--				S_i <= '0';
--				TRAFO<= '1';
--			when others => 
--				S_i <= '0';
--				TRAFO <= '0';
--		end case;
--	end process;


end Behavioral;