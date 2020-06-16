--Entender y diseñar en VHDL un contador binario sincrónico ascendente y descendente de 4 bits, correspondiente al integrado 74F169. Con su testbench respectivo.
library ieee;
use ieee.numeric_bit.all;

entity c_74F169 is
    port ( CP, CEP, CET, UD, PE : in bit;
           D: in bit_vector(3 downto 0);
           TC: out bit;
           Q: out bit_vector(3 downto 0));
end c_74F169;

architecture arch of c_74F169 is

    --señales
    signal iQ : unsigned(3 downto 0) := "0000"; 

    begin

        TC <= '1' when (to_integer(iQ)=0 and UD='0') or (to_integer(iQ) = 15 and UD = '1') 
            else '0';

        Q <= bit_vector(iQ);

        process(CP)
            begin

            if cp = '1' and cp'event then

                if PE = '0' then
                    iQ <= unsigned(D);
                    
                    elsif CEP = '0' and CET = '0' then

                        if UD = '1' then
                            iQ <= iQ + 1;

                            else 
                                iQ <= iQ - 1;

                        end if;

                end if;

            end if;

        end process;

end arch;