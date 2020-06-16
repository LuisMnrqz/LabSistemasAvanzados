--Utilizando dos modulos del contador 74F169 realizar un contador ascendente y descendente de 00 a 99 con su respectivo testbench y simulación.
library ieee;
use ieee.numeric_bit.all;

entity c2_74F169 is
    port ( CP, CEP, CET, UD : in bit;
           TC: out bit;
           Q: out bit_vector(7 downto 0));
end c2_74F169;

architecture arch of c2_74F169 is

    component c_74F169 is
        port ( CP, CEP, CET, UD, PE : in bit;
               D: in bit_vector(3 downto 0);
               TC: out bit;
               Q: out bit_vector(3 downto 0));
    end component;

    --señales
    signal iQ: bit_vector(7 downto 0);
    signal iD: bit_vector(3 downto 0);
    signal TC_1, TC_2, TC1, TC2, nTC1, nTC2, iPE1, iPE2: bit;

    begin

        TC1 <= '1' when (to_integer(unsigned(iQ(3 downto 0))) = 9 and UD = '1') or (to_integer(unsigned(iQ(3 downto 0))) = 0 and UD = '0') else '0';
        TC2 <= '1' when (to_integer(unsigned(iQ(7 downto 4))) = 9 and UD = '1') or (to_integer(unsigned(iQ(7 downto 4))) = 0 and UD = '0') else '0';

        nTC1 <= not TC1;
        nTC2 <= not TC2; 
    
        iPE1 <= '0' when TC1 = '1' 
            else '1';

        iPE2 <= '0' when TC1 = '1' and TC2 = '1' 
            else '1';
    
        iD <= "1001" when UD = '0' 
            else "0000";
        
        --PORT MAPS
        E1: c_74F169 port map (CP, CEP, CET, UD, iPE1, iD, TC_1, iQ(3 downto 0));
        E2: c_74F169 port map (CP, nTC1, nTC1, UD, iPE2, iD, TC_2, iQ(7 downto 4));
        
        Q <= iQ;

end arch; -- arch