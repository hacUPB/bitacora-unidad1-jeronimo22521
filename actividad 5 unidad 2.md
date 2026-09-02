1. ¿Qué ocurre al copiar un objeto en C++ y en C#?

En C++, cuando hago Punto copia = original;, se crea un objeto totalmente nuevo e independiente. Esto pasa porque C++ usa el constructor de copia (uno que el compilador genera automáticamente si yo no defino uno propio), y lo que hace es copiar campo por campo cada valor de original hacia copia. Al final quedan dos objetos separados, cada uno en su propia dirección de memoria.

Por eso en el programa, cuando cambio copia.x, copia.name, etc., original no cambia para nada, cada uno tiene sus propios datos guardados aparte.

En C# la cosa cambia bastante. Ahí una clase es un tipo de referencia, entonces la variable original no guarda el objeto directamente, sino una referencia que apunta al objeto, el cual vive en el heap.

Entonces cuando hago Punto copia = original;, no se está copiando el objeto, se está copiando la referencia. Ahora original y copia apuntan al mismo objeto en memoria. Por eso cuando modifico copia.x o copia.name, veo que original también cambia, porque en el fondo son el mismo objeto, solo que con dos nombres distintos.

2. ¿Qué es copia en cada caso? ¿Es independiente de original?

En C++, copia sí es un objeto independiente, con su propia dirección de memoria y sus propios datos. Modificarlo no afecta a original para nada.

En C#, copia no es un objeto, es una referencia que apunta al mismo objeto que original. No hay independencia, son dos nombres apuntando a lo mismo. Si yo quisiera una copia de verdad en C#, tendría que crearla explícitamente, por ejemplo con un método Clone() o copiando los campos a mano.

![alt text](<Capturas ejercicios/ACTTIVIDAD 5 .png>)