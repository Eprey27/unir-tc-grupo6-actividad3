import matplotlib.pyplot as plt
from scipy import interpolate
import numpy as np

# Nuevos puntos dados por el usuario
x_points = np.array([0, 2, 4, 6, 8, 10])
y_points = np.array([5, 7, 3, 7, 5, 3])

# Puntos resultantes de la interpolación
x_int_points = np.array([1, 3, 5, 7, 9])
y_int_points = np.array([6, 5, 5, 6, 4])

# Creamos una función de interpolación lineal basada en los puntos dados
linear_interpolation = interpolate.interp1d(x_points, y_points, kind='linear')

# Generamos puntos x nuevos para la línea interpolada
x_new = np.linspace(min(x_points), max(x_points), num=200)

# Usamos la función de interpolación para obtener los nuevos valores y
y_new = linear_interpolation(x_new)

# Configurando los ticks de los ejes con una separación de 1
plt.xticks(np.arange(min(x_points) - 1, max(x_points) + 2, 1))
plt.yticks(np.arange(min(y_points) - 1, max(y_points) + 2, 1))

# Graficamos los puntos conocidos en color negro
plt.plot(x_points, y_points, 'o', color='gray', label='Puntos conocidos')

# Graficamos los puntos interpolados en color verde
plt.plot(x_int_points, y_int_points, 'o', color='blue', label='Puntos interpolados')

# Graficamos la línea interpolada en color azul
plt.plot(x_new, y_new, '-', label='Línea interpolada')

plt.xlabel('X')
plt.ylabel('Y')
plt.title('Interpolación Lineal con Puntos de Interpolación')
plt.legend()
plt.grid(True)
plt.show()