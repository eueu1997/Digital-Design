
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
entity tb is
end tb;

architecture Behavioral of tb is
component es3 is
port  ( x: in unsigned(7 downto 0);
       y : in unsigned( 7 downto 0);
       q : out unsigned(7 downto 0);
       r : out unsigned(7 downto 0);
       start,rst,clk : in std_logic;
       ready : out std_logic
 );
 end component;
 component es3_fmd is
port  ( x: in unsigned(7 downto 0);
       y : in unsigned( 7 downto 0);
       q : out unsigned(7 downto 0);
       r : out unsigned(7 downto 0);
       start,rst,clk : in std_logic;
       ready : out std_logic
 );
 end component;
 
 signal x,y,q,q1,r1,r : unsigned ( 7 downto 0);
 signal start,rst,clk,ready,ready1 : std_logic;
 constant clkPeriod : time := 20ns;
begin

uut : es3 port map(x,y,q,r,start,rst,clk,ready);
uut2 : es3_fmd port map(x,y,q1,r1,start,rst,clk,ready1);

clkGen : process 
begin
clk<= '0';
wait for clkPeriod/2;
clk<='1';
wait for clkPeriod/2;
end process;

logicTest : process
begin
rst<= '1';
x<= conv_unsigned(93,8);
y<= conv_unsigned(17,8);
wait for clkPeriod;
rst<='0';
start <= '1';
wait for 2*clkPeriod;
start <= '0';
wait;
end process;
end Behavioral;
