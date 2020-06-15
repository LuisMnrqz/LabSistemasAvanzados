library ieee;
use ieee.std_logic_1164.all;

entity FFJK is
    port ( clk, J, K, preset, clear, E: in bit;
           Q, Qn: out bit);
end FFJK;

architecture arch of FFJK is

    --Señales
    signal iQ: bit;

    begin

        Q <= iQ;
        Qn <= not iQ;

        process(clk, preset, clear)
            begin

            if E = '0' then
                null;

                elsif clear = '0' then
                    iQ <= '0';

                elsif preset = '0' then
                    iQ <= '1';

                elsif (clk = '1') and (clk'event) then
                    
                    if (J = '0') and (K = '0') then
                        iQ <= iQ;

                        elsif (J = '0') and (K = '1') then
                            iQ <= '0';

                        elsif (J = '1') and (K = '0') then
                            iQ <= '1';

                        else
                            iQ <= not iQ;
                    end if;

            end if;

        end process;
end arch; --arch