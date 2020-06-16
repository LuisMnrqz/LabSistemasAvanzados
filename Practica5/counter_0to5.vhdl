library ieee;
use ieee.std_logic_1164.all;

entity counter_0to5 is
    port( CLK, CLEAR: in bit;
          PRESET: in bit_vector(3 downto 0);
          EN: in bit;
          Z: out bit_vector(3 downto 0));
end counter_0to5;
 
architecture arch of counter_0to5 is

    component counter4b is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    --señales
    signal iQ4: bit_vector(3 downto 0);
    signal clr5 : bit;

    begin

        Z <= iQ4;

        clr5 <= CLEAR and not (iQ4(1) and iQ4(2));

        --PORT MAP
        B4: counter4b port map (CLK, clr5, PRESET, EN,iQ4);

end arch; --arch