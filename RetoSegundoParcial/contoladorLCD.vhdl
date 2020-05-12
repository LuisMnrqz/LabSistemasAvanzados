library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity controladorLCD is
    port (clock, reset, RS, RWDATA: in std_logic;
          dataIN: in std_logic_vector(7 downto 0);
          sRS, sRW, EN: out std_logic;
          dataOUT: out std_logic_vector(7 downto 0));
end controladorLCD;

architecture controller of controladorLCD is
    
end controller;