library ieee;
use ieee.std_logic_1164.all;

entity freqDiv_Mod60 is
    port ( CLK: in bit;
           Z: out bit);
end freqDiv_Mod60;

architecture arch of freqDiv_Mod60 is

    --señales
    component counter4b is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component; 

    --Señales
    signal iQ: bit_vector(7 downto 0);
    signal iQ2: bit_vector(3 downto 0);
    signal iQ1: bit_vector(3 downto 0);
    signal auxEnb, clr9: bit;

    begin

        iQ <= iQ2 & iQ1;

        Z <= (iQ(0) and iQ(1) and iQ(3) and iQ(4) and iQ(5));

        auxEnb <= iQ(0) and iQ(1) and iQ(2) and iQ(3);

        clr9 <= not (iQ(2) and iQ(3) and iQ(4) and iQ(5));

        --PORT MAPS
        C1: counter4b port map (CLK, clr9, "1111", '1', iQ1);
        C2: counter4b port map (CLK, clr9, "1111", auxEnb, iQ2);

end arch; --arch