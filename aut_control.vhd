----------------------------------------------------------------------------------
-- JAVIER ARIZA ROSADO [CIRCUITOS ELECTRONICOS]
-- Autómata de control
-- ESCUELA SUPERIOR DE INGENIEROS DE TELECOMUNICACION
-- aut_control.vhd
-- README
-- Implementación de un automata encargado de generar el codigo y validar su llegada
-- cuando se produce un espacio. La palabra codigo (8 bita) se compone de dos registros s_ncod (3 bita)
-- y s_cod (5 bits) en esta ultima se almacena el aimbol recibido. En s_ncod el número de simbolos por codigo.
-- Se definen dos umbrales para distinguir si se recibe un '0' (UMBRAL0) o si se recibe '1' (UMBRAL1)
-- correspondientes a una PAUSA/ESPACIO o PUNTO/RAYA respectivamente 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity aut_control is
  Port ( CLK    : in STD_LOGIC;    -- reloj
      VALID_INT : in STD_LOGIC;    -- entrada de intervalo válido
      DATO      : in STD_LOGIC;    -- dato (0 o 1)
      DURACION  : in STD_LOGIC_VECTOR (15 downto 0); -- duración del intervalo
      CODIGO    : out  STD_LOGIC_VECTOR (7 downto 0); -- código morse obtenido  
      VALID_COD : out  STD_LOGIC);                   -- validación del código
end aut_control;                                            

architecture a_aut_control  of aut_control is

constant UMBRAL0 : integer := 200;  -- umbral para los 0
constant UMBRAL1 : integer := 200;  -- umbral para los 1

type STATE_TYPE is (ESPACIO,RESET,SIMBOLO,ESPERA);

signal ST : STATE_TYPE := RESET;
signal s_ncod : unsigned (2 downto 0):="000";
signal s_cod  : STD_LOGIC_VECTOR (4 downto 0):="00000";
signal n : INTEGER range 0 to 4;


begin
process (CLK)   -- Autómata digital síncrono
  begin
    if (CLK'event and CLK='1') then
      case ST is
		  -- Descripcion del estado SIMBOLO
        when RESET =>                                         
          n <= 4;                               -- Inicializamos el valor de n en 4, que va a ir rellenando los valores de s_cod (5 bits)  
          s_ncod<="000";                        -- Limpieza de variables para generar una nueva palabra, y rellenad CODIGO posterioremente
          s_cod<="00000";
          if (VALID_INT='1' and DATO='1') then  -- En el en el cual la entrada de validación y la de dato estén a 1, hemos recibido
            ST<=SIMBOLO;                        -- un simblo, por lo tanto el siguiente estado será SIMBOLO
          else
            ST<=RESET;		                     -- Si no se cumple lo anterior, volvemos a RESET, hasta que se cumpla (bucle)  
          end if;
			-- Descripcion del estado SIMBOLO
			when SIMBOLO =>
				if (to_integer(unsigned(DURACION)) > UMBRAL1) then -- Comparamos si la DURACION es mayor que el UMBRAL1 previa conversion de tipos
				 s_cod(n)<='1';                                    -- Si se confirma, es RAYA, s_cod(n) es 1   
				else                                               -- En el caso contrario, UMBRAL1 > DURACION,
				 s_cod(n)<='0';                                    -- es un punto, por lo tanto colocamos un 0 en s_cod(n)
				end if;
				s_ncod<=s_ncod+1;                                  -- Cada vez que entramos al estado SIMBOLO, contamos como 1 simbolo y lo almacenamos en s_ncod   
				n<=n-1;                                            -- estamos concatenando valores cada vez que entramos en el estado, reducimos 'n' para rellenar todos los bits de s_cod
				ST<=ESPERA;                                        -- En todos los casos, el estado siguiente, será ESPERA
			
			-- Descripcion del estado ESPACIO
			when ESPACIO =>                                       
				ST<=RESET;                                         -- Siempre que entramos en el estado ESPACIO, hacemos valid_cont = 1 y en el siguiente ciclo pasamos a RESET
			
			-- Descripcion del estado ESPERA
			when ESPERA  =>
			  if (VALID_INT='1' and DATO='0' and to_integer(unsigned(DURACION)) > UMBRAL0) then -- En el caso en el cual duración es mayor que el umbral de los ceros, 
				ST<=ESPACIO;                                                                     -- y DATO = 0, tenemos un espacio, en el siguiente período, estado será ESPACIO
			  elsif (VALID_INT='1' and DATO='1') then                                           -- Si el dato fuese 1, estriamos ante un simbolo, por lo tanto en el siguiente
			   ST<=SIMBOLO;                                                                     -- período de reloj, el estado será SIMBOLO
			  else                                                                              
				ST<=ESPERA;																								-- Si no se cumplen las anteriores volvemos al mismo estado (bucle)
			  end if;
      end case;
    end if;
  end process;
  
-- CABLEADOS DE LAS SALIDAS

VALID_COD<='1' when ST=ESPACIO else '0';          -- La salida VALID_COD se activará si y solo si estamos en el estado ESPACIO
CODIGO(4 downto 0)<= s_cod ;                      -- asignamos s_cod a los 5 bits de menor peso de la palabra CODIGO
CODIGO(7 downto 5)<= STD_LOGIC_VECTOR(s_ncod) ;   -- asignamos s_ncod a los 3 bit de mayor peso de CODIGO, previa conversion de tipos
end a_aut_control ;
