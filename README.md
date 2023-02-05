# decoderMoorse

Decodificador Morse implementado con un diseño digital sincrono.

Esta formado por circuitos secuenciales, que poseen una unica señal de reloj que comparten todos los flip-flops del sistema

Uso de PROCESS, con una unica señal en su lista de sensibilidad (clk) y diseñado para dispararse en el flanco de subida
del reloj.

Formado por automatas de control, medicion de duracion, etc...

Conversion de datos con una ROM, registros con flip-flops tipo D con enable
