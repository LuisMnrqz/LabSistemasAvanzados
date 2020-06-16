library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port ( CLK, CLEAR: in bit;
           A: in bit_vector(15 downto 0);
           D: in bit_vector(3 downto 0);
           Z: out bit_vector(7 downto 0); --DP && segments from G to A
           E: out bit_vector(3 downto 0)); --displays
end controller;

architecture arch of controller is

    --Componentes
    component mux_4a1 is
        port ( A: in bit_vector(3 downto 0);
               S: in bit_vector(1 downto 0);
               Z: out bit);
    end component;

    component counter is
        port ( CLK, CLEAR, PRESET, EN: in bit;
               Z: out bit_vector(1 downto 0));
    end component;

    component decoder7seg is
        port ( S:in bit_vector(3 downto 0);
               Z:out bit_vector(6 downto 0));
    end component;

    --Señales
    signal pins: bit_vector(6 downto 0);
    --4 BITS AND DECIMAL POINT
    signal 4BP: bit_vector(4 downto 0);
    signal iZ: bit_vector(1 downto 0);

    begin

        --contador
        F: counter port map (CLK, CLEAR, '1', '1', iZ);
        
        --Mux's
        M1: mux_4a1 port map ( A(0) => A(0), A(1) => A(4), A(2) => A(8), A(3) => A(12), S => iZ, Z => 4BP(3));
        M2: mux_4a1 port map ( A(0) => A(1), A(1) => A(5), A(2) => A(9), A(3) => A(13), S => iZ, Z => 4BP(2));
        M3: mux_4a1 port map ( A(0) => A(2), A(1) => A(6), A(2) => A(10), A(3) => A(14), S => iZ, Z => 4BP(1));
        M4: mux_4a1 port map ( A(0) => A(3), A(1) => A(7), A(2) => A(11), A(3) => A(15), S => iZ, Z => 4BP(0));
        M5: mux_4a1 port map ( A(0) => D(0), A(1) => D(1), A(2) => D(2),  A(3) => D(3) , S => iZ, Z => 4BP(4));
        
        --decoder
        DS0: decoder7seg port map (S(0) => 4BP(0), S(1)=>4BP(1), S(2) => 4BP(2), S(3) => 4BP(3), Z => pins);

        --displays
        E(0) <= not iZ(0) and not iZ(1);
        E(1) <= iZ(0) and not iZ(1);
        E(2) <= not iZ(0) and iZ(1);
        E(3) <= iZ(0) and iZ(1);
        
        Z <= 4BP(4) & pins;

end arch; -- arch