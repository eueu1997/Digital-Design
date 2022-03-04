

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb is
end tb;

architecture Behavioral of tb is
component moore is
Port (comb1 : in std_logic;
      comb2 : in std_logic;
      reset : in std_logic;
      enter : in std_logic;
      opens : out std_logic; -- open keyword diventa opens
      error : out std_logic;
      clk : in std_logic  );
end component;
signal comb1,comb2,reset,enter,opens,error,clk : std_logic;
constant clkp : time := 10 ns;
begin
uut : moore port map ( comb1,comb2,reset,enter,opens,error,clk);
 
clockGen : process
begin
clk <= '0';
wait for clkp/2;
clk <= '1';
wait for clkp/2;
end process;

test : process 
begin
reset <='1';
wait for clkp;
reset<= '0';
comb1<='1';
enter <= '1';
wait for clkp;
comb1<= '0';
enter<='0';
wait for clkp;
comb2<= '1';
enter<='1';
wait for clkp;
comb2<= '0';
enter <= '0';
wait for clkp;
reset<='1';
wait for clkp;
reset<= '0';
comb1<='1';
enter <= '1';
wait for clkp;
comb1<= '0';
enter<='0';
wait for clkp;
comb2<= '0';
enter<='1';
wait for clkp;
comb2<= '0';
enter <= '0';
wait for clkp;
reset<='1';
wait for clkp;
wait;
end process;

end Behavioral;
