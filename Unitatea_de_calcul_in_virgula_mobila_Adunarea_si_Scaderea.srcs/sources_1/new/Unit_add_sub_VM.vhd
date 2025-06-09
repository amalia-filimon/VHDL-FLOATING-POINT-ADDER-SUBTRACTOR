----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 03:25:33 PM
-- Design Name: 
-- Module Name: Unit_add_sub_VM - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Unit_add_sub_VM is
    Port ( numar_1 : in STD_LOGIC_VECTOR (31 downto 0);
           numar_2 : in STD_LOGIC_VECTOR (31 downto 0);
           operatie : in STD_LOGIC;
           rezultat : out STD_LOGIC_VECTOR (31 downto 0);
           depasire_superioara: out STD_LOGIC;
           depasire_inferioara: out STD_LOGIC);
end Unit_add_sub_VM;

architecture Behavioral of Unit_add_sub_VM is

component UAL1 is
    Port ( exponent_1 : in STD_LOGIC_VECTOR (7 downto 0);
           exponent_2 : in STD_LOGIC_VECTOR (7 downto 0);
           bit_semn_diferenta: out STD_LOGIC);
end component;

component Alinierea_mantiselor is
    Port ( exp_mai_mic : in STD_LOGIC_VECTOR (7 downto 0);
           exp_mai_mare : in STD_LOGIC_VECTOR(7 downto 0);
           mantisa_initiala : in STD_LOGIC_VECTOR (46 downto 0);
           mantisa_e_0: out STD_LOGIC;
           mantisa_deplasata : out STD_LOGIC_VECTOR (46 downto 0));
end component;

component UAL2 is
    Port ( bit_semn_1 : in STD_LOGIC;
           bit_semn_2 : in STD_LOGIC;
           mantisa_1 : in STD_LOGIC_VECTOR (46 downto 0);
           mantisa_2 : in STD_LOGIC_VECTOR (46 downto 0);
           mantisa_e_0 : out STD_LOGIC;
           bit_de_semn_final : out STD_LOGIC;
           rezultat : out STD_LOGIC_VECTOR (48 downto 0));
end component;

component Depasire_Mantisa is
    Port ( rezultat_adunare : in STD_LOGIC_VECTOR (48 downto 0);
           exponent_mai_mare_initial: in STD_LOGIC_VECTOR(7 downto 0);
           exponent_mai_mare_incrementat: out STD_LOGIC_VECTOR(7 downto 0);
           mantisa_finala: out STD_LOGIC_VECTOR(47 downto 0); -- rezultatul va fi fara bitul de semn
           depasire_superioara: out STD_LOGIC);
end component;

component Normalizare is
    Port ( suma_mantise : in STD_LOGIC_VECTOR (47 downto 0);
           exponent_initial : in STD_LOGIC_VECTOR (7 downto 0);
           suma_normalizata : out STD_LOGIC_VECTOR (47 downto 0);
           exponent_final : out STD_LOGIC_VECTOR (7 downto 0);
           depasire_inferioara : out STD_LOGIC);
end component;

component Rotunjirea is
    Port ( rezultat_nerotunjit : in STD_LOGIC_VECTOR (47 downto 0);
           rezultat_rotunjit : out STD_LOGIC_VECTOR (22 downto 0));
end component;

signal operand_1: STD_LOGIC_VECTOR(31 downto 0);
signal operand_2: STD_LOGIC_VECTOR(31 downto 0);

signal operand_mai_mare: STD_LOGIC_VECTOR(31 downto 0);
signal operand_mai_mic: STD_LOGIC_VECTOR(31 downto 0);

signal mantisa_aliniata: STD_LOGIC_VECTOR(46 downto 0);

signal mantisa_mai_mica: STD_LOGIC_VECTOR(46 downto 0);
signal mantisa_mai_mare: STD_LOGIC_VECTOR(46 downto 0);

signal mantisa_op_1: STD_LOGIC_VECTOR(45 downto 0);
signal mantisa_op_2: STD_LOGIC_VECTOR(45 downto 0);


signal bit_semn_rezultat: STD_LOGIC;
signal bit_semn_dif_exponenti: STD_LOGIC;

