

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
entity es3 is
Port ( x: in unsigned(7 downto 0);
       y : in unsigned( 7 downto 0);
       q : out unsigned(7 downto 0);
       r : out unsigned(7 downto 0);
       start,rst,clk : in std_logic;
       ready : out std_logic
 );
end es3;

         
architecture hlsm of es3 is
type st is (waits,s0,s1,s2,s3); -- change wait to waits due to keywork
signal state,nstate : st;
signal qr,qrn,rr,rrn : unsigned( 7 downto 0);
begin

combLog : process(state,rr,qr,start,x,y) -- add x and y to sensitivity list

begin

case state is 
when waits => -- change wait to binary_read
            rrn <= x;
            qrn<=(others => '0');
            ready<= '0';
            if(start = '1') then
            nstate<= s0;
            end if; -- forgotten end if
when s0 => if (start = '1') then
            nstate <= s1;
            rrn <= x;
            qrn<=(others => '0');
            else
            nstate <= waits;
            end if;
when s1 => 
            if(rr>=y)then -- >= anziche =
            rrn<= rr-y;
            qrn<=qr+1;
            nstate<=s1;
            else
            nstate<=s2;
            end if;
when s2 =>
            ready <= '1';
            nstate <= s3;
when s3 => ready <= '0';

end case;
end process;

r <= rr;
q<= qr;

regs : process(rst,clk)
begin
if(rst='1')then
state<=waits;
else if(rising_edge(clk))then
state<=nstate;
rr<=rrn;
qr<=qrn;
end if;
end if;
end process;
            
            
            

end hlsm;
