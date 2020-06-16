library ieee;
use ieee.std_logic_1164.all;

entity counter_0to9 is
    port ( CLK, CLEAR: in bit;
           PRESET: in bit_vector(3 downto 0);
           EN: in bit;
           Z: out bit_vector(3 downto 0));
end counter_0to9;
 
architecture arch of counter_0to9 is

    component counter4b is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    --Señales
    signal iQ4: bit_vector(3 downto 0);
    signal clr9 : bit;

    begin

        Z <= iQ4;

        clr9 <= CLEAR and not (iQ4(1) and iQ4(3));

        --PORT MAP
        B: counter4b port map (CLK, clr9, PRESET, EN, iQ4);

end arch; -- arch