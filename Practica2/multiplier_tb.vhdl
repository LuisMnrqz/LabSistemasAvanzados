library ieee;
use ieee.std_logic_1164.all;

entity multiplier_tb is
end multiplier_tb;

architecture arch of multiplier_tb is

    component multiplier is
        port ( A, B: in bit_vector(3 downto 0);
               Z: out bit_vector(7 downto 0));
    end component;

    --señales
    signal A, B: bit_vector(3 downto 0);
    signal Z: bit_vector(7 downto 0);

    begin

        --PORT MAP
        MP : multiplier port map (A, B, Z);

        process

            begin

                A <= "0001";
                B <= "0001";
                wait for 5 ns;

                A <= "1111";
                B <= "0011";
                wait for 5 ns;

                A <= "0111";
                B <= "0011";
                wait for 5 ns;

                wait;

        end process;

end arch;-- arch