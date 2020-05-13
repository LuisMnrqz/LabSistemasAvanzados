library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity controladorLCD is
    port (clk: in std_logic; --clock del sistema DEFAULT de fábrica 50 MHz
          reset: in std_logic; --reinicia lcd
          --RS: in std_logic; Bit mas significativo de DATA_INSTRUCTION (9)
          --RW_DATA: in std_logic; Siguiente bit de DATA_INSTRUCTION (8)
          DATA_INSTRUCTION: in std_logic_vector(9 downto 0);
          RS: out std_logic;
          RW: out std_logic;
          EN: out std_logic;
          DATA: out std_logic_vector(7 downto 0));
end controladorLCD;

architecture controller of controladorLCD is
    type control is (encender, iniciar, listo, enviar);
    signal estado : control;
    signal enable : std_logic;
    constant frecuencia : integer := 50; --Recordemos que se mide en MHz y por default es 50 como se declaró en el puerto
    begin
        process (clk)
            variable contador_clk : integer := 0; --contador
            begin

                if (reset = '1') then
                    estado <= encender;
                end if;

                if (clk = '1') and (clk'event) then

                    case estado is

                        when encender =>
                        if (contador_clk < (50000 * frecuencia)) then    
                            contador_clk <= contador_clk + 1;
                            estado <= encender;
                            
                          else       
                            contador_clk <= 0;
                            RS <= '0';
                            RW <= '0';
                            DATA <= "00110000";
                            estado <= iniciar;
                        end if;
                        
                      when iniciar =>
                      contador_clk <= contador_clk + 1;
                        if (contador_clk < (10 * frecuencia)) then
                          DATA <= "00111100";      --2-line mode, display on
                          DATA <= "00110100";      --1-line mode, display on
                          --DATA <= "00110000";      1-line mdoe, display off
                          --DATA <= "00111000";      2-line mode, display off
                          EN <= '1';
                          estado <= iniciar;

                            elsif (contador_clk < (60 * frecuencia)) then  
                                DATA <= "00000000";
                                EN <= '0';
                                estado <= iniciar;

                            elsif (contador_clk < (70 * frecuencia)) then  
                                DATA <= "00001100";      --display on, cursor off, blink off
                                --DATA <= "00001101";      display on, cursor off, blink on
                                --DATA <= "00001110";      display on, cursor on, blink off
                                --DATA <= "00001111";      display on, cursor on, blink on
                                --DATA <= "00001000";      display off, cursor off, blink off
                                --DATA <= "00001001";      display off, cursor off, blink on
                                --DATA <= "00001010";      display off, cursor on, blink off
                                --DATA <= "00001011";      display off, cursor on, blink on            
                                EN <= '1';
                                estado <= iniciar;

                            elsif (contador_clk < (120 * frecuencia)) then   
                                DATA <= "00000000";
                                EN <= '0';
                                estado <= iniciar;

                            elsif (contador_clk < (130 * frecuencia)) then   
                                DATA <= "00000001";
                                EN <= '1';
                                estado <= iniciar;

                            elsif (contador_clk < (2130 * frecuencia)) then 
                                DATA <= "00000000";
                                EN <= '0';
                                estado <= iniciar;

                            elsif (contador_clk < (2140 * frecuencia)) then  
                                DATA <= "00000110";      --increment mode, entire shift off
                                --DATA <= "00000111";      increment mode, entire shift on
                                --DATA <= "00000100";      decrement mode, entire shift off
                                --DATA <= "00000101";      decrement mode, entire shift on
                                EN <= '1';
                                estado <= iniciar;

                            elsif (contador_clk < (2200 * frecuencia)) then 
                                DATA <= "00000000";
                                EN <= '0';
                                estado <= iniciar;

                            else                             
                                contador_clk <= 0;
                                estado <= listo;
                        end if;    
                     
                      when listo =>
                        if (enable = '1') then
                          RS <= DATA_INSTRUCTION(9);
                          RW <= DATA_INSTRUCTION(8);
                          DATA <= DATA_INSTRUCTION(7 downto 0);
                          contador_clk <= 0;            
                          estado <= enviar;

                            else
                                RS <= '0';
                                RW <= '0';
                                DATA <= "00000000";
                                contador_clk <= 0;
                                estado <= listo;
                        end if;
                        
                      when enviar =>
                      if (contador_clk < (50 * frecuencia)) then  

                        if (contador_clk < frecuencia) then
                           EN <= '0';

                            elsif (contador_clk < (14 * frecuencia)) then
                                EN <= '1';

                            elsif (contador_clk < (27 * frecuencia)) then
                                EN <= '0';
                         end if;

                         contador_clk <= contador_clk + 1;
                         estado <= enviar;

                        else
                            contador_clk <= 0;
                            estado <= listo;
                      end if;
              
                    end case;    
                  
                end if;
        end process;
end controller;