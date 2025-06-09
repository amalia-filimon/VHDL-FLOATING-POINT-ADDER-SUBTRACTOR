----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2022 02:06:08 PM
-- Design Name: 
-- Module Name: Normalizare - Behavioral
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

entity Normalizare is
    Port ( suma_mantise : in STD_LOGIC_VECTOR (47 downto 0);
           exponent_initial : in STD_LOGIC_VECTOR (7 downto 0);
           suma_normalizata : out STD_LOGIC_VECTOR (47 downto 0);
           exponent_final : out STD_LOGIC_VECTOR (7 downto 0);
           depasire_inferioara : out STD_LOGIC);
end Normalizare;

architecture Behavioral of Normalizare is
signal mantisa_in_signal: STD_LOGIC_VECTOR(47 downto 0);
constant len: integer := suma_mantise'length-1;
begin

mantisa_in_signal <= suma_mantise;

process(suma_mantise, exponent_initial)
variable rez: STD_LOGIC_VECTOR(47 downto 0);
variable exp_final: STD_LOGIC_VECTOR (7 downto 0);
variable indicator_depasire: STD_LOGIC;
begin
     rez := suma_mantise;
     exp_final := exponent_initial;
     indicator_depasire := '0';
     depl_stg: for x in 0 to len loop
          if  suma_mantise(len-x) = '0' then 
              rez := std_logic_vector(shift_left(unsigned(rez), 1));
              if exp_final = "00000000" then
                   indicator_depasire := '1';
                   exit depl_stg;
              else 
                   exp_final := std_logic_vector(unsigned(exp_final) - 1);
                   indicator_depasire := '0';
              end if;
          else 
              exit depl_stg;
          end if;
     end loop depl_stg;
    suma_normalizata <= rez;
    exponent_final <= exp_final;
    depasire_inferioara <= indicator_depasire;
end process;

end Behavioral;
