library ieee;
use ieee.numeric_bit.all;

entity c_ShiftReg8b is
    port ( clk, clr, s0, s1, sdr, sdl : in bit;
           D: in bit_vector(7 downto 0);
           Z: out bit_vector(7 downto 0));
end c_ShiftReg8b;

architecture arch of c_ShiftReg8b is

    component c_74194 is
        port ( clk, clr, s0, s1, sdr, sdl: in bit;
               D: in bit_vector(3 downto 0);
               Z: out bit_vector(3 downto 0));
    end component;

    --señales
    signal auxZ1, auxZ2: bit_vector(3 downto 0);

    begin

        --PORT MAPS
        E1: c_74194 port map (clk, clr, s0, s1, auxZ2(0), sdl, D(3 downto 0), auxZ1);
        E2: c_74194 port map (clk, clr, s0, s1, sdr, auxZ1(3), D(7 downto 4), auxZ2);

        Z <= auxZ1 and auxZ2;

end arch;