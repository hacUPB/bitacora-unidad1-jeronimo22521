¿Qué ocurre?

El programa corre sin problemas, imprimiendo:

global_inicializada: 42
global_no_inicializada: 0
global_inicializada: 69
global_no_inicializada: 666

¿Por qué?

Acá no hay ningún truco raro como en los experimentos anteriores, es simplemente el comportamiento normal de las variables globales.

global_inicializada arranca en 42 porque así la definimos, y vive en el segmento .data (datos globales que sí tienen un valor inicial).
global_no_inicializada arranca en 0 aunque no le pusimos ningún valor. Eso pasa porque va al segmento .bss, donde el sistema operativo pone en cero automáticamente todo lo que no se inicializó explícitamente.
Ambas se pueden modificar sin drama (= 69 y = 666) porque, a diferencia del segmento de texto o del .rodata (donde vive el string del experimento 2), el segmento de datos globales es escribible por diseño — para eso existen las variables globales, para poder cambiarlas durante la ejecución.


experimento 4

¿Qué ocurre?

El programa ni siquiera compila. Da un error de compilación tipo "var_estatica was not declared in this scope" (o "no fue declarada en este ámbito").

¿Por qué?

Porque var_estatica es una variable local a funcionConStatic(), lo de "static" no cambia dónde se puede ver la variable, solo cambia cómo se comporta en memoria. El static afecta la duración (cuánto tiempo vive en memoria), pero no el alcance/scope (desde dónde se puede acceder). Sigue siendo una variable privada de esa función, invisible desde main.

Para arreglarlo habría que exponerla de otra forma (por ejemplo, que funcionConStatic() la devuelva por referencia), pero tal cual está el código, es un error de acceso, no un problema de memoria.

¿Qué pasa con las variables cada que entras y sales de una función (caso normal, sin static)?

Las variables locales normales se crean en el stack cada vez que entras a la función, y se destruyen cuando sales de ella. Por eso si llamas la función varias veces, cada vez "nace" de nuevo con su valor inicial — no se acuerda de lo que pasó la vez anterior.

¿Y las variables locales estáticas?

Acá está la diferencia clave: una variable static dentro de una función no vive en el stack, vive en el segmento de datos (como las globales), y se inicializa una sola vez, la primera vez que se ejecuta esa línea. Después de eso, aunque salgas de la función, la variable no se destruye — se queda ahí con su valor.

Entonces si llamas funcionConStatic() varias veces, la variable mantiene el valor que tenía la última vez que saliste de la función, y sigue existiendo mientras el programa completo esté corriendo (no solo mientras la función está "activa"). Es como una variable global, pero con el alcance restringido a esa función.