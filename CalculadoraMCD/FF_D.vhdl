library ieee;
use ieee.std_logic_1164.all;

entity FF_D is
    port ( clk, ld, d: in std_logic;
           reset: in std_logic;
           q: out std_logic);
end FF_D;

architecture arch of FF_D is
    
    begin
        process (clk, reset)
            begin

            if (reset = '1') then
                q <= '0';

            elsif clk = '1' and clk'event then

                if ld = '1' then
                    q <= d;
                end if;

            end if;

        end process;
    
end arch; --arch