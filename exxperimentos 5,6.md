¿Qué ocurre?

El programa compila y corre bien. La salida es algo así:

Iteración 0
var_no_estatica: 100
var_estatica: 100
Iteración 1
var_no_estatica: 100
var_estatica: 101
Iteración 2
var_no_estatica: 100
var_estatica: 102
Iteración 3
var_no_estatica: 100
var_estatica: 103
Iteración 4
var_no_estatica: 100
var_estatica: 104

¿Por qué?
var_no_estatica siempre imprime 100, sin importar cuántas veces se llame la función. Aunque le hacemos var_no_estatica++ al final, eso no importa porque la variable se destruye al salir de la función. En la siguiente llamada se vuelve a crear desde cero con el valor 100.
var_estatica va aumentando de a uno en cada llamada (100, 101, 102...). Como es static, solo se inicializa una vez (la primera vez que se ejecuta esa línea), y de ahí en adelante conserva el valor que tenía la última vez, incluyendo el var_estatica++ que le hicimos.


¿Diferencia entre estática y no estática?

Sí, es justo lo que se ve acá: la no estática "olvida" todo cada vez que sale de la función, mientras que la estática "recuerda" su valor entre llamadas. Es como si la estática tuviera memoria propia que persiste durante toda la vida del programa, mientras que la normal empieza de cero cada vez.

¿Qué pasa con las variables cada que entras y sales de la función?
Variable normal: se crea en el stack al entrar, se destruye al salir. Cada llamada es una historia completamente nueva, sin memoria de lo que pasó antes.
Variable estática: se crea (inicializa) solo la primera vez que se ejecuta esa línea de código, y después vive en el segmento de datos durante toda la ejecución del programa. Entrar y salir de la función no la afecta — sigue ahí guardada, lista para que la próxima llamada continúe donde la dejó la anterior.

experimento 6 

¿Qué ocurre?

El programa compila y probablemente corre "sin crashear" — pero es un comportamiento indefinido. Puede imprimir basura, puede imprimir el 0 que tenía antes, o en algunos casos sí puede crashear. No hay garantía de nada.

¿Por qué?

Después de delete[] arrayHeap, la memoria se devuelve al sistema (o queda marcada como libre para que el heap la reutilice), pero el puntero arrayHeap sigue apuntando a esa misma dirección — se vuelve lo que se conoce como un puntero colgante (dangling pointer). Acceder a arrayHeap[0] después del delete[] es leer memoria que ya no le pertenece al programa de forma válida. A veces "funciona" porque esa memoria todavía no ha sido reutilizada por nadie más, pero es pura suerte, no algo garantizado.

Comentando la línea del error, análisis:

Heap vs Stack: el Stack se maneja solo (se crea y destruye automático al entrar/salir de una función), mientras que en el Heap vos tenés el control total con new/delete — lo cual da más flexibilidad (tamaño dinámico, sobrevive a la función) pero también toda la responsabilidad de manejarlo bien.

No liberar memoria con new: genera un memory leak. Esa memoria queda reservada para siempre sin que nadie pueda usarla, y si pasa muchas veces el programa va consumiendo cada vez más RAM.

Por qué delete[] en arreglos: porque new[] guarda internamente info extra para liberar correctamente todos los elementos. Usar delete (sin corchetes) en un arreglo es comportamiento indefinido — puede liberar mal o dejar fugas. La regla: lo que se crea con [] se destruye con [].