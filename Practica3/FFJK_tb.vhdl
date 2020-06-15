library ieee;
use ieee.std_logic_1164.all;

entity FFJK_tb is
end FFJK_tb;

architecture arch of FFJK_tb is

    component FFJK is
        port ( clk, J, K, preset, clear, E: in bit;
               Q, Qn: out bit);
    end component;

    --Señales
    signal clk , J, K, preset, clear, E: bit;
    signal Q, Qn: bit;

    begin

    --PORT MAP
    FSO: FF_JK port map(clk, J, K, preset, clear, E, Q, Qn);

    process
        begin    
    end process;
end arch; --arch