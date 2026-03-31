[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/kQgJi-m8)
# Código Repetido

Este ejercicio tiene por objetivo que saquen el código repetido que encuentren en el modelo y en los tests. Por ej. entre el test01 y test02.

Los tests provistos ya funcionan, simplemente hay que sacar el código repetido y los tests deben seguir funcionando.

Se pueden modificar las clases provistas, sólo para eliminar código repetido. No se puede modificar lo que verifican los tests. O sea, sólo se puede hacer un cambio de diseño de tal manera que siga testeando lo mismo, que la funcionalidad sea la misma, pero que no haya código repetido.

Aclaración: Para hacer este ejercicio más sencillo se modela a un Customer utilizando un String en vez de una clase Customer. No es el objetivo del ejercicio que ustedes corrijan esta decisión, ni las consecuencias que trae consigo (por ej. que no se pueda agregar al CustomerBook dos Customers diferentes con el mismo nombre).


# Preguntas y Respuestas

## Abstracción de los tests 01 y 02 

> En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

**Respuesta:**  <br>
Se abstrae el concepto de ejecución temporal de un bloque de código, modelando la idea de que una acción debe ejecutarse dentro de un tiempo máximo. Esa entidad es el mensaje `assertThat:takesLessThan:`

## Cómo representar en Smalltalk

> ¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

**Respuesta:**  <br>
En Smalltalk, los entes de la realidad se representan principalmente mediante clases e instancias. El comportamiento se modela con métodos y mensajes, y también pueden representarse mediante bloques, colecciones y excepciones según el tipo de entidad que se quiera modelar.

## Teoría de Naur

> ¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

**Respuesta:**  <br>
Según Naur, programar es construir un modelo del sistema. La presencia de código repetido indica que hay conceptos del modelo que no están representados. Al eliminar la duplicación mediante abstracciones, se hacen explícitos esos conceptos, mejorando el modelo del sistema.



# Aclaraciones

## Tests 05 y 06
Aunque existe cierta repetición entre ambos tests, no se refactorizaron porque esa repetición forma parte del escenario explícito de cada caso de prueba. Extraerlas a un helper haría los tests menos directos y menos legibles, sin aportar una mejora significativa en mantenibilidad.

## Refactorización del Setup
No refactorizamos el setup de los tests porque priorizamos mantener bien explícito el paso a paso de construcción de cada escenario de prueba. Aunque existe cierta repetición, decidimos que esa secuencia forma parte de la intención del test y dejarla visible mejora la legibilidad y la comprensión inmediata de qué se está preparando en cada caso, sin introducir niveles extra de abstracción que podrían volver menos claro el comportamiento que se quiere verificar.