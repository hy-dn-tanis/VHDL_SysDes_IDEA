----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    mulop - Behavioral 
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

entity mulop is
    Port ( I_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O_1 : out  STD_LOGIC_VECTOR (15 downto 0));
end mulop;

architecture Behavioral of mulop is
	signal product: unsigned(31 downto 0);
	signal low: unsigned (15 downto 0);
	signal high: unsigned (15 downto 0);
	signal out_1: unsigned (16 downto 0); -- 17 bits allows overflow (helped by AI)

begin
	product <= unsigned(I_1) * unsigned(I_2);
	low <= product(15 downto 0); -- ab mod 2^n
	high <= product (31 downto 16); -- ab div 2^n
	
	MULOP_PROC: process (low, high)
	begin
		if(low>= high) then
			 out_1 <= ('0' & low) - ('0' & high); -- concatenation with 0 to match bit length is AI generated suggestion
		else
			out_1 <= ('0' & low) + 2**16 + 1 - ('0' & high);
		end if;
	end process MULOP_PROC;
	
	O_1 <= std_logic_vector(out_1(15 downto 0));

end Behavioral;
