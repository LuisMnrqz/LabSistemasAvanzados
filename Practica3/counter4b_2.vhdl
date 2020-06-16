library ieee;
use ieee.std_logic_1164.all;

entity counter4b_2 is
    port ( UD, CLK: in bit;
          CLEAR, PRESET: in bit_vector(3 downto 0);
          EN: in bit;
          Z: out bit_vector(3 downto 0));
end counter4b_2;

architecture arch of counter4b_2 is

    component FFJK is
        port ( CLK, J, K, PRESET, CLEAR, EN: in bit;
               Q, Qn: out bit);
    end component;

    --Señales
    signal iQ, iJK, iQN, iU, iD: bit_vector(3 downto 0);

    begin

    iJK(0) <= '1';
    iJK(1) <= iU(1) or iD(1);
    iJK(2) <= iU(2) or iD(2);
    iJK(3) <= iU(3) or iD(3);

    iU(0) <= UD;
    iU(1) <= iU(0) and iQ(0);
    iU(2) <= iU(1) and iQ(1);
    iU(3) <= iU(2) and iQ(2);

    iD(0) <= not UD;
    iD(1) <= iD(0) and iQN(0);
    iD(2) <= iD(1) and iQN(1);
    iD(3) <= iD(2) and iQN(2);
    
    F1: FFJK port map (CLK => CLK, J => iJK(0), K => iJK(0), PRESET => PRESET(0), CLEAR => CLEAR(0), EN => EN, Q => iQ(0), Qn => iQN(0));
    F2: FFJK port map (CLK => CLK, J => iJK(1), K => iJK(1), PRESET => PRESET(1), CLEAR => CLEAR(1), EN => EN, Q => iQ(1), Qn => iQN(1));
    F3: FFJK port map (CLK => CLK, J => iJK(2), K => iJK(2), PRESET => PRESET(2), CLEAR => CLEAR(2), EN => EN, Q => iQ(2), Qn => iQN(2));
    F4: FFJK port map (CLK => CLK, J => iJK(3), K => iJK(3), PRESET => PRESET(3), CLEAR => CLEAR(3), EN => EN, Q => iQ(3), Qn => iQN(3));
    
    Z(0) <= iQ(0);
    Z(1) <= iQ(1);
    Z(2) <= iQ(2);
    Z(3) <= iQ(3);

end arch; -- arch