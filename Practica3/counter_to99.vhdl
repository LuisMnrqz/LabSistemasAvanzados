library ieee;
use ieee.std_logic_1164.all;

entity counter_to99 is
    port ( UD, CLK: in bit;
          CLEAR, PRESET: in bit_vector(3 downto 0);
          Z: out bit_vector(7 downto 0));
end counter_to99;

architecture arch of counter_to99 is

    component counterDec_2 is
        port ( UD, CLK: in bit;
          CLEAR, PRESET: in bit_vector(3 downto 0);
          EN: in bit;
          Z: out bit_vector(3 downto 0));
    end component;

    --señales
    signal auxEN: bit :='0';
    signal iZ1, iZ2: bit_vector(3 downto 0);

    begin

        --PORT MAPS
        F1: counterDec_2 port map (UD, CLK, CLEAR, PRESET, '1', iZ1);
        F2: counterDec_2 port map (UD, CLK, CLEAR, PRESET, auxEN, iZ2);

        auxEN <= (UD and iZ1(0) and iZ1(3) ) or (not UD and not iZ1(0) and not iZ1(1) and not iZ1(2) and not iZ1(3)); 

        --1
        Z(0) <= iZ1(0);
        Z(1) <= iZ1(1);
        Z(2) <= iZ1(2);
        Z(3) <= iZ1(3);

        --2
        Z(4) <= iZ2(0);
        Z(5) <= iZ2(1);
        Z(6) <= iZ2(2);
        Z(7) <= iZ2(3);

end arch; -- arch