library ieee;
use ieee.std_logic_1164.all;

entity comp is
    port ( x, y : in std_logic_vector(3 downto 0);
           x_gt_y, x_eq_y, x_lt_y : out std_logic);
end comp;

architecture arch of comparator is

    begin
    
        x_gt_y <= '1' when x > y 
            else '0';

        x_eq_y <= '1' when x = y 
            else '0';

        x_lt_y <= '1' when x < y 
            else '0';

end arch; --arch