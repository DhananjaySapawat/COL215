----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2022 11:23:31 PM
-- Design Name: 
-- Module Name: design - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Brightness_SEVEN_SEGMENT is
Port (
clk : in STD_LOGIC;
B0,B1,B2,B3 : in STD_LOGIC_VECTOR (3 downto 0);
anode : out STD_LOGIC_VECTOR (3 downto 0); 
A,C,D,E,F,G,H : out std_logic
);

end Brightness_SEVEN_SEGMENT;

architecture Behavioral of Brightness_SEVEN_SEGMENT is

signal s : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal A1 : STD_LOGIC_VECTOR (3 downto 0) := "1110";
signal A2 : STD_LOGIC_VECTOR (3 downto 0) := "1101";
signal A3 : STD_LOGIC_VECTOR (3 downto 0) := "1011";
signal A4 : STD_LOGIC_VECTOR (3 downto 0) := "0111";
signal A5 : STD_LOGIC_VECTOR (3 downto 0) := "1111";
signal A11 : STD_LOGIC_VECTOR (3 downto 0) := "1110";
signal A12 : STD_LOGIC_VECTOR (3 downto 0) := "1101";
signal A13 : STD_LOGIC_VECTOR (3 downto 0) := "1011";
signal A14 : STD_LOGIC_VECTOR (3 downto 0) := "0111";
signal i: integer := 0;
signal factor: integer := 0;
begin

process(clk)

begin

if(rising_edge(clk)) then        
        i <= i+1;
        if(i > 31) then 
            i<=0 ;
        end if;
        s <= s + 1;
        A11 <= A5;
        A12 <= A5;
        A13 <= A5;
        A14 <= A5;
        if(i < 4) then 
            A11 <= A1;
        end if;
        if(i < 8) then
            A12 <= A2;
        end if;
        if(i < 16) then
            A13 <= A3;
        end if;
        if(i<32) then
            A14 <= A4;
        end if;

end if;
end process;

process(s, B0, B1, B2, B3)

begin

case s(14 downto 13) is 
when "00" =>
B <= B0;
anode <= A11;
when "01" =>
B <= B1;
anode <= A12;
when "10" =>
B <= B2;
anode <= A13;
when "11" =>
B <= B3;
anode <= A14;
when others =>
B <= "0000";
anode <= "1110";
end case;

end process;

process(B)

begin

A <= NOT((NOT B(2) AND NOT B(0)) OR (NOT B(3) AND B(1)) OR (B(2) AND B(1)) OR (B(3) AND NOT B(0)) OR (NOT B(3) AND B(2) AND B(0)) OR (B(3) AND NOT B(2) AND NOT B(1)));
C <= NOT((NOT B(3) AND NOT B(2)) OR (NOT B(2) AND NOT B(0)) OR (NOT B(3) AND NOT B(1) AND NOT B(0)) OR (NOT B(3) AND B(1) AND B(0)) OR (B(3) AND NOT B(1) AND B(0)));
D <= NOT((NOT B(3) AND NOT B(1)) OR (NOT B(3) AND B(0)) OR (NOT B(1) AND B(0)) OR (NOT B(3) AND B(2)) OR (B(3) AND NOT B(2)));
E <= NOT((NOT B(3) AND NOT B(2) AND NOT B(0)) OR (NOT B(2) AND B(1) AND B(0)) OR (B(2) AND NOT B(1) AND B(0)) OR (B(2) AND B(1) AND NOT B(0)) OR (B(3) AND NOT B(1) AND NOT B(0))); 
F <= NOT((NOT B(2) AND NOT B(0)) OR (B(1) AND NOT B(0)) OR (B(3) AND B(1)) OR (B(3) AND B(2)));
G <= NOT((NOT B(1) AND NOT B(0)) OR (B(2) AND NOT B(0)) OR (B(3) AND NOT B(2)) OR (B(3) AND B(1)) OR (NOT B(3) AND B(2) AND NOT B(1)));
H <= NOT((NOT B(2) AND B(1)) OR (B(1) AND NOT B(0)) OR (B(3) AND NOT B(2)) OR (B(3) AND B(0)) OR (NOT B(3) AND B(2) AND NOT B(1)));
 
end process;

end Behavioral;
