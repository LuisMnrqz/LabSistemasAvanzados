library ieee;
use ieee.std_logic_1164.all;

entity register4b is 
    port ( d_in : in std_logic_vector(3 downto 0);
           clk, ld , reset : in std_logic;
           d_out : out std_logic_vector(3 downto 0));
end register4b;

architecture arch of register4bits is

    component FF_D is
        port ( clk, ld, d: in std_logic;
               reset: in std_logic;
               q: out std_logic);
    end component;

    begin
    
        FFD1: FF_D port map (clk, ld, d_in(0),reset, d_out(0));
        FFD2: FF_D port map (clk, ld, d_in(1),reset, d_out(1));
        FFD3: FF_D port map (clk, ld, d_in(2),reset, d_out(2));
        FFD4: FF_D port map (clk, ld, d_in(3),reset, d_out(3));

end arch; --arch