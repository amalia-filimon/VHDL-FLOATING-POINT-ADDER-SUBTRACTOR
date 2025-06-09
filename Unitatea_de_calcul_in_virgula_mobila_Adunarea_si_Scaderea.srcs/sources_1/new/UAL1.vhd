----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2022 01:56:06 PM
-- Design Name: 
-- Module Name: UAL1 - Behavioral
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

entity UAL1 is
    Port ( exponent_1 : in STD_LOGIC_VECTOR (7 downto 0);
           exponent_2 : in STD_LOGIC_VECTOR (7 downto 0);
           bit_semn_diferenta: out STD_LOGIC);
end UAL1;

architecture Behavioral of UAL1 is
signal exp1, exp2: signed(8 downto 0);
signal dif: STD_LOGIC_VECTOR(8 downto 0);
begin
exp1 <= signed('0' & exponent_1);
exp2 <= signed('0' & exponent_2);

dif <= std_logic_vector(exp1 - exp2);

process(dif)
begin
     if dif(8) = '1' then -- atunci exp1 < exp2
         bit_semn_diferenta <= '1';
     else                       -- atunci exp_1 > exp_2
         bit_semn_diferenta <= '0';
     end if;
end process;


end Behavioral;
