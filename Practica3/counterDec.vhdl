library ieee;
use ieee.std_logic_1164.all;

entity counterDec is
    port ( CLK, CLEAR, PRESET, EN: in bit;
           Z: out bit_vector(3 downto 0));
end counterDec;
 
architecture arch of counterDec is

    component Counter4B is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    --Señales
    signal iZ: bit_vector(3 downto 0);
    signal iCLEAR, iPRESET: bit;

    begin
        --PORT MAP
        F: counter4b port map (CLK, iCLEAR, iPRESET, EN, iZ);

        iCLEAR <= CLEAR and (iZ(1) nand iZ(3));

        iPRESET <= PRESET;

        Z <= iZ;

end arch;