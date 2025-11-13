----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:39 11/06/2025 
-- Design Name: 
-- Module Name:    xorop - Behavioral 
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

entity xorop is
    Port ( IN1 : in  STD_LOGIC_VECTOR(15 downto 0);
           IN2 : in  STD_LOGIC_VECTOR(15 downto 0);
           OUT1 : out  STD_LOGIC_VECTOR(15 downto 0));
end xorop;

architecture Behavioral of xorop is

begin
	XOROP: process(IN1, IN2)
	begin
		OUT1 <= IN1 xor IN2;
	end process XOROP;
end Behavioral;