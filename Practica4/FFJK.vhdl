library ieee;
use ieee.std_logic_1164.all;

entity FFJK is
    port ( CLK, J, K, PRESET, CLEAR, EN: in bit;
           Q, Qn: out bit);
end FFJK;

architecture arch of FFJK is

    --Señales
    signal iQ: bit;

    begin

        Q <= iQ;
        Qn <= not iQ;

        process (CLK, PRESET, CLEAR)
            begin

            if EN = '0' then
                null;

                elsif CLEAR = '0' then
                    iQ <= '0';

                elsif PRESET = '0' then
                    iQ <= '1';

                elsif (CLK = '1') and (CLK'event) then
                    
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