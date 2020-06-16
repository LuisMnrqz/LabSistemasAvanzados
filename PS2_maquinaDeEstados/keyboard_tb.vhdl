library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity keyboard_tb is
    constant period : time := 40 ns ; --25MHz
    constant bit_period : time := 60 us ; -- Kb clock 16.7KHz
end keyboard_tb;

architecture arch of keyboard_tb is

    component keyboard is
        port ( kbd_clk, kbd_data, clk, reset, enable: in std_logic;
               scan_code : out std_logic_vector(7 downto 0); --scans
               scan_parity, scan_ready, scan_error: out std_logic);
    end component;

    --Señales
    signal scan_code : std_logic_vector(7 downto 0);
    signal kbd_clk : std_logic := '1';
    signal clk, enable, scan_ready: std_logic := '0';
    signal reset, scan_error, scan_parity: std_logic;
    signal kbd_data: std_logic := 'H'; --data

    --types
    type dataRecord is record
        code : std_logic_vector(7 downto 0);
        parity : std_logic;
    end record;
 
    type dataArray is array (natural range <>) of dataRecord;
        constant data : dataArray := ( (code => x"3B", parity => '0'),
                                       (code => x"44", parity => '1'),
                                       (code => x"21", parity => '0'), 
                                       (code => x"24", parity => '1'));

    begin   
        
        --PORT MAP
        --Unit Under Test
        UUT : keyboard port map (kbd_clk, kbd_data, clk, reset, enable, scan_code, scan_parity, scan_ready, scan_error);

        clk <= not clk after (period / 2);
        reset <= '1', '0' after period;

        process
            procedure send_code( sc : dataRecord ) is
                begin

                    kbd_clk <= 'H';
                    kbd_data <= 'H';
            
                    wait for (bit_period / 2);
                    kbd_data <= '0'; --inicio
            
                    wait for (bit_period / 2);
                    kbd_clk <= '0';
                    wait for (bit_period / 2);
                    kbd_clk <= '1';

                    for i in 0 to 7 loop

                        kbd_data <= sc.code(i);
                        
                        wait for (bit_period / 2);
                        kbd_clk <= '0';

                        wait for (bit_period / 2);
                        kbd_clk <= '1';

                    end loop;

                    kbd_data <= sc.parity; --paridad
                    
                    wait for (bit_period / 2);
                    kbd_clk <= '0';
                    
                    wait for (bit_period / 2);
                    kbd_clk <= '1';
            
                    --stop
                    kbd_data <= '1';
                    
                    wait for (bit_period/2);
                    kbd_clk <= '0';

                    wait for (bit_period/2);
                    kbd_clk <= '1';
                    
                    kbd_data <= 'H';
                    
                    wait for (bit_period * 3);

            end procedure send_code;
    
            begin
                wait for bit_period;

                for i in data'range loop

                    send_code(data(i));

                end loop;

                wait;
                
            end process;

end arch; -- arch