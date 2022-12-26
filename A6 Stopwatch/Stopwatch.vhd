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

entity Stopwatch is
Port (
clk,button1,button2,button3 : in STD_LOGIC;
anode : out STD_LOGIC_VECTOR (3 downto 0); 
A,C,D,E,F,G,H : out std_logic
);

end Stopwatch;

architecture Behavioral of Stopwatch is

signal s : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";
signal B0 : STD_LOGIC_VECTOR (3 downto 0) := "0000"; 
signal B1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal B2 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal B3 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal i : integer := 0 ;
signal j : integer := 0 ;
signal k : integer := 0 ;
signal l : integer := 0 ;
signal m : integer := 0 ;
signal run : integer := 0 ;

begin

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

process(clk)

begin

if(rising_edge(clk)) then
        s <= s + 1;
        if(run = 1) then
            i <= i+1;
            j <= j+1;
            k <= k+1;
            l <= l+1;
        end if;
        if(i = 10000000) then
            i <= 0;
            B0 <= B0 + "0001";
        end if;
        if(B0 = "1010") then
            B0 <= "0000";
        end if;   
        if(j = 100000000) then
            j <= 0;
            B1 <= B1 + "0001";
        end if;
        if(B1 = "1010") then
            B1 <= "0000";
        end if;
        if(k = 1000000000) then
            k <= 0;
            B2 <= B2 + "0001";
        end if;
        if(B2 = "0110") then
            B2 <= "0000";
        end if;  
        if(l = 2000000000) then
            l <= 0; 
            m <= m +1;
        end if;
        if(m = 3) then
            m <=0;
            B3 <= B3 + "0001";
        end if;
        if(B3 = "1010") then
            B3 <= "0000";
        end if; 
        if ( button1 = '1') then
            run <= 1;
        end if;
        if ( button2 = '1') then
            run <= 0;
        end if;
        if(button3 ='1') then
            B0 <= "0000";
            B1 <= "0000";
            B2 <= "0000";
            B3 <= "0000";
            i <= 0 ;
            j <= 0 ;
            k <= 0 ;
            l <= 0 ;
            run <= 0;
        end if;
end if;
end process;

process(s)

begin
case s(14 downto 13) is 
when "00" =>
B(0) <= B0(0);
B(1) <= B0(1);
B(2) <= B0(2);
B(3) <= B0(3);
anode <= "1110";
when "01" =>
B(0) <= B1(0);
B(1) <= B1(1);
B(2) <= B1(2);
B(3) <= B1(3);
anode <= "1101";
when "10" =>
B(0) <= B2(0);
B(1) <= B2(1);
B(2) <= B2(2);
B(3) <= B2(3);
anode <= "1011";
when "11" =>
B(0) <= B3(0);
B(1) <= B3(1);
B(2) <= B3(2);
B(3) <= B3(3);
anode <= "0111";
when others =>
B <= "0000";
anode <= "1110";
end case;

end process;


end Behavioral;