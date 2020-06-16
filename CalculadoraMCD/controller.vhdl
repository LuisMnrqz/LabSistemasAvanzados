library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port ( clk,reset: in std_logic;
           x_gt_y, x_eq_y,x_lt_y: in std_logic;
           x_sel, y_sel: out std_logic; --selector
           x_reset, y_reset: out std_logic; --reset
           x_load, y_load: out std_logic;--loads
           x_sub, y_sub: out std_logic; ---
           o_enb, o_reset: out std_logic); --EN, reset
end controller;

architecture arch of controller is
    --Señalm para estados
    signal state : integer range 1 to 8 := 1;

    begin

        --Secuencial
        SEQ: process(clk,reset)
            begin

                if reset='1' then
                    state <= 1;

                    elsif clk'event and clk='1' then

                    case(state) is

                        when 1 =>
                            state <= 2;

                        when 2 =>
                            state <= 8;

                        when 3 =>
                                state <= 6;

                        when 4 =>
                                state <= 7;

                        when 5 =>
                                null;

                        when 6 =>
                                state <= 2;

                        when 7 =>
                                state <= 2;

                        when 8 =>
                            if x_gt_y = '1' then
                                    state <= 3;

                                    elsif x_lt_y = '1' then
                                    state <= 4;

                                    elsif x_eq_y = '1' then
                                    state <= 5;

                            end if;

                    end case;

                end if;

        end process;
        
        --Combinacional
        COMB: process(state)
            begin

                case(state) is
                    when 1 =>
                        x_sel <= '0';
                        y_sel <= '0';
                        x_load<= '0';
                        y_load<= '0';
                        x_sub <= '0';
                        y_sub <= '0';
                        o_enb <= '0';
                        x_reset <= '1';
                        y_reset <= '1';
                        o_reset <= '1';

                    when 2 =>
                        o_reset <= '0';
                        x_reset <= '0';
                        y_reset <= '0';
                        x_load <= '1';
                        y_load <= '1';
                        x_sub <= '0' after 5 ns;
                        y_sub <= '0' after 5 ns;

                    when 3 =>
                        y_sub <= '0';
                        x_sub <= '1';

                    when 4 =>
                        x_sub <= '0';
                        y_sub <= '1';

                    when 5 =>
                        o_enb <= '1';

                    when 6 =>
                        x_sel <= '1';

                    when 7 =>
                        y_sel <= '1';     
                        
                    when 8 =>
                        x_load <= '0' after 1 ns;
                        y_load <= '0' after 1 ns;

                end case;

        end process;
    
end arch; --arch