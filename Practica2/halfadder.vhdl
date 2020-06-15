library ieee;
use ieee.std_logic_1164.all;

entity halfadder is
  port ( S: in bit_vector(1 downto 0);
         Z: out bit_vector(1 downto 0));
end halfadder;

architecture arch of halfadder is

  component mux_4a1 is 
      port ( A: in bit_vector(3 downto 0);
             S: in bit_vector(1 downto 0);
             Z: out bit);
  end component;

  --señales
    signal aux1: bit_vector(3 downto 0);
    signal aux2: bit_vector(3 downto 0);

    begin

      aux1 <= "0110";
      aux2 <= "1000";

      --PORT MAPS
      M1 : mux_4a1 port map (aux1, S, Z(0));
      M2 : mux_4a1 port map (aux2, S, Z(1));

end arch;