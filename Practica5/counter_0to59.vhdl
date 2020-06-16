library ieee;
use ieee.std_logic_1164.all;

entity counter_0to59 is
    port ( CLK: in bit;
           CLEAR: in bit;
           PRESET: in bit;
           EN: in bit;
           RCO, NCLK: out bit;
           Z: out bit_vector(7 downto 0));
end counter_0to59;

architecture arch of counter_0to59 is

    --COMPONENTS
    component counter_0to5 is
        port( CLK, CLEAR: in bit;
          PRESET: in bit_vector(3 downto 0);
          EN: in bit;
          Z: out bit_vector(3 downto 0));
    end component;

    component counter_0to9 is
        port ( CLK, CLEAR: in bit;
               PRESET: in bit_vector(3 downto 0);
               EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    --Señales
    signal iQ: bit_vector(7 downto 0);
    signal set: bit_vector(3 downto 0);
    signal enbC5, clr5, clr9: bit;

    begin

        set <= PRESET & PRESET & PRESET & PRESET; 

        enbC5 <= EN and iQ(0) and iQ(3);

        RCO <= enbC5 and iQ(4) and iQ(6); 

        clr9 <= CLEAR and  not ( (iQ(5) and iQ(6)) or (iQ(1) and iQ(3)) ); 

        clr5 <= CLEAR and  not (iQ(5) and iQ(6)); 

        --PORT MAPS
        C1: counter_0to5 port map(CLK, clr5, set, enbC5, iQ(7 downto 4));
        C2: counter_0to9 port map(CLK, clr9, set, EN, iQ(3 downto 0));

        Z <= iQ;

        NCLK <= '1' when to_integer(unsigned(iQ(7 downto 4))) < 3 
            else '0';

end arch ; -- arch