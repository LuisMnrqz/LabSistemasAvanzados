library ieee;
use ieee.std_logic_1164.all;

entity counterDec_tb is
end counterDec_tb;

architecture arch of counterDec_tb is

    component counterDec is
        port ( CLK, CLEAR, PRESET, EN: in bit;
            Z: out bit_vector(3 downto 0));
    end component;

    --Señales
    signal CLK: bit := '0';
    signal CLEAR, PRESET, EN: bit := '1';
    signal Z: bit_vector(3 downto 0);

    begin

        F: counterDec port map(CLK, CLEAR, PRESET, EN, Z);

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
                wait;
                
        end process;

end arch; -- arch