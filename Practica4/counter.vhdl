library ieee;
use ieee.std_logic_1164.all;

--2BITS
entity counter is
    port ( CLK, CLEAR, PRESET, EN: in bit;
           Z: out bit_vector(1 downto 0));
end counter;
 
architecture arch of counter is

    component FFJK is
            port ( CLK, J, K, PRESET, CLEAR, EN: in bit;
                   Q, Qn: out bit);
    end component;

    --Señales
    signal iQ, iQN, iJK: bit_vector(1 downto 0);

    begin

        iJK(0) <= '1';
        iJK(1) <= iQ(0);

        --PORT MAPS
        F1: FFJK port map (CLK => CLK, J => iJK(0), K => iJK(0), PRESET => PRESET, CLEAR => CLEAR, Q => iQ(0), Qn => iQN(0), EN => EN);
        F2: FFJK port map (CLK => CLK, J => iJK(1), K => iJK(1), PRESET => PRESET, CLEAR => CLEAR, Q => iQ(1), Qn => iQN(1), EN => EN);

        --r
        Z(0) <= iQ(0);
        Z(1) <= iQ(1);
    
end arch;