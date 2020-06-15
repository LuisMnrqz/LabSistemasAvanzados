library ieee;
use ieee.std_logic_1164.all;

entity fulladder_tb is
end fulladder_tb;

architecture arch of fulladder_tb is

    component fulladder is
        port ( S: in bit_vector(1 downto 0);
               Cin: in bit;
               Z: out bit_vector(1 downto 0));
    end component;

    signal S, Z: bit_vector(1 downto 0);
    signal Cin: bit;

    begin
        
        --PORT MAP
        FA : fulladder port map (S, Cin, Z);

        process

            begin

                S <= "01";
                Cin <= '1';
                wait for 5 ns;

                S <= "10";
                Cin <= '1';
                wait for 5 ns;

                S <= "00";
                Cin <= '1';
                wait for 5 ns;

                wait;

        end process;

end arch; -- arch