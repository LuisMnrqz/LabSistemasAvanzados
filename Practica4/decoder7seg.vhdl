library ieee;
use ieee.std_logic_1164.all;

entity decoder7seg is
    port ( S:in bit_vector(3 downto 0);
           Z:out bit_vector(6 downto 0));
end decoder7seg;

architecture arch of decoder7seg is

    --Señales
    signal A, B, C, D: bit;
    signal ANDs: bit_vector(9 downto 1);

    begin

        --1a4
        A <= S(0);
        B <= S(1);
        C <= S(2);
        D <= S(3);

        --ANDs
        ANDs(1) <= B and D;
        ANDs(2) <= not B and not D;
        ANDs(3) <= C and D;
        ANDs(4) <= not C and not D;
        ANDs(5) <= C and not D;
        ANDs(6) <= not B and C;
        ANDs(7) <= B and not C and D;
        ANDs(8) <= B and not C;
        ANDs(9) <= B and not D;
    
        --out
        Z(0) <= A or C or ANDs(1) or ANDs(2);
        Z(1) <= not B or ANDs(4) or ANDs(3);
        Z(2) <= B or D or not C;
        Z(3) <= A or ANDs(2) or ANDs(7) or ANDs(5) or ANDs(6);
        Z(4) <= ANDs(2) or Ands(5);
        Z(5) <= A or ANDs(4) or ANDs(8) or ANDs(9);
        Z(6) <= A or ANDs(5) or ANDs(8) or ANDs(6);

end arch; -- arch