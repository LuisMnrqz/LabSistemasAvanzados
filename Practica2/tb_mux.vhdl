LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_mux IS
END tb_mux;
 
ARCHITECTURE behavior OF tb_mux IS
 
    COMPONENT mux_4a1
    PORT(A, B, C, D : IN  std_logic;
         S0 : IN  std_logic;
         S1 : IN  std_logic;
         S : OUT  std_logic);
    END COMPONENT;
 
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal C : std_logic := '0';
   signal D : std_logic := '0';
   signal S0 : std_logic := '0';
   signal S1 : std_logic := '0';
   signal S : std_logic;
 
BEGIN
 
uut: mux_4a1 PORT MAP (A => A,
                       B => B,
                       C => C,
                       D => D,
                       S0 => S0,
                       S1 => S1,
                       S => S);
 
   stim_proc: process
   begin
      wait for 100 ns; 
 
    A <= '1';
    B <= '0';
    C <= '1';
    D <= '0';       
 
    S0 <= '0'; S1 <= '0';
 
      wait for 100 ns; 
 
    S0 <= '1'; S1 <= '0';
 
      wait for 100 ns; 
 
    S0 <= '0'; S1 <= '1';
 
        wait for 100 ns;   
 
    S0 <= '0'; S1 <= '1';  
 
        wait for 100 ns;   
 
    end process;
END;