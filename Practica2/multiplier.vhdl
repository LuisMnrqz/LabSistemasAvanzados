library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier is
    port ( A, B: in bit_vector(3 downto 0);
           Z: out bit_vector(7 downto 0));
end multiplier;

architecture arch of multiplier is

    --Componentes
    component halfadder is
        port ( S: in bit_vector(1 downto 0);
               F: out bit_vector(1 downto 0));
    end component;

    component fulladder is
        port ( S: in bit_vector(1 downto 0);
               Cin: in bit;
               F: out bit_vector(1 downto 0));
    end component;
    --Fin componentes

    --señales
    signal b1A, b2A, b3A, b4A: bit_vector(3 downto 0);

    signal auxCin: bit_vector(11 downto 0);
    signal auxZ: bit_vector(5 downto 0);

    signal n:bit; 
    --Fin señales

    begin

        b1A(0) <= B(0) and  A(0);   
        b2A(0) <= B(1) and  A(0);

        b1A(1) <= B(0) and  A(1);    
        b2A(1) <= B(1) and  A(1);

        b1A(2) <= B(0) and A(2);    
        b2A(2) <= B(1) and A(2);

        b1A(3) <= B(0) nand A(3);    
        b2A(3) <= B(1) nand A(3);
        
        Z(0) <= b1A(0);

        --P1
        F1: halfadder port map ( S(0) => b2A(0),    S(1) => b1A(1),    Z(0) => Z(1),         Z(1) => auxCin(0) );
        F2: fulladder port map ( S(0) => b2A(1),    S(1) => b1A(2),    Cin => auxCin(0),     Z(0) => auxZ(0),      Z(1) => auxCin(1) );
        F3: fulladder port map ( S(0) => b2A(2),    S(1) => b1A(3),    Cin => auxCin(1),     Z(0) => auxZ(1),      Z(1) => auxCin(2) );
        F4: fulladder port map ( S(0) => b2A(3),    S(1) => '1',       Cin => auxCin(2),     Z(0) => auxZ(2),      Z(1) => auxCin(3) );
        
        b3A(0) <= B(2) and  A(0);
        b3A(1) <= B(2) and  A(1);
        b3A(2) <= B(2) and  A(2);
        b3A(3) <= B(2) nand A(3);
        
        --P2
        F5: halfadder port map ( S(0) => b3A(0),    S(1) => auxZ(0),      Z(0) => Z(2),       Z(1) => auxCin(4) );
        F6: fulladder port map ( S(0) => b3A(1),    S(1) => auxZ(1),      Cin => auxCin(4),   Z(0) => auxZ(3),      Z(1) => auxCin(5) );
        F7: fulladder port map ( S(0) => b3A(2),    S(1) => auxZ(2),      Cin => auxCin(5),   Z(0) => auxZ(4),      Z(1) => auxCin(6) );
        F8: fulladder port map ( S(0) => b3A(3),    S(1) => auxCin(3),    Cin => auxCin(6),   Z(0) => auxZ(5),      Z(1) => auxCin(7) );
        
        b4A(0) <= B(3) nand A(0);
        b4A(1) <= B(3) nand A(1);
        b4A(2) <= B(3) nand A(2);
        b4A(3) <= B(3) and  A(3);

        --P3
        F9:  halfadder port map ( S(0) => b4A(0),      S(1) => auxZ(3),        Z(0) => Z(3),           Z(1) => auxCin(8) );
        F10: fulladder port map ( S(0) => b4A(1),      S(1) => auxZ(4),        Cin => auxCin(8),       Z(0) => Z(4),          Z(1) => auxCin(9) );
        F11: fulladder port map ( S(0) => b4A(2),      S(1) => auxZ(5),        Cin => auxCin(9),       Z(0) => Z(5),          Z(1) => auxCin(10) );
        F12: fulladder port map ( S(0) => b4A(3),      S(1) => auxCin(7),      Cin => auxCin(10),      Z(0) => Z(6),          Z(1) => auxCin(11) );
        F13: halfadder port map ( S(0) => '1'    ,     S(1) => auxCin(11),     Z(0) => Z(7)            Z(1) => n );

end arch; -- arch