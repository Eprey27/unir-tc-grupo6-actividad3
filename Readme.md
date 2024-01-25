# Actividad 3 - Tecnología de Computadores - Operación de Interpolación Lineal

## Descripción

Programa ensamblador (MIPS) para resolver una operación de interpolación lineal entre 2 puntos (X1, Y1) y (X2, Y2), calculando el valor correspondiente de Y para un valor de X.

## Declaración de Variables

### Sección .data

En esta sección se definen las variables que se van a utilizar durante el programa. De esta manera, el sistema puede calcular el espacio de memoria que va a necesitar para manejar los bits en la memoria.

En este programa usaremos 2 tipos de variables:

- Cadenas de caracteres
- Números enteros

## Código Ejecutable

### Sección .text
### Pedir y asignar los valores de entrada

Se solicita al usuario que introduzca los valores para las variables ya definidas 'X1', 'Y1', 'X2', 'Y2' y 'X'. Los valores se piden y se presentan por consola utilizando un ciclo que incluye las instrucciones 'li $v0, 4' + 'syscall'.

### Validación de las restricciones

Nos aseguramos de que las restricciones de la función se cumplan, ya que para encontrar el valor de la coordenada Y entre los puntos (X1, Y1) y (X2, Y2) el valor de X tiene que estar necesariamente comprendido entre X1 y X2; de lo contrario, no podríamos situar un punto de la recta entre los 2 puntos asumiendo una pendiente constante.

Si encontramos que la variable X no cumple alguna de las restricciones, entonces presentamos un mensaje de error y volvemos a solicitar el valor correspondiente.

Para realizar las comprobaciones usaremos la instrucción de salto condicional ('bge').

### Cálculo de la Interpolación

Se calcula el valor de 'Y' mediante la fórmula de interpolación lineal:  

$Y = y_1 + \frac{(X - x_1) \times (y_2 - y_1)}{x_2 - x_1}$

El cálculo lo realizaremos utilizando registros temporales '$t0' y '$t1', y almacenando los valores en los registros de '$s0' a '$s4'.

### Resultado del cálculo

Mostramos el resultado del cálculo del valor 'Y' por la consola.

### Finalización

El programa finaliza con una llamada al sistema; en este caso, es especialmente necesario, ya que el control de errores para la validación lo encontramos en el código justo después de la finalización, y si no finalizásemos, el programa se seguiría ejecutando y pasaría por la sección del Manejo de Errores, mostrando seguramente errores inesperados en la consola.

## Manejo de Errores

Si las condiciones de 'X1 < X' y 'X < X2' no se cumplen, mostraremos los mensajes de error pertinentes y se reiniciará el proceso de petición de valores para 'X1' y 'X2' nuevamente.

# Ejecución del programa

1. Abrir el IDE (MARS) para MIPS de Java.
2. Abrir archivo y buscar el archivo adjunto 'Actividad3-Grupo6.asm' con el ensamblado del programa.
3. Ir al menú de Run y ejecutar ensamblar.
4. Ejecutar el programa clicando sobre el botón de ejecución.
5. Esperar los mensajes en pantalla y seguir las instrucciones.
6. Obtener el valor de Y para las coordenadas informadas en las variables durante la ejecución del programa.
7. Cerrar el IDE Mars o reiniciar el programa.

# Definición del Cálculo de Interpolación Lineal

La interpolación lineal es un método para estimar un valor desconocido dentro de un conjunto de valores conocidos. Se utiliza cuando tenemos dos puntos conocidos y queremos encontrar un valor intermedio entre ellos. Este método asume que los valores cambian de manera lineal entre los dos puntos.

Para entenderlo mejor, podemos imaginar que tenemos dos puntos en un gráfico: A (x1, y1) y B (x2, y2). Estos puntos están conectados por una línea recta. La interpolación lineal nos permite encontrar un valor Y para un punto X que esté entre x1 y x2.

La fórmula para la interpolación lineal es:

$Y = y_1 + \frac{(X - x_1) \times (y_2 - y_1)}{x_2 - x_1}$

Donde encontramos que:
- Y es el valor que queremos encontrar.
- X es la coordenada x del punto que queremos interpolar.
- (x1, y1) y (x2, y2) son las coordenadas de los puntos conocidos.

Este método es muy útil en muchas aplicaciones, como en la ciencia de datos para estimar valores desconocidos que forman huecos entre valores conocidos, en la animación para calcular movimientos suaves, o en ingeniería para predecir valores dentro de un rango conocido. La clave de la interpolación lineal es que asume una tasa de cambio constante entre los dos puntos conocidos.