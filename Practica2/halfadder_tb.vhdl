library ieee;
use ieee.std_logic_1164.all;

entity fulladder_tb is
end fulladder_tb;

architecture arch of fulladder_tb is

    component halfadder is
        port ( S: in bit_vector(1 downto 0);
               Z: out bit_vector(1 downto 0));
    end component;

    signal S, F: bit_vector(1 downto 0);

    begin
        
        --PORT MAP
        HA : halfadder port map (S, Z);

        process

            begin

                S <= "00";
                wait for 5 ns;

                S <= "01";
                Cin <= '1';
                wait for 5 ns;

                S <= "10";
                wait for 5 ns;

                wait;

        end process;

end arch; -- arch