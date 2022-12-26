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

entity  DisplayEffect is
Port (
clk : in STD_LOGIC;
button1,button2 : in STD_LOGIC;
B0,B1,B2,B3 : in STD_LOGIC_VECTOR (3 downto 0);
anode : out STD_LOGIC_VECTOR (3 downto 0); 
A,C,D,E,F,G,H : out std_logic

--seg_out : out STD_LOGIC_VECTOR (6 downto 0)
);

end  DisplayEffect;

architecture Behavioral of  DisplayEffect is

signal s : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal A1 : STD_LOGIC_VECTOR (3 downto 0) := "1110";
signal A2 : STD_LOGIC_VECTOR (3 downto 0) := "1101";
signal A3 : STD_LOGIC_VECTOR (3 downto 0) := "1011";
signal A4 : STD_LOGIC_VECTOR (3 downto 0) := "0111";
signal i: integer := 0;
signal S0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal S1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal S2 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal S3 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal factor: integer := 160000000;
signal button: integer := 2;
signal brightness1: integer := 10;
signal brightness2: integer := 70;
signal brightness3: integer := 180;
signal brightness4: integer := 500;
signal h1: integer := 500;
signal j: integer := 0;
signal p: integer := 0;
begin

process(clk)

begin

if(rising_edge(clk)) then
    s <= s + 1;
    i <= i+1;
    j <= j+1;
    p <= p+1;
    if(p<10) then
        button <= 2;
    end if;
    if(button1 = '1') then 
        button <= 1;
        p <= 0;
    end if;
    if(button2 = '1') then 
        button <= 0;
        p <= 0;
    end if;
    if(j > 499) then 
         j <= 0;
    end if;
    A1 <= "1111";
    A2 <= "1111";
    A3 <= "1111";
    A4 <= "1111";
    if(i<factor)then
        if(j < brightness1) then
            A1 <="1110";
        end if;
        if(j < brightness2) then
            A2 <="1101";
        end if;
        if(j < brightness3) then
            A3 <="1011";
        end if;
        if(j < brightness4) then
            A4 <="0111";
        end if;
    end if;
    if(i>factor and i<2*factor) then
        if(j < brightness1) then
            A2<= "1110";
        end if;
        if(j < brightness2) then
            A3 <="1101";
        end if;
        if(j < brightness3) then
            A4 <="1011";
        end if;
        if(j < brightness4) then
            A1 <="0111";
        end if;
    end if;
    if(i>2*factor and i<3*factor) then
        if(j < brightness1) then
            A3 <="1110";
        end if;
        if(j < brightness2) then
            A4 <="1101";
        end if;
        if(j < brightness3) then
            A1 <="1011";
        end if;
        if(j < brightness4) then
            A2 <="0111";
        end if;      
    end if;
    if(i>3*factor and i<4*factor) then

        if(j < brightness1) then
            A4 <="1110";
        end if;
        if(j < brightness2) then
            A1 <="1101";
        end if;
        if(j < brightness3) then
            A2 <="1011";
        end if;
        if(j<brightness4) then
            A3 <="0111";
        end if;
    end if;
    if(i>4*factor) then
        i <= 0;
    end if;
    

end if;
end process;

process(s, B0, B1, B2, B3)

begin
if(button = 0 or button = 2) then 
    case s(14 downto 13) is 
    when "00" =>
    B <= S0;  
    anode <= A1;
    when "01" =>
    B <= S1;
    anode <= A2;
    when "10" =>
    B <= S2;
    anode <= A3;
    when "11" =>
    B <= S3;
    anode <= A4;
    when others =>
    B <= "0000";
    anode <= "1111";
    end case;
end if;
if(button = 1) then
    case s(14 downto 13) is 
    when "00" =>
    B <= B0;
    S0 <= B0;  
    anode <= A1;
    when "01" =>
    B <= B1;
    S1 <= B1;  
    anode <= A2;
    when "10" =>
    B <= B2;
    S2 <= B2;
    anode <= A3;
    when "11" =>
    B <= B3;
    S3 <= B3;
    anode <= A4;
    when others =>
    B <= "0000";
    anode <= "1111";
    end case;
