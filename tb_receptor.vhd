----------------------------------------------------------------------------------
-- 
-- Archivo de test para el receptor
-- Codifique su ARJ700
--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_receptor IS
END tb_receptor;
 
ARCHITECTURE behavior OF tb_receptor IS 

COMPONENT receptor            -- Declaración del componente que se va a simular
    PORT(CLK : IN  std_logic;
         LIN : IN  std_logic;
         CARACTER : OUT  std_logic_vector(7 downto 0));
END COMPONENT;


-- Señales correspondientes a las entradas y salidas del componente
signal CLK : std_logic := '0';
signal LIN : std_logic := '0';
signal CARACTER : std_logic_vector(7 downto 0);


-- Periodo del reloj = 1 ms
constant CLK_period : time := 1 ms;
 
BEGIN
-- Cableado del componente bajo prueba
uut: receptor PORT MAP (
        CLK => CLK,
        LIN => LIN,
        CARACTER => CARACTER );


-- Proceso que genera la señal de reloj CLK
CLK_process :process
  begin
    CLK <= '0';              -- Flanco de bajada
    wait for CLK_period/2;   
    CLK <= '1';              -- Flanco de subida
    wait for CLK_period/2;
  end process;
 
-- Proceso que genera la señal LIN
LIN_process: process
   begin
     LIN<='0';	    -- ESPACIO INICIAL
     wait for 300 ms;
     
--  CODIFIQUE EL ARCHIVO DE SIMULACIÓN SEGÚN SU APELLIDO, NOMBRE Y DNI
    
  -- EJEMPLO CARÁCTER A (·-)	
     LIN<='1';         -- PUNTO    
     wait for 100 ms;
	  
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  
     LIN<='1';         -- RAYA
     wait for 300 ms;

     LIN<='0';         -- ESPACIO	
     wait for 300 ms;	
  -- FIN EJEMPLO CARÁCTER A (·-) acumulado: 11
  
      -- EJEMPLO CARÁCTER R (·-)	
     LIN<='1';         -- PUNTO    
     wait for 100 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
     LIN<='1';         -- RAYA
     wait for 300 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- PUNTO    
     wait for 100 ms;
     LIN<='0';         -- ESPACIO	
     wait for 300 ms;	
  -- FIN EJEMPLO CARÁCTER R (·-) acumulado: 21
  
    -- EJEMPLO CARÁCTER J (·-)
     LIN<='1';         -- PUNTO    
     wait for 100 ms; 
     LIN<='0';         -- PAUSA
     wait for 100 ms;
     LIN<='1';         -- RAYA
     wait for 300 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
     LIN<='1';         -- RAYA
     wait for 300 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
     wait for 300 ms;
     LIN<='0';         -- ESPACIO	
     wait for 300 ms;	
  -- FIN EJEMPLO CARÁCTER J (·-) acumulado: 37
  
    -- EJEMPLO CARÁCTER 7 (·-)	
	  LIN<='1';         -- RAYA
     wait for 300 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
     wait for 300 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- PUNTO    
     wait for 100 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- PUNTO    
     wait for 100 ms;
	  LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- PUNTO    
     wait for 100 ms;
     LIN<='0';         -- ESPACIO	
     wait for 300 ms;	
  -- FIN EJEMPLO CARÁCTER 7 (·-) acumulado: 53

      -- EJEMPLO CARÁCTER 0 (·-)	
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- ESPACIO	
     wait for 300 ms;	
  -- FIN EJEMPLO CARÁCTER 0 (·-) acumulado: 75
  
  
   -- EJEMPLO CARÁCTER 0 (·-)	
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- PAUSA
     wait for 100 ms;
	  LIN<='1';         -- RAYA
	  wait for 300 ms;
     LIN<='0';         -- ESPACIO	
     wait for 300 ms;	
     -- FIN EJEMPLO CARÁCTER 0 (·-) acumulado: 97 ms

     wait;
   end process;
END; 