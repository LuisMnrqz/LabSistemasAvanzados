library ieee;
use ieee.numeric_bit.all;

entity c2_74F169_tb is
end c2_74F169_tb;

architecture arch of c2_74F169_tb is

    component c2_74F169 is
        port ( CP, CEP, CET, UD : in bit;
               TC: out bit;
               Q: out bit_vector(7 downto 0));
    end component;

    --Señales
    signal D : bit_vector(7 downto 0);
    signal Q : bit_vector(7 downto 0); 
    signal TC: bit;
    signal CP, CEP, CET, UD : bit := '0';

    begin

        --PORT MAP
        E: c2_74F169 port map (CP, CEP, CET, UD, TC, Q);

        process_1: process --CP
            begin

                CP <= '0';
                wait for 5 ns;

                CP <= '1';
                wait for 5 ns;

        end process;

        process_2: process --PE
            begin

                wait for 200 ns;
                UD<='1';

                wait;

        end process;

end arch; -- arch