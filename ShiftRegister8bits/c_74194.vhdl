library IEEE;
use IEEE.numeric_bit.all;

entity e_74194 is
    port ( clk, clr, s0, s1, sdr, sdl: in bit;
           D: in bit_vector(3 downto 0);
           Z: out bit_vector(3 downto 0));
end e_74194;

architecture arch of e_74194 is

    --señales
    signal iZ : bit_vector(3 downto 0);
    signal s1s0 : bit_vector(1 downto 0);

    begin
        s1s0 <= s1 & s0;
        Z <= iZ;

        process(clk, clr)
            begin

                if clr = '0' then 
                    iZ <= "0000";

                    elsif clk = '1' and clk'event then

                        case s1s0 is 

                            when "01" => iZ <= iZ(2 downto 0) & sdl;

                            when "10" => iZ <= sdr & iZ(3 downto 1);

                            when "11" => iZ <= D;
                            
                            when "00" => null;

                        end case;

                end if;

        end process;

end arch; --arch