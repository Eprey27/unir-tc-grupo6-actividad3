# Declaración de variables y valores:

.data   # Sección para la declaración del bloque de datos dentro del segmento de memoria.

  # Definimos las variables donde vamos a guardar las coordenadas y les asignamos un valor inicial de 0. 
  # Al utilizar la instrucción 'word', estamos definiendo un entero de 32 bits.

  X: .word 0
  Y: .word 0
  X1: .word 0
  X2: .word 0
  Y1: .word 0
  Y2: .word 0

  # Definimos los valores de los mensajes que vamos a presentar en la consola Run I/O. 
  # Al utilizar 'asciiz', estamos especificando que la variable es una cadena de texto que termina en null.

  valorX1: .asciiz "Por favor, introduce el valor de la coordenada X (X1) del primer punto conocido: "
  valorY1: .asciiz "Por favor, introduce el valor de la coordenada Y (Y1) del primer punto conocido: "
  valorX2: .asciiz "Por favor, introduce el valor de la coordenada X (X2) del segundo punto conocido: "
  valorY2: .asciiz "Por favor, introduce el valor de la coordenada Y (Y2) del segundo punto conocido: "
  valorX: .asciiz "Por favor, introduce el valor de la coordenada X del punto que se quiere interpolar: "
  valorY: .asciiz "El valor estimado de Y en ese punto es: "
  error_msg_X1: .asciiz "Error: El valor de X1 debe ser menor que X.\n"
  error_msg_X2: .asciiz "Error: El valor de X2 debe ser mayor que X.\n"
  error_msg_X1_X2: .asciiz "Error: El valor de X2 debe ser mayor que el de X1.\n"

# Inicio del programa:

