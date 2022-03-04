

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity moore is
Port (comb1 : in std_logic;
      comb2 : in std_logic;
      reset : in std_logic;
      enter : in std_logic;
      opens : out std_logic; -- open inutilizzabile diventa opens
      error : out std_logic;
      clk : in std_logic  );
end moore;

architecture fsm of moore is
type st is (init,s0,s1,serror); -- cambiato nome da error a serror
signal state,nstate : st;

begin

comb : process(comb1,comb2,enter,state)
begin
case state is 
when init=> 
        error <= '0';
        opens <= '0';
        if(enter = '1') then
        if(comb1='1') then
        nstate<=s0;
        else if (comb1 = '0') then
        nstate <= serror;
        end if;
        end if;
        else if ( enter = '0') then 
	nstate<= init;
	end if; -- add else if
when s0 =>      
        error<= '0';
        opens <= '0';
        if(enter = '1') then
        if( comb2 = '1') then
        nstate <= s1;
        else if ( comb2 = '0') then
        nstate <= serror;
        end if;
        end if;
        else if (enter = '0') then
	nstate<=s0;
	end if;  -- add elseif
when s1 =>
        opens<= '1';
        error <= '0';
	nstate<= s1; -- add state
when serror =>
        opens <= '0';
        error <= '1';
	nstate<= serror; -- add state
end case;      
end process;

regs : process(clk)
begin
if(rising_edge(clk))then
if(reset = '1') then
state <= init;
else 
state<= nstate; -- ho scrito nexstate
end if;
end if;
end process;   
        

end fsm; -- ho scritto end architecture
