----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 10:03:54 PM
-- Design Name: 
-- Module Name: UAL2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL2 is
    Port ( bit_semn_1 : in STD_LOGIC;
           bit_semn_2 : in STD_LOGIC;
           mantisa_1 : in STD_LOGIC_VECTOR (46 downto 0);
           mantisa_2 : in STD_LOGIC_VECTOR (46 downto 0);
           mantisa_e_0 : out STD_LOGIC;
           bit_de_semn_final : out STD_LOGIC;
           rezultat : out STD_LOGIC_VECTOR (48 downto 0));
end UAL2;

architecture Behavioral of UAL2 is

signal signed_mantisa_1: signed(48 downto 0);
signal signed_mantisa_2: signed(48 downto 0);
signal op_1: signed(48 downto 0);
signal op_2: signed(48 downto 0);
signal rez: signed(48 downto 0);
begin

signed_mantisa_1 <= signed("00" & mantisa_1);
signed_mantisa_2 <= signed("00" & mantisa_2);

process(bit_semn_1, signed_mantisa_1)
begin
    if bit_semn_1 = '1' then 
         op_1 <= - signed_mantisa_1;
    else 
         op_1 <= signed_mantisa_1;
     end if;
end process;

process(bit_semn_2, signed_mantisa_2)
begin
    if bit_semn_2 = '1' then 
         op_2 <= - signed_mantisa_2;
    else 
         op_2 <= signed_mantisa_2;
     end if;
end process;

rez <= op_1 + op_2;

process(rez)
begin
    if rez(48) = '1' then --am obtinut rezultat negativ si il transform 
        rezultat <= std_logic_vector(- rez);
        rezultat(48) <= '1'; 
        bit_de_semn_final <= '1';
    else 
        rezultat <= std_logic_vector(rez);
        bit_de_semn_final <= '0';
    end if;
end process;

process(rez)
begin
    if rez = "0000000000000000000000000000000000000000000000000" then 
         mantisa_e_0 <= '1';
    else 
         mantisa_e_0 <= '0';
     end if;
end process;

end Behavioral;
