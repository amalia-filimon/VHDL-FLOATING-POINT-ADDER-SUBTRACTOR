----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2022 05:02:54 PM
-- Design Name: 
-- Module Name: Rotunjirea - Behavioral
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

entity Rotunjirea is
    Port ( rezultat_nerotunjit : in STD_LOGIC_VECTOR (47 downto 0);
           rezultat_rotunjit : out STD_LOGIC_VECTOR (22 downto 0));
end Rotunjirea;

architecture Behavioral of Rotunjirea is
begin

rezultat_rotunjit <= rezultat_nerotunjit(46 downto 24);    --fara 1. ... (bitul ascuns)

end Behavioral;
