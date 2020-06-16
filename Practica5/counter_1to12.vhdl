library ieee;
use ieee.std_logic_1164.all;

entity counter_1to12 is
    port ( CLK, CLEAR: in bit;
           PRESET: in bit;
           EN: in bit;
           Z: out bit_vector(7 downto 0));
end counter_1to12;

architecture arch of counter_1to12 is

    component FFJK is
        port ( CLK, J, K, PRESET, CLEAR, EN: in bit;
               Q, Qn: out bit);
    end component;

    component counter_0to9 is
        port ( CLK, CLEAR: in bit;
               PRESET: in bit_vector(3 downto 0);
               EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    --señales
    signal auxSet: bit_vector(3 downto 0);
    signal iQ4: bit_vector(3 downto 0);
    signal iQ1, enbF, clr12: bit;
    signal c1: bit := '1';

    begin

        enbF <= EN and iQ4(3) and iQ4(0);

        auxSet <= PRESET & PRESET & PRESET & (PRESET and (iQ1 or iQ4(0) or iQ4(1) or iQ4(2) or iQ4(3))); 

        clr12 <= CLEAR and  not (iQ4(0) and iQ4(1) and iQ1); 

        --PORT MAPS
        C: counter_0to9 port map (CLK, clear0_12, auxSet, EN, iQ4);
        F: FFJK port map (CLK => CLK, J => c1, K => c1, PRESET => PRESET, CLEAR => clr12, Q => iQ1, EN => enbF);

        Z <= "000" & iQ1 & iQ4;

end arch ; -- arch