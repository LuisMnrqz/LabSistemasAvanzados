library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
    port ( S: in bit_vector(1 downto 0);
           Cin: in bit;
           Z: out bit_vector(1 downto 0));
end fulladder;

architecture arch of fulladder is

    component mux_4a1 is 
    port ( A: in bit_vector(3 downto 0);
           S: in bit_vector(1 downto 0);
           Z: out bit);
    end component;

    signal aux1, aux2: bit_vector(3 downto 0);
    signal nCin: bit;

    begin

        nCin <= not Cin;

        aux1(0) <= Cin;
        aux1(1) <= nCin;
        aux1(2) <= nCin;
        aux1(3) <= Cin;

        A1(0) <= '0';
        A1(1) <= Cin;
        A1(2) <= Cin;
        A1(3)<='1';

        M1 : mux_4a1 port map (A => aux1, S => S, F => Z(0));
        M2 : mux_4a1 port map (A => aux2, S => S, F => Z(1));

end arch; -- arch