----------------------------------------------------------------------------------
-- autor: JAVIER ARIZA ROSADO [CIRCUITOS ELECTRONICOS]
-- Receptor: circuito completo 
-- ESCUELA SUPERIOR DE INGENIEROS DE TELECOMUNICACION
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity receptor is
    Port ( CLK : in  STD_LOGIC;  -- Entrada de reloj del sistema
           LIN : in  STD_LOGIC;  -- Entrada de línea
           CARACTER : out  STD_LOGIC_VECTOR (7 downto 0)); -- Salida: caracteres
end receptor;

architecture a_receptor of receptor is

component aut_duracion is
    Port (  CLK       : in  STD_LOGIC;         -- reloj de 1 ms
            LIN       : in  STD_LOGIC;         -- línea de entrada de datos
            VALID_INT : out  STD_LOGIC;        -- salida de validación de intervalo
            DATO      : out  STD_LOGIC;        -- salida de dato (0 o 1) 
            DURACION  : out  STD_LOGIC_VECTOR (15 downto 0)); -- Duración intervalo
end component;

component aut_control is
    Port (  CLK    : in STD_LOGIC;    -- reloj
	   		VALID_INT : in STD_LOGIC;    -- entrada de intervalo válido
		   	DATO      : in STD_LOGIC;    -- dato (0 o 1)
				DURACION  : in STD_LOGIC_VECTOR (15 downto 0); -- duración del intervalo
				CODIGO    : out  STD_LOGIC_VECTOR (7 downto 0); -- código morse obtenido  
				VALID_COD : out  STD_LOGIC);                   -- validación del código
end component;

component ROM is
    Port (  MORSE   : in  STD_LOGIC_VECTOR (7 downto 0);    -- Entrada del código morse
            ASCII   : out STD_LOGIC_VECTOR (7 downto 0));   -- Salida de códgio ASCII
end component;

component registro is
    Port ( CLK     : in  STD_LOGIC;                         -- Reloj
           ENABLE  : in  STD_LOGIC;                         -- Enable
           D       : in  STD_LOGIC_VECTOR (7 downto 0);     -- Entradas
           Q       : out  STD_LOGIC_VECTOR (7 downto 0));   -- Salidas
end component;

signal y1, y2, y6 : STD_LOGIC;
signal y4, y5 : STD_LOGIC_VECTOR (7 downto 0);
signal y3 : STD_LOGIC_VECTOR (15 downto 0);

begin

  U1 : aut_duracion port map (			CLK => CLK, --Conectamos la entrada del reloj del sistema  nuestro automata
													LIN => LIN, -- La entrada del receptor a la entrada del automata de medicion
													VALID_INT => y1,
													DATO => y2 ,
													DURACION => y3);
 
  U2 : aut_control port map (				CLK => CLK, --Conectamos la entrada del reloj del sistema  nuestro automata
													VALID_INT => y1,
													DATO => y2,
													DURACION=> y3,
													CODIGO=> y4,
													VALID_COD=>y6 );
													
  U3 : ROM port map (						MORSE => y4,	
													ASCII => y5 );
											
											
  U4 : registro port map (			   	CLK => CLK , --Conectamos la entrada del reloj del sistema  nuestro registro
											 		ENABLE => y6 ,
													D => y5,
													Q => CARACTER );


end a_receptor;
