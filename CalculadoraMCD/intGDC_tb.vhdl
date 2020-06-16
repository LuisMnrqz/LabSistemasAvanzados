library ieee;
use ieee.std_logic_1164.all;

entity intgGDC_tb is
end intgGDC_tb;

architecture arch of intgGDC_tb is

    component GDC is
        port ( clk, reset: in std_logic;
               x, y: in std_logic_vector(3 downto 0);
               dataO: out std_logic_vector(3 downto 0)); --Out
    end component;

    --Señales
    signal clk,reset : std_logic := '0';
    signal x,y,dataO : std_logic_vector(3 downto 0) := "0000";

    begin

        --PORT MAP
        G: GDC port map(clk, reset, x, y, dataO);

        clk_p : process
            begin

                clk <= not clk;
                wait for 2.5 ns;

        end process;
            

        set_p : process
            begin
                x <= "1000";
                y <= "0010";
                reset <= '1';
                wait for 5 ns;

                reset <= '0';
                wait for 100 ns;

                x <= "1100";
                y <= "0100";
                reset <= '1';
                wait for 5 ns;

                reset <= '0';
                wait for 100 ns;

                x <= "1111";
                y <= "1101";
                reset <= '1';
                wait for 5 ns;

                reset <= '0';
                wait;

        end process;
        
end arch; --arch