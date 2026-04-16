Simulador de Gestión de Memoria (MMU) - UES
Este proyecto es un simulador de la Unidad de Administración de Memoria desarrollado en PSeInt para la materia de Sistemas Operativos.
Cómo ejecutar el simuladorAbre el archivo .psc en PSeInt.
1. Ve a Configurar > Opciones del Lenguaje > Personalizar.
2. Asegúrate de marcar la opción "Utilizar índices en arreglos y cadenas en base 0".
3. Presiona F9 para ejecutar la simulación.

Análisis de Resultados
El programa procesa una secuencia fija de 12 referencias de páginas: [1, 2, 3, 4, 1, 2, 5, 1, 2, 3, 4, 5]. 
Con un límite de 3 marcos de usuario, se obtuvieron los siguientes resultados: Algoritmo FIFO (First-In, First-Out): Reemplaza la página que entró primero a la RAM. 
Es fácil de implementar pero menos eficiente.
Algoritmo Óptimo (OPT): Reemplaza la página que tardará más tiempo en volver a ser usada en el futuro.
Conclusión TécnicaEl algoritmo Óptimo siempre genera menos fallos de página que FIFO porque tiene "conocimiento del futuro". 
En un sistema operativo real, este algoritmo es imposible de implementar totalmente porque el hardware no puede predecir qué páginas pedirá el usuario después, por lo que se utiliza principalmente como una métrica de comparación para otros algoritmos.
