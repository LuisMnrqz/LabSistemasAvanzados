library ieee;
use ieee.std_logic_1164.all;

entity freqDiv_Mod60_tb is
end freqDiv_Mod60_tb;

architecture arch of freqDiv_Mod60_tb is

    component freqDiv_Mod60 is
        port ( CLK: in bit;
           Z: out bit);
    end component;

    --señales
    signal Z: bit;
    signal CLK: bit := '0';

    begin

        --PORT MAP
        F: freqDiv_Mod60 port map (CLK, Z);

        --PROCESSING
        CLK_process : process
            begin

                wait for 1 ns;
                CLK <= '0';

                wait for 1 ns;
                CLK <= '1';

        end process;

end arch; --arch