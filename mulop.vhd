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

-- Uncomment the folab_mod2ning library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the folab_mod2ning library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mulop is
    Port ( I_1 : in  STD_LOGIC_VECTOR (15 downto 0);
           I_2 : in  STD_LOGIC_VECTOR (15 downto 0);
           O_1 : out  STD_LOGIC_VECTOR (15 downto 0));
end mulop;

architecture Behavioral of mulop is
begin
    MULOP_PROC: process (I_1, I_2)
        variable a       : unsigned(16 downto 0);
        variable b       : unsigned(16 downto 0);
        variable ab      : unsigned(33 downto 0);
        variable ab_mod2n: unsigned(15 downto 0);
        variable ab_div2n: unsigned(15 downto 0);
        variable out_1   : unsigned(16 downto 0); -- 17 bit temporary output
    begin
        if(unsigned(I_1) = 0 and unsigned(I_2) = 0) then
            a := to_unsigned(2**16, 17); -- note: 65536
            b := to_unsigned(2**16, 17);
            out_1 := to_unsigned(1, 17);
        else
            if(unsigned(I_1) = 0) then
                a := to_unsigned(2**16, 17);
            else
                a := '0' & unsigned(I_1);
            end if;

            if(unsigned(I_2) = 0) then
                b := to_unsigned(2**16, 17);
            else
                b := '0' & unsigned(I_2);
            end if;

            ab := a * b;
            ab_mod2n := ab(15 downto 0);
            ab_div2n := ab(31 downto 16);

            if(ab_mod2n >= ab_div2n) then
                out_1 := ('0' & ab_mod2n) - ('0' & ab_div2n);
            else
                out_1 := ('0' & ab_mod2n) - ('0' & ab_div2n) + to_unsigned((2**16)+1, 17);
            end if;
        end if;

        -- Assign result to output signal
        O_1 <= std_logic_vector(out_1(15 downto 0));
    end process MULOP_PROC;
end Behavioral;
