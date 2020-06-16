library ieee;
use ieee.numeric_bit.all;

entity c_74F169_tb is
end c_74F169_tb;

architecture arch of c_74F169_tb is

    component c_74F169 is
        port ( CP, CEP, CET, UD, PE : in bit;
               D : in bit_vector(3 downto 0);
               TC: out bit;
               Q : out bit_vector(3 downto 0));
    end component;    

    --señales
    signal D : bit_vector(3 downto 0);
    signal Q : bit_vector(3 downto 0);
    signal CP, CEP, CET, UD, PE : bit := '0';
    signal TC: bit;

    begin

        --PORT MAP
        E: c_74F169 port map(CP, CEP, CET, UD, PE, D, TC, Q);

        process_1: process --CP
            begin
                CP<='0';
                wait for 5 ns;

                CP<='1';
                wait for 5 ns;

        end process;

        process_2: process
            begin
                PE <= '1';
                wait for 115 ns;

                UD <= '1';
                wait for 115 ns;

                D <= "1111";
                PE <= '0';
                wait for 6 ns;

                PE <= '1';
                wait;

        end process;

end arch; -- arch