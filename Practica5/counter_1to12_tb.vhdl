library ieee;
use ieee.std_logic_1164.all;

entity counter_1to12_tb is
end counter_1to12_tb;

architecture arch of counter_1to12_tb is

    component counter_1to12 is
        port ( CLK, CLEAR: in bit;
               PRESET: in bit;
               EN: in bit;
               Z: out bit_vector(7 downto 0));
    end component;

    --Señales 
    signal Z: bit_vector(7 downto 0);
    signal CLEAR, PRESET, EN: bit := '1';
    signal CLK: bit := '0';

    begin

            --PORT MAP
            C: counter_1to12 port map (CLK, CLEAR, PRESET, EN, Z);

            --PROCESSING
            clk_p: process
                begin

                    wait for 5 ns;
                    CLK <= '0';

                    wait for 5 ns;
                    CLK <= '1';

            end process;

            set_p: process
                begin

                    CLEAR <= '1';
                    wait;

            end process;

end arch ; -- arch