.text # Abrimos la sección para el código ejecutable, que se almacenará dentro del bloque 'text' en el segmento de memoria.  
  
  # Solicitar al usuario que introduzca el valor de X1.    
  pedir_X1:         
    li $v0, 4       # Cargamos la instrucción de imprimir por consola en el registro $v0.
    la $a0, valorX1 # Almacenamos el valor de X1 en el registro $a0, que es el primero disponible del rango $a que va del 0 al 4.
    syscall         # Realizamos la llamada al sistema para ejecutar el servicio y el argumento que hemos establecido en las 2 líneas anteriores.

  # Lectura del imput de usuario con el valor de X1.
  leer_X1:
    li $v0, 5       # Cargamos en el registro $v0 la instrucción para leer un entero.
    syscall         # Llamada al sistema para ejecutar la instrucción anterior.
    sw $v0, X1      # Almacena el contenido de $v0 en el segmento de memoria de X1.        
    # Carga de X1 en s1 para poder utilizarlo en la comprobación de la restricción.
    lw $s1, X1
  
  # Se repiten los mismos pasos definidos y documentados en X1 para leer Y1:

  # Solicitar al usuario que introduzca el valor de Y1.
  pedir_Y1:
    li $v0, 4
    la $a0, valorY1
    syscall

  # Lectura del imput de usuario con el valor de Y1.
  leer_Y1:
    li $v0, 5
    syscall
    sw $v0, Y1
    # Carga de Y1 en s3 para poder utilizarlo en la comprobación de la restricción.        
    lw $s3, Y1

  # Se repiten los mismos pasos definidos y documentados en X1 para leer X2:

  pedir_X2:
    # Solicitar al usuario que introduzca el valor de X2.
    li $v0, 4
    la $a0, valorX2
    syscall
  
  leer_X2:
    # Lectura del imput de usuario con el valor de X2.
    li $v0, 5
    syscall
    sw $v0, X2
    # Carga de X2 en s2 para poder utilizarlo en la comprobación de la restricción.
    lw $s2, X2

  # Comprobar la restricción en la que X1 < X2.
  bge $s1, $s2, error_X1_X2
  
  # Se repiten los mismos pasos definidos y documentados en X1 para leer Y2.
  
  # Solicitar al usuario que introduzca el valor de Y2.
  pedir_Y2:
    li $v0, 4
    la $a0, valorY2
    syscall

  # Lectura del imput de usuario con el valor de Y2.
  leer_Y2:
    li $v0, 5
    syscall
    sw $v0, Y2
    # Carga de Y2 en s4 para poder utilizarlo en el cálculo.   
    lw $s4, Y2 

  # Se repiten los mismos pasos definidos y documentados en X1 para leer X.

  # Solicitar al usuario que introduzca el valor de X.
  pedir_X:
    li $v0, 4      
    la $a0, valorX 
    syscall        

  # Lectura del imput de usuario con el valor de X.
  leer_X:
    li $v0, 5      
    syscall        
    sw $v0, X      
    # Carga de X en s0 para poder utilizarlo en el cálculo.
    lw $s0, X

  manejo_errores:
    # Carga de X1 en s1 para poder utilizarlo en la comprobación de la restricción.
    lw $s1, X1
    # Carga de X2 en s2 para poder utilizarlo en la comprobación de la restricción.
    lw $s2, X2
  
  # Comprobación de la restricción en la que X1 < X < X2.

  comprobacion:
    # Si X1 > X, se salta a la etiqueta 'error_X1 para permitir que el usuario vuelva a introducir un valor dentro del rango'.
    bge $s1, $s0, error_X1
    # Si X > X2, se salta a la etiqueta 'error_X2 para permitir que el usuario vuelva a introducir un valor dentro del rango'.
    bge $s0, $s2, error_X2 
    # Si X1 < X < X2, se continua hacia el calculo.
    j calculo

  # En esta sección del código definimos las funciones que mostrarán los errores para las restricciones de 
  # la función X1 < X < X2 y que una vez mostrados enviarán la línea e ejecución de nuevo a los puntos en 
  # los que el usuario podrá volver a insertar valores dentro del rango permitido.

  error_X1:
    # Si la condición 'X1 < X' no se cumple, imprimir mensaje de error.
    li $v0, 4
    la $a0, error_msg_X1
    syscall
    j pedir_X1
    
  error_X2:
    # Si la condición 'X < X2' no se cumple, imprimir mensaje de error.
    li $v0, 4
    la $a0, error_msg_X2
    syscall
    j pedir_X2

  error_X1_X2:
    # Mensaje de error si X1 no es menor que X2.
    li $v0, 4
    la $a0, error_msg_X1_X2
    syscall
    j pedir_X1

  # Cálculo de la interpolación lineal.

  calculo:
    # Carga de Y2 en s4 para poder utilizarlo en el cálculo.
    lw $s4, Y2        
    # Cargamos en el registro $t0 el valor de X-X1.
    sub $t0, $s0, $s1
    # Cargamos en el registro $t1 el valor de Y2-Y1.
    sub $t1, $s4, $s3
    # t0 = t0*t1 para calcular (X-X1)*(Y2-Y1) y guardarlo en el registro $t0.
    mul $t0, $t0, $t1
    # t1 = (X2-X1) para calcular el denominador de la fórmula y guardarlo en el registro $t1.
    sub $t1, $s2, $s1
    # t0 = t0/t1 para calcular ((X-X1)*(Y2-Y1))/(X2-X1) y se guarda en $t0.
    div $t0, $t0, $t1
    # t0 = t0 + Y1 para calcular ((X-X1)*(Y2-Y1))/(X2-X1) + Y1 que se guarda en el registro $t0.
    add $t0, $t0, $s3
    # Guardamos el resultado en Y para poder mostrarlo por pantalla.
    sw $t0, Y
    # Mostramos el texto del valorY por pantalla.
    li $v0, 4
    la $a0, valorY
    syscall
    # Escribimos en la consola el valor de Y, que sería el resultado final del cálculo.
    li $v0, 1
    lw $a0, Y
    syscall

  fin_programa:
    # Terminamos el programa con la instrucción 'exit' y el código 10. 
    li $v0, 10
    syscall