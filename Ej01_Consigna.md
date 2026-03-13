# Ejercicio 1
## Testear y modelar Verdadero, Falso y operaciones lógicas
Represente la verdad y la falsedad con objetos. Hágalo en castellano, dado que en inglés (True y False) ya existen en el ambiente. Llame al objeto que representa la verdad: Verdadero; y aquel que representa la falsedad: Falso.


**Ambos objetos deben ser polimórficos respecto de un cierto protocolo.**


¿Qué quiere decir esto? 'Protocolo' quiere decir: conjunto de mensajes que un objeto sabe responder. Dos objetos son polimórficos cuando saben responder semánticamente igual a un mismo conjunto de mensajes. 'Semánticamente igual' implica que sus respuestas serán siempre polimórficas respecto a un cierto protocolo.


El protocolo a implementar para Verdadero y Falso es el siguiente:

- no
- y: unBooleano
- o: unBooleano
- siVerdadero: unaAccionARealizarUIgnorar
- siFalso: unaAccionARealizarUIgnorar


Antes de implementar cada funcionalidad, escriba un test que inicialmente falla a esa funcionalidad. Luego haga pasar correctamente el test implementando lo mínimo necesario en su modelo. 