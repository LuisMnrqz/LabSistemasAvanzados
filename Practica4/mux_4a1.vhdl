library ieee;
use ieee.std_logic_1164.all;

entity mux_4a1 is
    port ( A: in bit_vector(3 downto 0);
           S: in bit_vector(1 downto 0);
           Z: out bit);
end mux_4a1;

architecture arch of mux_4a1 is

    signal nS: bit_vector(1 downto 0);
    signal aux: bit_vector(3 downto 0);

    begin

        nS(0) <= not S(0);
        nS(1)<= not S(1);

        
        aux(3) <= (A(3) and S(0) and S(1));
        aux(2)<= (A(2) and notS(0) and S(1));
        aux(1) <= (A(1) and notS(1) and S(0));
        aux(0) <= (A(0) and notS(0) and nS(1));

        Z <= (aux(0) or aux(1) or aux(2) or aux(3)); 

end arch;