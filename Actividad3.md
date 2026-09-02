- Identifica una instrucción que use la ALU y explica qué hace.
La instrucción D=D-A utiliza la ALU, ya que realiza una resta entre el contenido del registro D y el registro A. El resultado de esa operación se guarda nuevamente en D.

- ¿Para qué sirve el registro PC?
El registro PC (Program Counter) sirve para indicar cuál es la siguiente instrucción que la CPU debe ejecutar. Después de ejecutar una instrucción normalmente avanza a la siguiente, aunque también puede cambiar si el programa realiza un salto.

- ¿Cuál es la diferencia entre @i y @READKEYBOARD?
@i hace referencia a una posición de memoria donde se guarda un dato, en este caso una variable. En cambio, @READKEYBOARD hace referencia a una etiqueta del programa, que se utiliza para hacer un salto y continuar la ejecución desde ese punto.

- Describe qué se necesita para leer el teclado y mostrar información en la pantalla.
Para leer el teclado se utiliza la dirección KBD, donde se puede saber si una tecla está siendo presionada. Para mostrar información en la pantalla se utiliza la memoria que comienza en SCREEN, escribiendo valores en esas direcciones para encender o apagar píxeles.

- Identifica un bucle en el programa y explica su funcionamiento.
El bucle comienza en la etiqueta (READKEYBOARD). El programa revisa continuamente si hay una tecla presionada y, al finalizar cada recorrido, vuelve a esa misma etiqueta mediante 0;JMP, por lo que nunca deja de comprobar el teclado.

- Identifica una condición en el programa y explica su funcionamiento.
La instrucción D;JNE es una condición. Si el valor de D es diferente de cero, el programa salta a la etiqueta KEYPRESSED. Si D es igual a cero, continúa ejecutando las instrucciones siguientes.