end if;
end process;

process(B,brightness1,brightness2,brightness3,brightness4)

begin
A <= NOT((NOT B(2) AND NOT B(0)) OR (NOT B(3) AND B(1)) OR (B(2) AND B(1)) OR (B(3) AND NOT B(0)) OR (NOT B(3) AND B(2) AND B(0)) OR (B(3) AND NOT B(2) AND NOT B(1)));
C <= NOT((NOT B(3) AND NOT B(2)) OR (NOT B(2) AND NOT B(0)) OR (NOT B(3) AND NOT B(1) AND NOT B(0)) OR (NOT B(3) AND B(1) AND B(0)) OR (B(3) AND NOT B(1) AND B(0)));
D <= NOT((NOT B(3) AND NOT B(1)) OR (NOT B(3) AND B(0)) OR (NOT B(1) AND B(0)) OR (NOT B(3) AND B(2)) OR (B(3) AND NOT B(2)));
E <= NOT((NOT B(3) AND NOT B(2) AND NOT B(0)) OR (NOT B(2) AND B(1) AND B(0)) OR (B(2) AND NOT B(1) AND B(0)) OR (B(2) AND B(1) AND NOT B(0)) OR (B(3) AND NOT B(1) AND NOT B(0))); 
F <= NOT((NOT B(2) AND NOT B(0)) OR (B(1) AND NOT B(0)) OR (B(3) AND B(1)) OR (B(3) AND B(2)));
G <= NOT((NOT B(1) AND NOT B(0)) OR (B(2) AND NOT B(0)) OR (B(3) AND NOT B(2)) OR (B(3) AND B(1)) OR (NOT B(3) AND B(2) AND NOT B(1)));
H <= NOT((NOT B(2) AND B(1)) OR (B(1) AND NOT B(0)) OR (B(3) AND NOT B(2)) OR (B(3) AND B(0)) OR (NOT B(3) AND B(2) AND NOT B(1)));
if(button = 0) then 
      if(B0(1 downto 0 ) =  "11") then 
            brightness1 <= 500 ;
      end if;
      if(B0(1 downto 0 ) =  "10") then 
            brightness1 <= 180 ;
      end if;
      if(B0(1 downto 0 ) =  "01") then 
            brightness1 <= 70 ;
      end if;
      if(B0(1 downto 0 ) =  "00") then 
            brightness1 <= 10 ;
      end if; 
      if(B0(3 downto 2 ) =  "11") then 
            brightness2 <= 500 ;
      end if;
      if(B0(3 downto 2 ) =  "10") then 
            brightness2 <= 180 ;
      end if;
      if(B0(3 downto 2 ) =  "01") then 
            brightness2 <= 70 ;
      end if;
      if(B0(3 downto 2 ) =  "00") then 
            brightness2 <= 10 ;
      end if;
      if(B1(1 downto 0 ) =  "11") then 
            brightness3 <= 500 ;
      end if;
      if(B1(1 downto 0 ) =  "10") then 
            brightness3 <= 180 ;
      end if;
      if(B1(1 downto 0 ) =  "01") then 
            brightness3 <= 70 ;
      end if;
      if(B1(1 downto 0 ) =  "00") then 
            brightness3 <= 10 ;
      end if;       
      if(B1(3 downto 2 ) =  "11") then 
            brightness4 <= 500 ;
      end if;
      if(B1(3 downto 2 ) =  "10") then 
            brightness4 <= 180 ;
      end if;
      if(B1(3 downto 2 ) =  "01") then 
            brightness4 <= 70 ;
      end if;
      if(B1(3 downto 2 ) =  "00") then 
            brightness4 <= 10 ;
      end if;       
end if;
 
end process;

end Behavioral;