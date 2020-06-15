library ieee;
use ieee.std_logic_1164.all;

entity counter4b is
    port ( CLK, CLEAR, PRESET, EN: in bit;
           Z: out bit_vector(3 downto 0));
end counter4b;
 
architecture arch of counter4b is

    component FFJK is
        port ( CLK, J, K, PRESET, CLEAR, EN: in bit;
               Q, Qn: out bit);
    end component;

    --Señales
    signal iQ, iJK, iQN: bit_vector(3 downto 0);

    begin
        iJK(0) <= '1';
        iJK(1) <= iQ(0);
        iJK(2) <= iQ(0) and iQ(1);
        iJK(3) <= iJK(2) and iQ(2);

        --PORT MAPS
        F1: FFJK port map (CLK => CLK, J => iJK(0), K => iJK(0), PRESET => PRESET, CLEAR => CLEAR, Q => iQ(0), Qn => iQN(0), EN => EN);
        F2: FFJK port map (CLK => CLK, J => iJK(1), K => iJK(1), PRESET => PRESET, CLEAR => CLEAR, Q => iQ(1), Qn => iQN(1), EN => EN);
        F3: FFJK port map (CLK => CLK, J => iJK(2), K => iJK(2), PRESET => PRESET, CLEAR => CLEAR, Q => iQ(2), Qn => iQN(2), EN => EN);
        F4: FFJK port map (CLK => CLK, J => iJK(3), K => iJK(3), PRESET => PRESET, CLEAR => CLEAR, Q => iQ(3), Qn => iQN(3), EN => EN);

        Z(0) <= iQ(0);
        Z(1) <= iQ(1);
        Z(2) <= iQ(2);
        Z(3) <= iQ(3);
    
end arch;