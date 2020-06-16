library ieee;
use ieee.std_logic_1164.all;

entity intgGDC is
    port ( clk, reset: in std_logic;
           x, y: in std_logic_vector(3 downto 0);
           dataO: out std_logic_vector(3 downto 0)); --Out
end intgGDC;

architecture arch of intgGDC is

    component datapath is
        port ( x, y: in std_logic_vector(3 downto 0);
               x_sel, y_sel: in std_logic;
               clk: in std_logic;
               x_load, y_load, x_reset, y_reset: in std_logic;
               x_sub, y_sub: in std_logic;
               o_enb, o_reset: in std_logic;
               x_gt_y, x_eq_y, x_lt_y: out std_logic;
               z: out std_logic_vector(3 downto 0));
    end component;

    component controller is
        port ( clk,reset: in std_logic;
               x_gt_y, x_eq_y,x_lt_y: in std_logic;
               x_sel, y_sel: out std_logic; --selector
               x_reset, y_reset: out std_logic; --reset
               x_load, y_load: out std_logic;--loads
               x_sub, y_sub: out std_logic; ---
               o_enb, o_reset: out std_logic); --EN, reset
    end component;
    
    --Señales (std logic)
    signal x_gt_y, x_eq_y, x_lt_y, x_sel, y_sel, x_load, y_load, x_reset, y_reset, x_sub, y_sub, o_enb, o_reset: std_logic;

    begin

        --Controller
        C: controller port map(clk, reset, x_gt_y, x_eq_y, x_lt_y, x_sel, y_sel, x_load, y_load, x_reset, y_reset, x_sub, y_sub, o_enb, o_reset);

        --Datapath
        D: datapath port map(x, y, x_sel, y_sel, clk, x_load, y_load, x_reset, y_reset, x_sub, y_sub, o_enb, o_reset, x_gt_y, x_eq_y, x_lt_y, dataO);

end arch;