library ieee;
use ieee.std_logic_1164.all;

entity mux_4a1_tb is
end mux_4a1_tb;

architecture arch of mux_4a1_tb is

    component mux_4a1 is 
      port ( A: in bit_vector(3 downto 0);
             S: in bit_vector(1 downto 0);
             Z: out bit);
    end component;

    signal A: bit_vector(3 downto 0);
    signal S: bit_vector(1 downto 0);
    signal Z: bit;

    begin

        M: mux_4a1 port map(A, S, Z);

        process
            begin

                A <= "1110";
                S <= "00";
                wait for 5 ns;

                A <= "0001";
                S <= "00";
                wait for 5 ns;

                A <= "0010";
                S <= "01";
                wait for 5 ns;

                A <= "1000";
                S <= "11";
                wait for 5 ns;

                A <= "0111";
                S <= "11";
                wait for 5 ns;

                A <= "1000";
                S <= "11";
                wait for 5 ns;

                wait;

        end process;

end arch; -- arch