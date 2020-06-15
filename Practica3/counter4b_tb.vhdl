library ieee;
use ieee.std_logic_1164.all;

entity counter4b_tb is
end counter4b_tb;
     
architecture arch of counter4b_tb is

    component counter4b is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               Z: out bit_vector(3 downto 0));
    end component;

    --Señales
    signal CLK: bit := '0';
    signal CLEAR, PRESET, EN: bit := '1';
    signal Z: bit_vector(3 downto 0); 

    begin

        --PORT MAP
        F: counter4b port map(CLK, CLEAR, PRESET, EN, Z);

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
                wait for 5 ns;

                wait;
        end process;

end arch; -- arch