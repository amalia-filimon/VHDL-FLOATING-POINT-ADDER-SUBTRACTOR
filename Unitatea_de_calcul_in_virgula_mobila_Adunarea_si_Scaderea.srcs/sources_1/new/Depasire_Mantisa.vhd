----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 01:27:48 PM
-- Design Name: 
-- Module Name: depasire_mantisa - Behavioral
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

entity Depasire_Mantisa is
    Port ( rezultat_adunare : in STD_LOGIC_VECTOR (48 downto 0);
           exponent_mai_mare_initial: in STD_LOGIC_VECTOR(7 downto 0);
           exponent_mai_mare_incrementat: out STD_LOGIC_VECTOR(7 downto 0);
           mantisa_finala: out STD_LOGIC_VECTOR(47 downto 0); -- rezultatul va fi fara bitul de semn
           depasire_superioara: out STD_LOGIC);
end Depasire_Mantisa;

architecture Behavioral of Depasire_Mantisa is
signal rez_add: STD_LOGIC_VECTOR(49 downto 0);
signal rez_nou: STD_LOGIC_VECTOR(49 downto 0);
begin

rez_add <= rezultat_adunare & '0';

process(rez_add, exponent_mai_mare_initial, rez_nou)
begin
      if rez_add(48) = '1' then --am transport
          rez_nou <= std_logic_vector(shift_right(unsigned(rez_add), 1));
          if exponent_mai_mare_initial = "11111111" then --la incrementare apare depasire superioara
                depasire_superioara <= '1';
                exponent_mai_mare_incrementat <= "00000000";
          else 
                depasire_superioara <= '0';
                exponent_mai_mare_incrementat <= std_logic_vector(unsigned(exponent_mai_mare_initial) + 1);
                mantisa_finala <= rez_nou(47 downto 0); --trimit la normalizare: TRS + restul de biti
          end if;
      else 
          mantisa_finala <= rez_add(47 downto 0); --dc nu am TRS trimit: restul de biti + 0
          depasire_superioara <= '0';
          exponent_mai_mare_incrementat <= exponent_mai_mare_initial;
      end if;
end process;

end Behavioral;
