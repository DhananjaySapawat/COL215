----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2022 04:18:30 PM
-- Design Name: 
-- Module Name: lab7 - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Transmitter is
Port (
    RsRx: IN std_logic;
    reset : IN std_logic;
    clk : IN std_logic;
    anode : out STD_LOGIC_VECTOR (3 downto 0); 
    A,C,D,E,F,G,H: out STD_LOGIC;
    RsTx : out std_logic
    );
end Transmitter;

architecture Behavioral of Transmitter is

signal t : integer := 0;
signal new_clk : std_logic;
signal store_reg : std_logic_vector(0 to 7);
signal reg : std_logic_vector(0 to 8);
TYPE state_type is (Idle_State, Start_State, Serial_State, Stop_State, Start_Out_State, Serial_Out_State, Stop_Out_State);
signal Rx_state : state_type := Idle_State;
signal checked_bits : std_logic_vector(3 downto 0) :=  "0000";
signal j : integer := 1;
signal B : std_logic_vector(3 downto 0) ;
signal i : std_logic_vector(3 downto 0) := "0000" ;
signal s: STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
begin

process(clk)
    begin
        -- here we change new clock after 650 clock sets of input clock
        if(clk'event and clk = '1') then
        t <= t +1;
        if(t = 325) then
            new_clk <= '1';
        end if;
        if(t = 650) then
            new_clk <= '0';
            t <= 0;
        end if;
      end if;
end process;

process(clk)
begin
    if(rising_edge(clk)) then
        s <= s + 1;
    end if;
end process;


process(RsRx, new_clk, reset)
begin
if(new_clk'event and new_clk = '1') then 
    -- If reset button was press then the system will go in idle state 
    if(reset = '1') then
        Rx_state <= Idle_State;
        reg(1 to 8)  <= "00000000";
    else
    
    CASE Rx_state is 
        -- If System is in idle state then it will read 0 value and go in start state
        when Idle_State =>
            if(RsRx = '0') then
                i <= "0000";
                checked_bits <= "0000";
                j <= 1;
                Rx_state <= Start_State;
            end if; 
        -- If System is in start state then it will read 0 value 6 times and go in serial state           
        when Start_State =>
            if (RsRx = '0') then
                i <= i + "0001";
                if(i = "0110") then
                    Rx_state <= Serial_State;
                    i <= "0000";
                    checked_bits<="0000"; 
                 end if;
            end if; 
        -- If System is in serial state then it will read 8 bits (each 16 times) and go in stop state
        when Serial_State =>
            i <= i + "0001";
            if(i = "1111") then
                reg(j) <=  RsRx;
                j <= j + 1;
                i <= "0000";
                checked_bits <= checked_bits + "0001";
            end if;
            if(checked_bits = "1000") then
                checked_bits <= "0000";
                Rx_state <= Stop_State;
            end if;
        -- If System is in stop state then it will read 1 bit 16 times,give all variable there initsl value,store reg value in Rx_Store and go in start_out state
        when Stop_State => 
            i <= i + "0001";
            if(i = "1111") then
               i <= "0000";
               j <= 1;
               checked_bits <= "0000";
               store_reg <= reg(1 to 8);
               Rx_state <= Start_Out_State;
            end if;
        -- If System is in start_out then it will transmit 0 value 15 times and go in serial_out state.
        when Start_Out_State =>     
                i <= i + "0001";  
                RsTx <= '0';
                if(i = "1111") then
                    i <= "0000";
                    Rx_state <= Serial_Out_State;
                end if;      
        -- If System is in serial_out state then it will transmit 8 bits (each 16 times) and go in stop_out state
        when Serial_Out_State =>  
                i <= i + "0001";  
                RsTx <= store_reg(j-1);
                if(i = "1111") then
                     i <= "0000";
                     j <= j + 1;
                     checked_bits <= checked_bits + "0001";
                end if; 
                if(checked_bits = "1000") then
                     checked_bits <= "0000";
                     i <= "0000";
                     j <= 1;
                     Rx_state <= Stop_Out_State;
                 end if;
        -- If System is in stop_out state then it will transmit value 1 16 times,give all variable there inital value and go in idle state 
        when Stop_Out_State => 
                 i <= i + "0001";  
                 RsTx <= '1';
                 if(i = "1111") then
                     i <= "0000";
                     Rx_state <= Idle_State;
                 end if;       
      end case;
      end if;
   end if;
   end process;
   
   
   
process(B)
   -- displaying B value in seven segment display   
   begin
   A <= NOT((NOT B(2) AND NOT B(0)) OR (NOT B(3) AND B(1)) OR (B(2) AND B(1)) OR (B(3) AND NOT B(0)) OR (NOT B(3) AND B(2) AND B(0)) OR (B(3) AND NOT B(2) AND NOT B(1)));
   C <= NOT((NOT B(3) AND NOT B(2)) OR (NOT B(2) AND NOT B(0)) OR (NOT B(3) AND NOT B(1) AND NOT B(0)) OR (NOT B(3) AND B(1) AND B(0)) OR (B(3) AND NOT B(1) AND B(0)));
   D <= NOT((NOT B(3) AND NOT B(1)) OR (NOT B(3) AND B(0)) OR (NOT B(1) AND B(0)) OR (NOT B(3) AND B(2)) OR (B(3) AND NOT B(2)));
   E <= NOT((NOT B(3) AND NOT B(2) AND NOT B(0)) OR (NOT B(2) AND B(1) AND B(0)) OR (B(2) AND NOT B(1) AND B(0)) OR (B(2) AND B(1) AND NOT B(0)) OR (B(3) AND NOT B(1) AND NOT B(0))); 
   F <= NOT((NOT B(2) AND NOT B(0)) OR (B(1) AND NOT B(0)) OR (B(3) AND B(1)) OR (B(3) AND B(2)));
   G <= NOT((NOT B(1) AND NOT B(0)) OR (B(2) AND NOT B(0)) OR (B(3) AND NOT B(2)) OR (B(3) AND B(1)) OR (NOT B(3) AND B(2) AND NOT B(1)));
   H <= NOT((NOT B(2) AND B(1)) OR (B(1) AND NOT B(0)) OR (B(3) AND NOT B(2)) OR (B(3) AND B(0)) OR (NOT B(3) AND B(2) AND NOT B(1))); 
   
end process;

   
process(s)
begin
       -- Assigning value to B and anode
       case s(15) is
       when '0' =>
           anode <= "1110"; 
           B(0) <= reg(1);
           B(1) <= reg(2);
           B(2) <= reg(3);
           B(3) <= reg(4);
       when '1' =>
           anode <= "1101"; 
           B(0) <= reg(5);
           B(1) <= reg(6);
           B(2) <= reg(7);
           B(3) <= reg(8);
       when others =>
           anode <= "1111";
           B <= "0000";
       end case;
   end process;     

end Behavioral;