--Añadir a la entidad los Generics correspondientes para que esté preparado para cualquier resolución (20)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
    generic ( h_pulse, h_bp, h_display, h_fp: integer; --horizontal
              h_pol: std_logic;
              v_pulse, v_bp, v_display, v_fp: integer; --vertical
              v_pol: std_logic);
    port ( clk: in std_logic;
           rgbIn: in std_logic_vector(2 downto 0); --in
           h_sync, v_sync: out std_logic; --Horizontal, vertical
           rgbOut: out std_logic_vector(2 downto 0));--out
end vga;

architecture arch of vga is

    component vga_sync is
        generic ( h_pulse, hp_bp, h_display, h_fp: integer; --h's
                  h_pol: std_logic;
                  v_pulse, v_bp, v_display, v_fp: integer; --v's
                  v_pol: std_logic);
        port ( clk: in std_logic; --25MHz
               enable: out std_logic;
               column, row: out integer;
               h_sync, v_sync: out std_logic; --syncs (horizontal, vertical)
               clk_vga, video_on: out std_logic);
    end component;

    component vga_pixels_gen is
        port ( clk: in std_logic;
               pixel_x: in integer;
               pixel_y: in integer;
               video_on: in std_logic;
               rgbIn: in std_logic_vector(2 downto 0);
               rgbOut: out std_logic_vector(2 downto 0));
    end component;

    --señales
    signal row, column: integer :=  0 ;
    signal enable, clk_vga, video_on: std_logic  := '0';

    begin
        --PORT/GENERIC MAP
        --Unit under test 1
        UUT1: vga_sync 
            generic map (h_pulse, h_bp, h_display, h_fp, h_pol, v_pulse, v_bp, v_display, v_fp, v_pol)
            port map (clk, enable, column, row, h_sync, v_sync, clk_vga, video_on);
        --Unit under test 2
        UUT2: vga_pixels_gen port map(clk, column, row, video_on, rgbIn, rgbOut);

end arch; -- arch