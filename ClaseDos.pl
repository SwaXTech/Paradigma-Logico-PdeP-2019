% En Prolog no existe la asignación como en el lenguaje imperativo, el hecho de que una variable tome un valor
% se lo conoce como Unificación
% En una regla, al hacer referencia a una misma variable, entonces se trata del mismo valor.
% En el caso de tratar variables distintas, no necesariamente los valores son distintos.
% Los predicados que pueden responder a consultas variables se llaman Inversibles

% Hay algunos predicados sobre los que no se pueden realizar consultas variables, por ejemplo:
% ?- 1 \= 2 --> true,
% Pero...
% ?- 1 \= OtroNumero --> false.

% La consulta variable no se puede realizar ya que hay infinitas cosas distintas a 1, así sea cualquier tipo de individuo.
% Siguiendo con el ejemplo de Los Simpson.

madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(marge, bart).
madreDe(marge, lisa).

padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(homero, bart).
padreDe(homero, lisa).

% Establecemos la relación de medio-hermanos.

medioHermanos(UnHermano, OtroHermano) :-
    padreDe(Papa, UnHermano),
    padreDe(Papa, OtroHermano),
    UnHermano \= OtroHermano.

% Esta regla primero encuentra un Papá para UnHermano,
% Papá se usa para buscar OtroHermano
% Y una vez se unifica UnHermano que comparta Papá con OtroHermano (que tambien ya se unifica)
% Se valida que no se trate de la misma persona.

medioHermanosNoInversible(UnHermano, OtroHermano) :-
    UnHermano \= OtroHermano,
    padreDe(Papa, UnHermano),
    padreDe(Papa, OtroHermano).

% Este predicado funciona, pero NO ES INVERSIBLE, por lo visto antes, UnHermano puede ser cualquier cosa que puede ser distinta a cualquier otra cosa.
% No pueden unificarse, no se puede asegurar la desigualdad si no se sabe qué son.

% En prolog existen predicados de Orden Superior, es decir, reciben otros predicados.

%materia(Nombre, Año)
materia(algoritmos, 1).
materia(analisisI, 1).
materia(pdp, 2).
materia(sintaxis, 2).
materia(proba, 2).

% nota(Alumno, Materia, Nota).
nota(nicolas, pdp, 10).
nota(nicolas, sintaxis, 8).
nota(nicolas, proba, 7).
nota(malena, algoritmos, 6).
nota(malena, proba, 2).
nota(raul, analisisI, 9).

% Una materia es "jodida" si nadie sacó 10.
materiaJodida(Materia) :-
    not(nota(_, Materia, 10)). % Si no existe ninguna nota que sea 10.

% Acá hay un problema con este predicado, si insertamos algún elemento fuera de la base de conocimiento, nos dirá true...
% ?- materiaJodida(sistemasDeGestión). --> true
% ?- materiaJodida(chocolate). --> true

% Las cosas para las cuales nadie sacó 10 son infinitas...
% el not tiene problemas de inversibilidad...

% Lo solucionamos de la siguiente manera:

materiaJodidaInversible(Materia) :-
    materia(Materia, _),
    not(nota(_, Materia, 10)).

% Agregar el predicado materia(Materia, _). tiene como objetivo "unificar" la variable Materia.
% Esto se llama predicado generador, o sea, genera valores necesarios para no tener los problemas de inversibilidad.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% forall %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Queremos saber si un alumno terminó el año, debemos probar que para todos los casos se cumple algo:

terminoAño(Alumno, Año) :-
    forall(materia(Materia, Año), aprueba(Alumno, Materia)).

aprueba(Alumno, Materia) :-
    nota(Alumno, Materia, Nota), 
    Nota >= 6.


% forall(antecedente, consecuente).

% Otro problema de inversibilidad aparece en esta regla, 
% al probar ?- terminoAño(Alumno, 2). --> true, sin sentido alguno, cuando hacemos una consulta variable nos dice true...

% Esto pasa porque Alumno no se unifica en ningun lugar, para eso necesitamos generar los valores para Alumno
% Sino es como si fuese algo así: forall(materia(Materia, Año), aprueba(_, Materia)).
% Si al antecedente no llega la variable unificada, entonces no se unifica.

terminoAñoBienHecho(Alumno, Año) :-
    alumno(Alumno),
    forall(materia(Materia, Año), aprueba(Alumno, Materia)).

alumno(Alumno) :-
    nota(Alumno, _, _).

% Solucionamos el error para ?- terminoAño(Alumno, 2).
% Seguimos teniendo problema para terminoAño(nicolas, Año).

% Para eso Unificamos la variable Año

terminoAñoAhoraSiBienHecho(Alumno, Año) :-
    alumno(Alumno),
    agno(Año),
    forall(materia(Materia, Año), aprueba(Alumno, Materia)).

agno(Año) :-
    materia(_, Año).

% Ya solucionamos nuestro segundo problema. La consulta arrojará varias veces la misma respuesta. No hay problema.

% En todo forall debe haber en el antecedente una variable sin ligar y en el consecuente una variable que esté en el antecedente.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Equivalencia %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- 1 \= 1 + 0. --> true
% 1 es un individuo distinto al individuo 1 + 0.

% ?- 4 = 2 + 2. --> false
% 4 es un individuo distinto a 2 + 2

% ?- X = 2 + 2. --> X = 2 + 2. --> X se unifica con el individuo 2 + 2.

% Lógicamente está mal comparar una expresión con su resultado, por tal motivo existe un operador "funcional", is.

% ?- X is 2 + 2. --> X = 4. --> Resuelve lo de la derecha

% ?- 2 + 2 is 2 + 2. --> false --> SOLO resuelve lo de la derecha

% is se usa solo para cuentas (con sentido), y lleva del lado izquierdo un númeroo una variable, y del lado derecho
% una expresión o variable ligada.











