library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_sync is
    generic ( h_pulse, hp_bp, h_display, h_fp: integer; --h's
              h_pol: std_logic;
              v_pulse, v_bp, v_display, v_fp: integer; --v's
              v_pol: std_logic);
    port ( clk: in std_logic; --25MHz
           enable: out std_logic;
           column, row: out integer;
           h_sync, v_sync: out std_logic; --syncs (horizontal, vertical)
           clk_vga, video_on: out std_logic);
end vga_sync;


architecture arch of vga_sync is
    --counts
    signal h_count : integer range 0 to h_period -1 := 0; --horizontal count
    signal v_count : integer range 0 to v_period -1 := 0; --vertical count
    --video
    signal video_on_h : std_logic; --horizontal video
    signal video_on_v : std_logic; --vertical video
    --Periods
    constant h_period : integer := h_pulse + h_bp + h_display + h_fp; --horizontal period
    constant v_period : integer := v_pulse + v_bp + v_display + v_fp; --vertical period

    begin

        clk_vga <= clk;
        video_on <= video_on_h and video_on_v;

        process

            begin

                -------------------------------------------------------------
                --Horizontal Sync
                if h_count < h_display + h_fp or h_count >= h_display + h_fp + h_pulse then
                    h_sync <= not h_pol;

                    else
                        h_sync <= h_pol;
                end if;
                -------------------------------------------------------------
                
                -------------------------------------------------------------
                --Vertical Sync
                if v_count < v_display + v_fp or v_count >= v_display + v_fp + v_pulse then
                    v_sync <= not v_pol;

                    else
                        v_sync <= v_pol;
                end if;
                -------------------------------------------------------------

                -------------------------------------------------------------
                if h_count < h_display then 
                    column <= h_count;
                end if;
                
                if v_count < v_display then 
                    row <= v_count;
                end if;
                
                if h_count < h_display and v_count < v_display then 
                    enable <= '1';

                    else 
                        enable <= '0';
                end if;
                -------------------------------------------------------------
                
                -------------------------------------------------------------
                if h_count <= h_display - 1 then
                    video_on_h <= '1';

                    else
                        video_on_h <= '0';
                end if;

                if v_count <= v_display - 1 then
                    video_on_v <= '1';

                    else
                        video_on_v <= '0';
                end if;
                -------------------------------------------------------------

        end process;

end arch; --arch