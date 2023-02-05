----------------------------------------------------------------------------------
-- JAVIER ARIZA ROSADO [CIRCUITOS ELECTRONICOS]
-- Autómata de medición de duración de los intervalos
-- ESCUELA SUPERIOR DE INGENIEROS DE TELECOMUNICACION
-- aut_duracion.vhd

-- README
-- Automata encargado de medir la duración entre dos pulsos (flancos) consecutivos.
-- Para contar ciclos el contador almacena el valor de entrada para poder determinar
-- en que momento se cambia de estado. Si LIN se mantiene constante se incrementa el
-- contador. Cuando se detecta un cambio o el tiempo transcurrido es mayor de 600 ms,
-- se activa la salida VALID_INT. El siguiente ciclo pasaremos a RESET y volveremos
-- a comenzar
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity aut_duracion is
  Port ( CLK       : in  STD_LOGIC;    -- reloj de 1 ms
         LIN       : in  STD_LOGIC;    -- línea de entrada de datos
         VALID_INT : out  STD_LOGIC;   -- salida de validación de intervalo
         DATO      : out  STD_LOGIC;   -- salida de dato (0 o 1) 
         DURACION  : out  STD_LOGIC_VECTOR (15 downto 0)); -- salida de duración del intervalo, palabra de longitud 16 bits
end aut_duracion;  
                                     
architecture a_aut_duracion of aut_duracion is

type STATE_TYPE is (CONTAR,VALIDAR,RESET);
signal ST : STATE_TYPE := RESET;

signal cont : unsigned (15 downto 0):="0000000000000000"; -- Se define esta variable auxiliar que va a ir contando dentro del programa 
signal dato_act : STD_LOGIC:= '0';                        -- Variable auxiliar para trabajar con los datos de entrada

begin

process (CLK)  -- Autómata digital síncrono
  begin
    if (CLK'event and CLK='1') then    -- Condición para el sincronismo con el reloj
      case ST is      			         -- A continuacion se describen los estados
		
        -- Comienzo de la descripción del estado RESET
		  when RESET =>                  
          cont<="0000000000000010";    -- Cargamos el valor 2 en el contador del programa
          dato_act<=LIN;               -- Cargamos los datos de la entrada LIN en la variable creada anteriormente
          ST<=CONTAR;                  -- El siguiente estado pasado un periodo de reloj es CONTAR, en todos los casos
		 
		  -- Comienzo de la descripción del estado CONTAR
		  when CONTAR =>                
		    cont<=cont+1;                          -- Aumentamos en 1 el valor de "cont"
			 if (LIN /= dato_act or cont>600) then  -- En el caso en el cual LIN sea distinto de dato_act o el contador supere 600 ms
				ST<= VALIDAR;                        -- El siguiente estado en el siguiente periodo de reloj será VALIDAR
		    else                                   
			   ST<= CONTAR;                         -- En el caso contrario al anterior, pasamos al estado CONTAR
			 end if;
		  
		  -- Comienzo de la descripción del estado CONTAR
		  when VALIDAR =>                               
			 ST<= RESET;	                         -- En el siguiente pariodo de reloj, el estado pasara a ser RESET
      end case;	
    end if;
  end process;

-- CABLEADOS DE LAS SALIDAS
  
VALID_INT <='1' when ST=VALIDAR else '0';  -- El único estado que hace que VALID_INT sea 1 es el estado VALIDAR
DATO <= dato_act;                          -- Asignamos la variable auxiliar dato_act a la salida DATO
DURACION <= STD_LOGIC_VECTOR(cont);        -- La variable auxiliar 'cont', conectada a la salida DURACION previa conversion de tipos

end a_aut_duracion;
