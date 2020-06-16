library ieee;
use ieee.numeric_bit.all;

entity c_ShiftReg8b_tb is
end c_ShiftReg8b_tb;

architecture arch of ent is

    component c_ShiftReg8b_tb is
        port ( clk, clr, s0, s1, sdr, sdl : in bit;
               D: in bit_vector(7 downto 0);
               Z: out bit_vector(7 downto 0));
    end component;

    --señales
    signal D : bit_vector(7 downto 0);
    signal Z : bit_vector(7 downto 0);
    signal clk, clr, s0, s1, sdr, sdl : bit := '0';

    begin

        --PORT MAPS
        E: c_ShiftReg8b port map (clk, clr, s0, s1, sdr, sdl, D, Z);

        clk_p : process
            begin

                clk <= '0';
                wait for 5 ns;

                clk <= '1';
                wait for 5 ns;

        end process;
        
        set_p : process
            begin

                clr <= '1';
                s0 <= '1';
                sdl <= '1';
                wait for 30 ns;

                sdl <= '0';
                wait for 30 ns;

                s0 <= '0';
                s1 <= '1';
                sdr <= '1';
                wait for 30 ns;

                sdr <= '0';
                wait for 30 ns;

                s0 <= '1';
                D <= "01010101";
                wait for 10 ns;

                s0 <= '0';
                s0 <= '1';
                wait for 20 ns;
                
                clr <= '0';
                wait;

        end process;

end arch; -- arch