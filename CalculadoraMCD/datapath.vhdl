library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port ( x, y: in std_logic_vector(3 downto 0);
           x_sel, y_sel: in std_logic;
           clk: in std_logic;
           x_load, y_load, x_reset, y_reset: in std_logic;
           x_sub, y_sub: in std_logic;
           o_enb, o_reset: in std_logic;
           x_gt_y, x_eq_y, x_lt_y: out std_logic;
           z: out std_logic_vector(3 downto 0));
end datapath;

architecture arch of datapath is

    --components
    component mux is
        port ( x, y: in std_logic_vector(3 downto 0);
               sel: in std_logic;
               res: out std_logic_vector(3 downto 0));
    end component;

    component comp is
        port ( x, y : in std_logic_vector(3 downto 0);
               x_gt_y, x_eq_y, x_lt_y : out std_logic);
    end component;

    component register4b is 
        port ( d_in: in std_logic_vector(3 downto 0);
               clk, ld , reset: in std_logic;
               d_out: out std_logic_vector(3 downto 0));
    end component;

    component sub4b is
        port ( EN: in std_logic; 
           a, b: in std_logic_vector(3 downto 0);
           D: out std_logic_vector(3 downto 0));
    end component;

    --señales
    signal inRx, inRy : std_logic_vector(3 downto 0) := "0000"; --IN
    signal outRx, outRy : std_logic_vector(3 downto 0) := "0000"; --OUT
    signal xNew, yNew : std_logic_vector(3 downto 0) := "0000"; --NEW

    begin

        --PORT MAPS
        --MUX's
        xMUX: mux port map (x, xNew ,x_sel, inRx);
        yMUX: mux port map (y, yNew, y_sel, inRy);
        --REG's
        xREG: register4b port map (inRx, clk, x_load, x_reset, outRx);
        yREG: register4b port map (inRy, clk, y_load, y_reset, outRy);
        --Comparator
        xyC: comp port map (outRx,outRy, x_gt_y, x_eq_y, x_lt_y); 
        --SUBS's
        xSUB: sub4b port map(x_sub, outRx, outRy, xNew);
        ySUB: sub4b port map(y_sub, outRy, outRx, yNew);
        --FinalReg
        REGOUT: register4b port map(outRx, clk,o_enb, o_reset, z);

end arch ; -- arch