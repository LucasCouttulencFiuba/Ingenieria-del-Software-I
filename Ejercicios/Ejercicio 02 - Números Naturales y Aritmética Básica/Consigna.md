# Ejercicio 2
## Representar los números naturales y las operaciones aritméticas básicas
### Con condicionales
Nos inspiramos en la definición axiomática de Peano de los números naturales (si no la conoce busquela en la web). El matemático Giuseppe Peano define qué son los números. A nosotros como programadores nos importa también cómo son, por lo cual la definición de Peano es una fuente parcial del dominio. Nos interesará en particular operar aritméticamente con nuestros números.


Llame al primer número I, al segundo número II, al tercero III, al cuarto IIII, al cinco IIIII y así sucesivamente.


Inicialmente concentrense en representar el I y el II.


Vaya definiendo los métodos necesarios para que los números por usted definidos sepan responder los mensajes:

- previous
- next
- \+ anAdder
- \- sustrahend
- \* aMultiplicand
- \/ dividend


Siga ese orden, deje la división para el final que es más difícil.


Cuando al II se le envía el mensaje next, automáticamente se debe crear el III y así sucesivamente. Cuando se multipliquen números también automáticamente se deberán crear los números que esa multiplicación abarque, entre ellos el resultado (por ejemplo al evaluar la expresión II * II, se generará el III y el IIII si aún no están representados, y se retornará el IIII).


Para la división, puede definirla de modo que retorne la parte natural (IIII/III retorna I) o bien que solo funcione para divisiones de resultado natural y cuando se pretenda dividir números con resto no sea nulo se genere un error (ej IIII/III genera un error). Con los números I, II, III, y IIII existentes en el ambiente, cargue el archivo ‘Numeros Naturales Tests.st’. Asegúrese que todos los test pasan. Deberá incorporar algunos mensajes de error en el modelo para que coincidan con los definidos en algunos test (el 5 y el 12).

Eliminar condicionales if de la suma, la resta y la multiplicación
Intente que no haya condicionales ``ifTrue:`` o ``ifFalse:`` en la definición de estas operaciones. Debe agregar más mensajes a los números que les permitan decidir, según quien recibe el mensaje, qué hacer. 


Analice qué dificultades surgen cuando se intenta reemplazar el if en la división.