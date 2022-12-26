----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2022 03:04:06 PM
-- Design Name: 
-- Module Name: AND_GATE - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsissgned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity SEVEN_SEG is
 Port( B0,B1,B2,B3 : in std_logic;
	   A,B,C,D,E,F,G : out std_logic
);
end SEVEN_SEG;

architecture Behavioral of SEVEN_SEG is
begin
A <= NOT((NOT B2 AND NOT B0) OR (NOT B3 AND B1) OR (B2 AND B1) OR (B3 AND NOT B0) OR (NOT B3 AND B2 AND B0) OR (B3 AND NOT B2 AND NOT B1));
B <= NOT((NOT B3 AND NOT B2) OR (NOT B2 AND NOT B0) OR (NOT B3 AND NOT B1 AND NOT B0) OR (NOT B3 AND B1 AND B0) OR (B3 AND NOT B1 AND B0));
C <= NOT((NOT B3 AND NOT B1) OR (NOT B3 AND B0) OR (NOT B1 AND B0) OR (NOT B3 AND B2) OR (B3 AND NOT B2));
D <= NOT((NOT B3 AND NOT B2 AND NOT B0) OR (NOT B2 AND B1 AND B0) OR (B2 AND NOT B1 AND B0) OR (B2 AND B1 AND NOT B0) OR (B3 AND NOT B1 AND NOT B0)); 
E <= NOT((NOT B2 AND NOT B0) OR (B1 AND NOT B0) OR (B3 AND B1) OR (B3 AND B2));
F <= NOT((NOT B1 AND NOT B0) OR (B2 AND NOT B0) OR (B3 AND NOT B2) OR (B3 AND B1) OR (NOT B3 AND B2 AND NOT B1));
G <= NOT((NOT B2 AND B1) OR (B1 AND NOT B0) OR (B3 AND NOT B2) OR (B3 AND B0) OR (NOT B3 AND B2 AND NOT B1));
end Behavioral;
