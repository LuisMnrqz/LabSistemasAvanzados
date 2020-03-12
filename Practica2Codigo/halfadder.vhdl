library ieee;
use ieee.std_logic_1164.all;

entity halfadder is
  port(a, b: in std_logic;
       suma, carry: out std_logic); 
end halfadder;

architecture dataflow of halfadder is 
  begin
  suma<= a xor b;
  carry<= a and b; 
end dataflow;