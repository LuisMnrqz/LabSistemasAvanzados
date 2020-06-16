library ieee;
use ieee.std_logic_1164.all;

entity counter_to99_tb is
end counter_to99_tb;

architecture arch of counter_to99_tb is

    component counter_to99 is
        port ( UD, CLK: in bit;
               CLEAR, PRESET: in bit_vector(3 downto 0);
               Z: out bit_vector(7 downto 0));
    end component;

    --señales
    signal UD, CLK, CLEAR, PRESET: bit := '1';
    signal Z: bit_vector(7 downto 0);

    begin

        --PORT MAP
        F: counter_to99 port map (UD, CLK, CLEAR, PRESET, Z);

        clk_p : process
            begin

                CLK <= '0';
                wait for 5 ns;

                CLK <= '1';
                wait for 5 ns;

        end process;

        set_p : process
            begin

                CLEAR <= '0';
                wait for 5 ns;

                CLEAR <= '1';
                wait for 100 ns;

                UD <= '0';
                wait for 200 ns;

                UD <= '1';
                wait for 110 ns;

                UD <= '0';
                wait;
                
        end process;

end arch; -- arch