----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2022 12:38:30
-- Design Name: 
-- Module Name: es3_fmd - Behavioral
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
use ieee.std_logic_arith.all;


entity es3_fmd is
Port ( x: in unsigned(7 downto 0);
       y : in unsigned( 7 downto 0);
       q : out unsigned(7 downto 0);
       r : out unsigned(7 downto 0);
       start,rst,clk : in std_logic;
       ready : out std_logic
 );
end es3_fmd;

architecture fsm of es3_fmd is
signal rr,qr,rrn,qrn: UNSIGNED(7 downto 0);
type st is ( waits,s0,s1,s2,s3);
signal state,nstate:st;
signal load : std_logic;
begin
-- datapath--
r<= rr;
q<=qr;
combLog : process(rr,qr,y)
begin
rrn<= rr-y;
qrn<=qr+1;
end process;

regs : process(clk,rst)
begin -- agginto begin
if(rst = '1')then
rr<= x;
qr <= (others => '0');
else if ( rising_edge(clk))then
if(load='1')then
rr<= rrn;
qr<=qrn;
end if;
end if;
end if;
end process;
-- controller--
combLogC : process(state,rr,x,y,start ) -- aggiunto rr, start
begin
case state is
when waits =>
            load<='0';
            ready<='0';
            if(start='1')then
            nstate<=s0;
            else
            nstate<=waits;
            end if;-- end added
when s0 => if(start='1')then
            nstate<=s1;
            else nstate<= waits;
            end if;
            load <= '0';
            ready<= '0'; -- added
when s1 => if(rr >= y) then
            load<= '1';
            nstate<=s1;
            ready<='0'; -- added
            else
            load<='0';
            nstate<=s2;
            ready<= '1';
            end if; -- added end if;
when s2 =>  nstate <=s3;
            ready<= '1';--added
            load<= '0';
when s3 => ready <='0';   
end case;
end process;
regsC : process(rst,clk)
begin
    if(rst='1')then
    state<=waits;
    else if(rising_edge(clk))then
    state<=nstate;
    end if;
    end if;
    end process;
end fsm;
