¿Qué ocurre?

El programa crashea con un Segmentation Fault (SIGSEGV) al ejecutar la línea *reinterpret_cast<int*>(ptr) = 0;. Alcanza a imprimir el mensaje de la dirección, pero nunca llega al return 0.

¿Por qué?

Porque ptr apunta a main, que vive en el segmento de texto, y ese segmento está marcado por el sistema operativo como solo lectura y ejecución (read + execute), no escritura. Al intentar escribir ahí, la CPU/MMU detecta la violación de permisos y el SO mata el proceso. Esta protección (relacionada con mecanismos como W^X / DEP) existe precisamente para evitar que el código de un programa se modifique a sí mismo en tiempo de ejecución.

Experimento 2

¿Qué ocurre?

El programa no crashea. Se corrompe el valor del puntero mensaje_ro, pero el programa sigue corriendo.

¿Por qué?

ptr no apunta al texto "Hola, memoria de solo lectura", apunta al puntero mensaje_ro en sí. Entonces *ptr = 0 no toca el string, toca el puntero que lo señala.

Ese puntero es una variable normal, guardada en una zona de memoria que sí se puede escribir (a diferencia del código de main en el experimento 1). El const que le pusimos es solo una regla del lenguaje, algo que el compilador vigila al escribir el código — pero al hacer el cast a (char*) nos saltamos esa vigilancia. Como el sistema operativo no tiene ningún problema en que se escriba ahí, no hay crash: simplemente dañamos el puntero silenciosamente.

Si en vez de eso hubiéramos intentado modificar el texto mismo (el contenido del string), ahí sí crashea, porque el propio contenido del string literal está en una zona de solo lectura — como pasó con main en el experimento 1.