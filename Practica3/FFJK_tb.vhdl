library ieee;
use ieee.std_logic_1164.all;

entity FFJK_tb is
end FFJK_tb;

architecture arch of FFJK_tb is

    component FFJK is
        port ( CLK, J, K, PRESET, CLEAR, EN: in bit;
               Q, Qn: out bit);
    end component;

    --Señales
    signal CLK, J, K, PRESET, CLEAR, EN, Q, Qn: bit;

    begin

    --PORT MAP
    FSO: FF_JK port map(CLK, J, K, PRESET, CLEAR, EN, Q, Qn);

    process
        begin    
    end process;
end arch; --arch