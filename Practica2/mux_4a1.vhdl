library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux_4a1 is
 port(A, B, C, D : in STD_LOGIC;
     S0,S1: in STD_LOGIC;
     S: out STD_LOGIC);
end mux_4a1;

architecture behavior of mux_4a1 is
    begin
    process (A,B,C,D,S0,S1) is
    begin
      if (S0 ='0' and S1 = '0') then
          S <= A;
      elsif (S0 ='1' and S1 = '0') then
          S <= B;
      elsif (S0 ='0' and S1 = '1') then
          S <= C;
      else
          S <= D;
      end if;
     
    end process;
    end behavior;  