// Experimento 1
// Al ejecutar el programa en el simulador observé que primero carga el número 1, luego el número 2 y los suma. Después guarda el resultado en la dirección de memoria 16 de la RAM. Finalmente, el programa entra en un ciclo infinito con la instrucción 0;JMP, por lo que deja de avanzar a otras instrucciones.
//
// El valor que se almacena en la dirección de memoria 16 es 3, porque el programa realiza la suma de 1 + 2 y guarda ese resultado en esa posición de memoria.
//
// En cada ciclo Fetch-Decode-Execute, la CPU primero busca la siguiente instrucción en la ROM, luego la interpreta para saber qué debe hacer y, por último, la ejecuta. Este proceso se repite con cada una de las instrucciones del programa.
//
// Durante la ejecución noté que el registro A va cambiando según los valores o direcciones que se cargan, el registro D primero guarda el número 1 y después el resultado de la suma (3), y la memoria RAM[16] cambia para almacenar el valor 3.
//
// Experimento 2

@5
D=A
@10
D=D+A
@20
M=D
(END)
@END
0;JMP

// Al ejecutar este programa en el simulador, el resultado fue el esperado. Se suman los números 5 y 10, obteniendo 15, y ese valor queda almacenado en la dirección de memoria 20.
//
// Bitácora
//
// La diferencia entre la ROM y la RAM es que la ROM almacena las instrucciones del programa y estas no cambian mientras se ejecuta. En cambio, la RAM se utiliza para guardar los datos con los que trabaja el programa y los resultados de las operaciones, por lo que su contenido puede modificarse durante la ejecución.