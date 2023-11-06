Compilador CHILERO (segunda fase)
=================================

Al iniciar la tarea, su repositorio debe contener los siguientes archivos y directorios importantes:

* Makefile
* README.md
* lexer-chilero (igual a la fase número 1)
* parser-chilero-cup
* parser-chilero-antlr
* cooltests

`Makefile` contiene objetivos para compilar y ejecutar su programa. NO MODIFICAR.

`README.md` contiene esta información. 

`lexer-chilero/src/main/jflex/simpletokenizer.lex` es un archivo esqueleto para la especificación del analizador léxico. Deberá completarlo con su solución elaborada en la primera fase para su parser con CUP.

`parser-chilero-cup/src/main/cup/parser.cup` es un archivo esqueleto para la especificación del analizador sintáctico. El archivo ya contiene definiciones importantes para el funcionamiento del parser que deberá utilizar junto a su gramática.

`parser-chilero-antlr` es una copia de parser-chilero-cup. Deberá utilizar este proyecto Java como base y reemplazar CUP por ANTLR, para ello deberá efectuar modificaciones en el archivo pom.xml para soportar ANTLR 4, implementar su visitor/ listener y aprovechar las clases de la implementación original de UC Berkley que también son utilizadas en la versión CUP.

Dentro de `cooltests` encontrará dos programas de prueba:

1. `factloop.cl` es una calculadora de factorial previamente elaborada en el laboratorio.
3. `stack.cl` es una solución a la máquina de pila previamente elaborada en el laboratorio.


`mycoolccup` es un script de shell que une las fases del compilador que utiliza pipes de Unix en lugar de vincular estáticamente el código.  Si bien es ineficiente, esta arquitectura facilita la combinación y combinación los componentes que escribe con los del compilador del curso. NO MODIFICAR.


`mycoolcantlr` es un script de shell que une las fases del compilador que utiliza pipes de Unix en lugar de vincular estáticamente el código.  Si bien es ineficiente, esta arquitectura facilita la combinación y combinación los componentes que escribe con los del compilador del curso. NO MODIFICAR.

Tareas principales
------------------

1. Implemente el analizador sintáctico para CHILERO y COOL en el archivo `parser-chilero-cup/src/main/cup/parser.cup`.
2. Modifique el proyecto parser-chilero-antlr para soportar ANTLR 4 de forma similar al ejercicio elaborado en laboratorio. Luego implemente su solución en la carpeta `src/main/antlr4`
3. Reemplace las clases Parser (CUP y ANTLR) por una versión equivalente que utilice PicoCLI tanto para archivos como para cadenas a ser analizadas en modo interactivo
4. El día de la entrega/calificación su instructor le indicará algunas modificaciones con pruebas adicionales (programas en español, ejecuciones de parser en línea de comandos). El cual usted deberá aceptar para comprobar el análisis de su solución.

Note que el autograder proporcionado con este repositorio incluye únicamente pruebas sobre stack y factorial

Instrucciones de uso del makefile
---------------------------------

El archivo Makefile incluido en su repositorio presenta algunas tareas útiles que pueden ser invocadas directamente en la línea de comandos.

Para compilar su programa ejecute

> make compile

Para generar un script `lexer` que ejecute su analizador léxico, ejecute

> make lexer

Para generar un script `parser` que ejecute su analizador léxico versión CUP, ejecute

> make parsercup

Para generar un script `parser` que ejecute su analizador léxico versión ANTLR 4, ejecute

> make parserantlr

Para limpiar todo el proyecto ejecute:

> make clean

Así mismo existen cuatro fases adicionales que ejecutan en secuencia varios pasos para una prueba completa de su solución.

1. `make dofactorialcup` la cual limpia su proyecto, ejecuta la compilación, genera el lexer, el parser versión CUP y ejecuta una prueba del programa `factloop.cl`.
2. `make dofactorialantlr` la cual limpia su proyecto, ejecuta la compilación, genera el lexer, el parser versión ANTLR 4 y ejecuta una prueba del programa `factloop.cl`.
3. `make dostackcup` la cual limpia su proyecto, ejecuta la compilación, genera el lexer, el parser versión CUP y ejecuta una prueba del programa `stack.cl`.
4. `make dostackantlr` la cual limpia su proyecto, ejecuta la compilación, genera el lexer, el parser versión ANTLR y ejecuta una prueba del programa `stack.cl`.

Si cree que su analizador léxico es correcto (versión CUP), puede ejecutar `mycoolccup` el cual une SU analizador léxico con, SU analizador sintáctico (el cual haya generado con make pasercup), semánticos, generador de código y optimizador de cool. 

Si cree que su analizador léxico es correcto (versión ANTLR), puede ejecutar `mycoolcantlr` el cual une SU analizador léxico y sintáctico (el cual haya generado con make paserantlr), semánticos, generador de código y optimizador de cool. 

Si su analizador léxico se comporta de una manera inesperada, puede obtener errores en cualquier lugar, es decir, durante análisis sintáctico, durante el análisis semántico, durante la generación de código o solo cuando ejecuta el código producido en spim. 

¡Éxitos!

Redacción para segunda fase
---------------------------

1. ¿Que tipo de analizador es generado por CUP y por ANTLR?
2. En ANTLR existen dos formas para generar acciones a partir del arbol de parsing, ¿Cuál utilizó y porqué?
3. ¿Cúales requisitos debió cumplir su gramática para ser compatible con CUP?
4. ¿Cuáles requisitos debió cumplir su gramática para ser compatible con ANTLR?