signal mantisa_e_0_la_aliniere: STD_LOGIC;
signal indicator_depasire_superioara_exp: STD_LOGIC;
signal indicator_depasire_inferioara_exp: STD_LOGIC;
signal mantisa_e_0_dupa_adunare_mantise: STD_LOGIC;

signal rezultat_adunare_mantise: STD_LOGIC_VECTOR(48 downto 0);
signal exp_dupa_alg_depasire: STD_LOGIC_VECTOR(7 downto 0);
signal mantisa_inainte_de_normalizare: STD_LOGIC_VECTOR(47 downto 0);
signal exponent_final: STD_LOGIC_VECTOR(7 downto 0);
signal mantisa_normalizata: STD_LOGIC_VECTOR(47 downto 0);
signal mantisa_finala: STD_LOGIC_VECTOR(22 downto 0);


begin

process(operatie, numar_1, numar_2)
begin
     if operatie = '1' then --scadere
         operand_1 <= numar_1;
         operand_2 <= (not numar_2(31)) & numar_2(30 downto 0);
     else                   --adunare
         operand_1 <= numar_1;
         operand_2 <= numar_2;
     end if;
end process;

mantisa_op_1 <= operand_1(22 downto 0) & "00000000000000000000000"; --concatenez 23 de biti
mantisa_op_2 <= operand_2(22 downto 0) & "00000000000000000000000";

process(bit_semn_dif_exponenti, operand_1, operand_2)
begin
     if bit_semn_dif_exponenti = '1' then --nr1 < nr2
           operand_mai_mic <= operand_1;
           operand_mai_mare <= operand_2;
     else                                 --nr1 > nr2
           operand_mai_mic <= operand_2;
           operand_mai_mare <= operand_1;
     end if;
end process;

mantisa_mai_mare <= '1' & operand_mai_mare(22 downto 0) & "00000000000000000000000";  --am concatenat bitul ascuns + mantisa numarului mai mare + 23 de biti de 0
mantisa_mai_mica <= '1' & operand_mai_mic(22 downto 0) & "00000000000000000000000";  --am concatenat bitul ascuns + mantisa numarului mai mic + 23 de biti de 0


UAL_1: UAL1 port map(operand_1(30 downto 23), operand_2(30 downto 23), bit_semn_dif_exponenti);
Aliniere_mantise: Alinierea_mantiselor port map(operand_mai_mic(30 downto 23), operand_mai_mare(30 downto 23), mantisa_mai_mica, mantisa_e_0_la_aliniere, mantisa_aliniata);
UAL_2: UAL2 port map(operand_mai_mare(31), operand_mai_mic(31), mantisa_mai_mare, mantisa_aliniata, mantisa_e_0_dupa_adunare_mantise, bit_semn_rezultat, rezultat_adunare_mantise);
Depasirea_mantisei: Depasire_mantisa port map(rezultat_adunare_mantise, operand_mai_mare(30 downto 23), exp_dupa_alg_depasire, mantisa_inainte_de_normalizare, indicator_depasire_superioara_exp);
Normalizarea: Normalizare port map(mantisa_inainte_de_normalizare, exp_dupa_alg_depasire, mantisa_normalizata, exponent_final, indicator_depasire_inferioara_exp);
Rotunjire: Rotunjirea port map(mantisa_normalizata, mantisa_finala);

process(mantisa_e_0_dupa_adunare_mantise, mantisa_e_0_la_aliniere, bit_semn_rezultat, exponent_final, mantisa_finala)
begin
     if mantisa_e_0_la_aliniere = '0' and mantisa_e_0_dupa_adunare_mantise = '0' then
           rezultat <= bit_semn_rezultat & exponent_final & mantisa_finala;
     elsif mantisa_e_0_la_aliniere = '0' and mantisa_e_0_dupa_adunare_mantise = '1' then 
           rezultat <= "00000000000000000000000000000000";
     elsif mantisa_e_0_la_aliniere = '1' and mantisa_e_0_dupa_adunare_mantise = '0' then 
           rezultat <= operand_mai_mare;
     else 
           rezultat <= "11111111111111111111111111111111"; --daca amebele sunt activate, rezultat null
     end if;
end process;


depasire_superioara <= '1' when indicator_depasire_superioara_exp = '1' else '0';
depasire_inferioara <= '1' when indicator_depasire_inferioara_exp = '1' else '0';

end Behavioral;
