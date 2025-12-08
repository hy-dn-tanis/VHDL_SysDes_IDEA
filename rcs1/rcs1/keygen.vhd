----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:05:43 12/08/2025 
-- Design Name: 
-- Module Name:    keygen - Behavioral 
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

entity keygen is
    Port ( round : in  STD_LOGIC_VECTOR(3 downto 0);
           key : in  STD_LOGIC_VECTOR(127 downto 0);
           part_key1 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key2 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key5 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key4 : out  STD_LOGIC_VECTOR(15 downto 0);
           part_key6 : out  STD_LOGIC_VECTOR(15 downto 0));
end keygen;

architecture Behavioral of keygen is

--create an array filled with all 52 partial keys
	type key_array is array(0 to 51) of STD_LOGIC_VECTOR(15 downto 0);
	signal keys: key_array;


begin

	--process to generate partial key (similar to direct implementation)
	partkey_generate: process(key)
	variable input_key : STD_LOGIC_VECTOR(127 downto 0);
	
	begin 
		input_key := key;
		-- generate the partial keys for round module
		for i in 0 to 5 loop --6 cyclic rotations in total
			for j in 0 to 7 loop -- 8 partial key generated per cyclic rotation
				keys(8*i + j) <= input_key((127 - 16*j) downto (112 - 16*j)); --generate 16 bit partial keys and save them in the array
			end loop;
			input_key := input_key(102 downto 0) & input_key(127 downto 103);
		end loop;
		
		--generate output transformation keys
		
		for n in 0 to 3 loop
			keys(48 + n) <= input_key((127 - 16*n) downto (112 - 16*n));
		end loop;
	end process partkey_generate;
	
	
	select_round: process(round)
	begin
	case round is
        when "0000" =>
            part_key1 <= keys(1);
            part_key2 <= keys(2);
            part_key3 <= keys(3);
            part_key4 <= keys(4);
            part_key5 <= keys(5);
            part_key6 <= keys(6);
        when "0001" =>
            part_key1 <= keys(7);
            part_key2 <= keys(8);
            part_key3 <= keys(9);
            part_key4 <= keys(10);
            part_key5 <= keys(11);
            part_key6 <= keys(12);
        -- the following sections use AI to extrapolate the pattern for key generation based on the first two cases
        when "0010" =>
            part_key1 <= keys(13);
            part_key2 <= keys(14);
            part_key3 <= keys(15);
            part_key4 <= keys(16);
            part_key5 <= keys(17);
            part_key6 <= keys(18);
        when "0011" =>
            part_key1 <= keys(19);
            part_key2 <= keys(20);
            part_key3 <= keys(21);
            part_key4 <= keys(22);
            part_key5 <= keys(23);
            part_key6 <= keys(24);
        when "0100" =>
            part_key1 <= keys(25);
            part_key2 <= keys(26);
            part_key3 <= keys(27);
            part_key4 <= keys(28);
            part_key5 <= keys(29);
            part_key6 <= keys(30);
        when "0101" =>
            part_key1 <= keys(31);
            part_key2 <= keys(32);
            part_key3 <= keys(33);
            part_key4 <= keys(34);
            part_key5 <= keys(35);
            part_key6 <= keys(36);
        when "0110" =>
            part_key1 <= keys(37);
            part_key2 <= keys(38);
            part_key3 <= keys(39);
            part_key4 <= keys(40);
            part_key5 <= keys(41);
            part_key6 <= keys(42);
        when "0111" =>
            part_key1 <= keys(43);
            part_key2 <= keys(44);
            part_key3 <= keys(45);
            part_key4 <= keys(46);
            part_key5 <= keys(47);
            part_key6 <= keys(48);
        when "1000" =>
            part_key1 <= keys(49);
            part_key2 <= keys(50);
            part_key3 <= keys(51);
            part_key4 <= keys(52);
            part_key5 <= x"0000";
            part_key6 <= x"0000";
    	when others => --for undefined cases
        	part_key1 <= (others => 'U');
        	part_key2 <= (others => 'U');
        	part_key3 <= (others => 'U');
        	part_key4 <= (others => 'U');
        	part_key5 <= (others => 'U');
        	part_key6 <= (others => 'U');
    end case;
	 end process select_round;


end Behavioral;

