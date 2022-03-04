library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
entity tb_fmd is
end tb_fmd;

architecture Behavioral of tb_fmd is
component es3_fmd is
port  ( x: in unsigned(7 downto 0);
       y : in unsigned( 7 downto 0);
       q : out unsigned(7 downto 0);
       r : out unsigned(7 downto 0);
       start,rst,clk : in std_logic;
       ready : out std_logic
 );
 end component;
 
 signal x,y,q,r : unsigned ( 7 downto 0);
 signal start,rst,clk,ready : std_logic;
 constant clkPeriod : time := 20ns;
begin

uut : es3_fmd port map(x,y,q,r,start,rst,clk,ready);

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
wait for clkPeriod;
rst<='0';
x<= to_unsigned(93,8);
x<= to_unsigned(17,8);
start <= '1';
wait for 2*clkPeriod;
start <= '0';
wait;
end process;
end Behavioral;
