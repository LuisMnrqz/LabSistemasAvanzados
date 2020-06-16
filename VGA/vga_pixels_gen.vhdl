library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_pixels_gen is
    port ( clk: in std_logic;
           pixel_x: in integer;
           pixel_y: in integer;
           video_on: in std_logic;
           rgbIn: in std_logic_vector(2 downto 0);
           rgbOut: out std_logic_vector(2 downto 0));
end vga_pixels_gen;

architecture arch of vga_pixels_gen is

    begin

        process 
            begin 

                wait until clk = '1'and clk'event;
                
                rgbOut <= rgbIn and video_on & video_on & video_on;

    end process;

end arch;