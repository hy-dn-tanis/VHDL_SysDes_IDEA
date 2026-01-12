----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:01 11/21/2025 
-- Design Name: 
-- Module Name:    addop - Behavioral 
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

entity addop is
    Port ( IN1,IN2 : in  STD_LOGIC_VECTOR(15 downto 0);
           OUT_SUM : out  STD_LOGIC_VECTOR(15 downto 0));
end addop;

architecture Behavioral of addop is

begin
	ADDOP_PROC: process(IN1, IN2)
	begin
		OUT_SUM <= STD_LOGIC_VECTOR(unsigned(IN1) + unsigned(IN2));
	end process ADDOP_PROC;
end Behavioral;



