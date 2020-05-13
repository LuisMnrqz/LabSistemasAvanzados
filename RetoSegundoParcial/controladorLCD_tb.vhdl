library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity controladorLCD_tb is
end entity;

architecture arch of controladorLCD_tb is

    component controladorLCD is
            port (clk: in std_logic; --clock del sistema DEFAULT de fábrica 50 MHz
                  reset: in std_logic; --reinicia lcd
                  --RS: in std_logic; Bit mas significativo de DATA_INSTRUCTION (9)
                  --RW_DATA: in std_logic; Siguiente bit de DATA_INSTRUCTION (8)
                  DATA_INSTRUCTION: in std_logic_vector(9 downto 0);
                  RS: out std_logic;
                  RW: out std_logic;
                  EN: out std_logic;
                  DATA: out std_logic_vector(7 downto 0));
    end component;

    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    signal DATA_INSTRUCTION: std_logic_vector(9 downto 0) := "0000000000";
    signal RS: std_logic := '0';
    signal RW: std_logic := '0';
    signal EN: std_logic := '0';
    signal DATA: std_logic_vector(7 downto 0) := "00000000";

    begin

        UUT : controladorLCD port map (clk, reset, DATA_INSTRUCTION, RS, RW, EN, DATA);

        stimulus : process

            file fin : TEXT open READ_MODE is "input_test.txt"; --archivo con los códigos de los caractéres
            --file fout : TEXT open WRITE_MODE is "output.txt";

            variable current_read_line : line;
            variable current_read_field1 : string(1 to 4);
            variable current_write_line : line;


            begin

                while (not endfile(fin)) loop

                    readline(fin, current_read_line);
                    read(current_read_line, current_read_field1);

                    DATA <= current_read_field1;
                    wait for 125 ns;


                    write(current_write_line, DATA);
                    writeline(output, current_write_line);
                    
                end loop;

            wait;

        end process;
end arch;