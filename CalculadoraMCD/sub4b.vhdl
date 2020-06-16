library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity sub4b is
    port ( EN: in std_logic; 
           a, b: in std_logic_vector(3 downto 0);
           D: out std_logic_vector(3 downto 0));
end sub4b;

architecture arch of sub4b is
    
    begin

        D <= a when EN='0' 
            else std_logic_vector(unsigned(a) - unsigned(b));

end arch; --arch