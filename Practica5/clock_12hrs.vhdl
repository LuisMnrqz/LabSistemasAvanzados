library ieee;
use ieee.std_logic_1164.all;

entity clock_12hrs is
    port ( CLK, CLEAR, PRESET, EN: in bit;
           HOURS, MINUTES: out bit_vector(7 downto 0););
end clock_12hrs;

architecture arch of clock_12hrs is
    
    --COMPONENTS
    component counter_1to12 is
        port ( CLK, CLEAR: in bit;
               PRESET: in bit_vector(3 downto 0);
               EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    component counter_0to59 is
        port ( CLK: in bit;
               CLEAR: in bit;
               PRESET: in bit;
               EN: in bit;
               RCO, NCLK: out bit;
               Z: out bit_vector(7 downto 0));
    end component;

    --SEÑALES
    signal RCO_59 : bit;
    signal NCLK_59 : bit;

    begin

        --PORT MAPS
        C1: counter_0to59 port map (CLK, CLEAR, PRESET, EN,RCO_59, NCLK_59, MINUTES);
        C2: counter_1to12 port map (CLK, CLEAR, PRESET, RCO_59, HOURS);

end arch; -- arch