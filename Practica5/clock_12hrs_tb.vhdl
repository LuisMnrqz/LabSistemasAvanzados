library ieee;
use ieee.std_logic_1164.all;

entity clock_12hrs_tb is
end clock_12hrs_tb;

architecture arch of ent is

    component clock_12hrs_tb is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               HOURS, MINUTES: out bit_vector(7 downto 0););
    end component;

    --SEÑALES
    signal HOURS, MINUTES: bit_vector(7 downto 0);
    signal CLEAR, PRESET, EN: bit := '1';
    signal CLK: bit := '0';

    begin

        --PORT MAP
        C: clock_12hrs port map (CLK, CLEAR, PRESET, EN, HOURS, MINUTES);

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

end arch; -- arch