----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 07:50:05 PM
-- Design Name: 
-- Module Name: Alinierea_mantiselor - Behavioral
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

entity Alinierea_mantiselor is
    Port ( exp_mai_mic : in STD_LOGIC_VECTOR (7 downto 0);
           exp_mai_mare : in STD_LOGIC_VECTOR(7 downto 0);
           mantisa_initiala : in STD_LOGIC_VECTOR (46 downto 0);
           mantisa_e_0: out STD_LOGIC;
           mantisa_deplasata : out STD_LOGIC_VECTOR (46 downto 0));
end Alinierea_mantiselor;

architecture Behavioral of Alinierea_mantiselor is
constant len: integer := mantisa_initiala'length-1;
begin

process(mantisa_initiala, exp_mai_mic, exp_mai_mare)
variable mantisa: STD_LOGIC_VECTOR(46 downto 0);
variable var_exp_mic: STD_LOGIC_VECTOR(7 downto 0);
variable var_exp_mare: STD_LOGIC_VECTOR(7 downto 0);
begin
    mantisa := mantisa_initiala;
    var_exp_mic := exp_mai_mic;
    var_exp_mare := exp_mai_mare;
    aliniere: for x in 0 to len loop
       if var_exp_mic /= var_exp_mare then
         mantisa := std_logic_vector(shift_right(unsigned(mantisa), 1));
         var_exp_mic := std_logic_vector(unsigned(var_exp_mic) + 1);
       else
         exit aliniere;
       end if;
    end loop;
    
    if mantisa(46 downto 23) = "000000000000000000000000" then -- 24 de biti de 0
         mantisa_e_0 <= '1';
    else 
         mantisa_e_0 <= '0';
    end if;
    
    mantisa_deplasata <= mantisa;

end process;
end Behavioral;
