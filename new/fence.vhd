

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fence is
Port (  clk,rst,a,dw_lmt,up_lmt : in std_logic;
        mot_up,mot_dw : out std_logic);
end fence;

architecture Behavioral of fence is
type statetype is (opened,lowering,rising,closed,p_open);
signal state,statenext,laststate : statetype;
begin

combLog : process(state,a,dw_lmt,up_lmt)
begin
case state is
when opened =>
        mot_up<= '0';
        mot_dw<= '0';
        if(a='1') then
        statenext <= lowering;
        else if ( a='0') then
        statenext <= opened;
        end if;
        end if;
when lowering =>
        mot_dw <= '1';
        mot_up <= '0';
        if(dw_lmt = '1') then
        statenext <= closed;
        else if ( a = '1') then 
        statenext <= lowering;
        else if ( a = '0') then 
        statenext <= rising;
        end if;
        end if;
        end if;
        
     
when closed => 
        mot_up <= '0';
        mot_dw <= '0';
        
when rising =>
        mot_up <= '1';
        mot_dw <= '0';
        
when p_open =>
        mot_dw <= '0';
        mot_up <= '0';
end case;
end process;

regs : process( clk,rst)
begin

end process;

end Behavioral;
