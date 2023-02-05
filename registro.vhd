----------------------------------------------------------------------------------
-- JAVIER ARIZA ROSADO [CIRCUITOS ELECTRONICOS]
-- ESCUELA SUPERIOR DE INGENIEROS DE TELECOMUNICACION
-- registro.vhd
--
-- README
-- Registro de 8 bits, implementado con un flip-flop tipo D, sincrono, con enable.
-- En los instantes de tiempo en los cuales hay un flanco de subida en CLK y ENABLE está activo,
-- los datos presentes en la entrada D pasan a la salida Q, en el resto de los casos se mantiene
-- el estado anterior.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registro is
    Port ( CLK     : in  STD_LOGIC;                         -- Reloj del sistema
           ENABLE  : in  STD_LOGIC;                         -- Enable 
           D       : in  STD_LOGIC_VECTOR (7 downto 0);     -- Entrada del modulo, palabra de 8 bits
           Q       : out  STD_LOGIC_VECTOR (7 downto 0));   -- Salida del modulo, palabra de 8 bits 
end registro;

architecture a_registro of registro is

signal reg : STD_LOGIC_VECTOR (7 downto 0):="00000000"; -- Contenido del registro

begin
process (CLK)
begin
	if (CLK'event and CLK='1') then -- Como condicion ponemos que exista un flanco de reloj 
	  if(ENABLE='1') then      -- Si la condicion anterior se cumple y ENABLE está activo,
		reg<=D;                 -- metemos la entrada en el registro
	  end if;
	end if;
end process;
--Cableados de las salidas
Q <= reg;                     -- Enchufamos el registro a la salida
  
end a_registro;

