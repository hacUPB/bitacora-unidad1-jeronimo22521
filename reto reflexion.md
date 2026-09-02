Empecé por lo que pedía el enunciado: una cola FIFO hecha desde cero, sin usar std::queue ni nada de bibliotecas, así que tocaba armar la estructura con punteros, como una lista enlazada normal pero con dos referencias, front y rear, para saber por dónde entra y por dónde sale.

Primero hice el Node: cada trazo necesitaba guardar su posición, radio, color y opacidad, más un puntero al siguiente nodo. Con eso ya podía armar la cola.

Para enqueue, la lógica fue: crear el nodo nuevo, conectarlo al final de la cola (rear), y si con ese nuevo nodo ya se pasaba del tamaño máximo, sacar el más viejo llamando a dequeue(). Así el tamaño de la cola nunca crece más de la cuenta y los trazos antiguos se van eliminando solos a medida que entran nuevos.

dequeue fue sacar el nodo de front, mover front al siguiente y liberar memoria del que se sacó con delete, porque si no se libera esa memoria se queda ahí perdida (fuga de memoria) y con el tiempo el programa consume más y más RAM sin necesidad.

clear fue simplemente repetir dequeue() hasta que no quedara nada, y isEmpty nada más revisar si front es nullptr.

Ya con la estructura lista, tocaba conectarla con el resto de la app: en update() agregar un trazo nuevo cuando el mouse está presionado, y en draw() recorrer la cola completa dibujando cada círculo, calculando la opacidad según qué tan cerca estaba del inicio o del final de la cola para lograr el efecto de desvanecido.

Para las teclas fue más directo: c limpia todo llamando clear(), a alterna el tamaño máximo entre 50 y 100 con un simple if, y s llama ofSaveScreen() para guardar la pantalla como imagen.

Ahí tuve un momento de estarme preguntando dónde carajos se estaba guardando la foto cuando apretaba s, porque el programa no mostraba ninguna ruta ni nada en pantalla. Después de buscar un rato me di cuenta de que openFrameworks guarda esas cosas por defecto en la carpeta bin/data del proyecto, así que fui hasta ahí y ahí estaba la imagen guardada con el nombre y la fecha del momento en que la tomé.

![alt text](reto.png)