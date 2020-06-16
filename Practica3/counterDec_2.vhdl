library ieee;
use ieee.std_logic_1164.all;

entity counterDec_2 is
    port ( UD, CLK: in bit;
          CLEAR, PRESET: in bit_vector(3 downto 0);
          EN: in bit;
          Z: out bit_vector(3 downto 0));
end counterDec_2;

architecture arch of counterDec_2 is

    component counter4b_2 is
        port ( UD, CLK: in bit;
              CLEAR, PRESET: in bit_vector(3 downto 0);
              EN: in bit;
              Z: out bit_vector(3 downto 0));
    end component;

    --Señales
    signal iZ: bit_vector(3 downto 0);
    signal iCLEAR, iPRESET: bit;

    begin

        F: counter4b_2 port map (UD, CLK, iCLEAR, iPRESET, EN, iZ);
        Z <= iZ;
    
        iPRESET(0) <= PRESET and not (iZ(0) and iZ(1) and iZ(2) and iZ(3));
        iPRESET(1) <= PRESET;
        iPRESET(2) <= PRESET;
        iPRESET(3) <= PRESET and not (iZ(0) and iZ(1) and iZ(2) and iZ(3));
        
        iCLEAR(0) <= CLEAR and not (iZ(1) and iZ(3) and not iZ(0) and not iZ(2));
        iCLEAR(1) <= CLEAR and not ((iZ(1) and iZ(3) and not iZ(0) and not iZ(2)) or (iZ(0) and iZ(1) and iZ(2) and iZ(3)));
        iCLEAR(2) <= CLEAR and not ((iZ(1) and iZ(3) and not iZ(0) and not iZ(2)) or (iZ(0) and iZ(1) and iZ(2) and iZ(3)));
        iCLEAR(3) <= CLEAR and not (iZ(1) and iZ(3) and not iZ(0) and not iZ(2));

end arch; -- arch