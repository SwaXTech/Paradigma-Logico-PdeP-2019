% Clase 1 12/06%

% En contraparte con el paradigma funcional, ya no se declaran cosas, sino que se relacionan mediante predicados
% Del paradigma funcional rescatamos algunos conceptos:

% Expresividad --> Si
% Declaratividad --> Si
% Composición -> No
% Orden superior --> Si
% Aplicación parcial --> No
% Efecto ¿?
% No repetir lógica --> Si
% Tipos --> No
% Pattern Matching --> Si

% Los datos que se tienen en el archivo .pl se conoce como Base de Conocimiento.
% La unidad mínima de trabajo son los predicados.

% Base de conocimiento

dibujitoAnimado(alejoYValentina).
dibujitoAnimado(bananasEnPijamas).
dibujitoAnimado(billyYMandy).
dibujitoAnimado(bobEsponja).
dibujitoAnimado(losCaballerosDelZodiaco).
dibujitoAnimado(caillou).
dibujitoAnimado(catDog).
dibujitoAnimado(lasChicasSuperpoderosas).
dibujitoAnimado(losChicosDelBarrio).
dibujitoAnimado(corajeElPerroCobarde).
dibujitoAnimado(dexter).
dibujitoAnimado(dragonBall).
dibujitoAnimado(heyArnold).
dibujitoAnimado(misterGo).
dibujitoAnimado(losPadrinosMagicos).
dibujitoAnimado(peppaPig).
dibujitoAnimado(powerOfFour).
dibujitoAnimado(tomYJerry).
dibujitoAnimado(laVacaYElPollito).

% dibujitoAnimado es un predicado de aridad 1, es decir solo contiene un individuo
% Los individuos pueden ser átomos o números
% Cuando los predicados son de aridad 1, son propiedades;
% Cuando los predicados son de aridad >= 2 son relaciónes.
% Cada uno de los predicados son sentencias de verdad.


% Podemos establecer relaciónes:

anioDeEstreno(alejoYValentina, 2002).
anioDeEstreno(bananasEnPijamas, 2011).
anioDeEstreno(billyYMandy, 2001).
anioDeEstreno(bobEsponja, 1999).
anioDeEstreno(losCaballerosDelZodiaco, 1986).
anioDeEstreno(caillou, 1997).
anioDeEstreno(catDog, 1998).
anioDeEstreno(lasChicasSuperpoderosas, 1998).
anioDeEstreno(losChicosDelBarrio, 2002).
anioDeEstreno(corajeElPerroCobarde, 1999).
anioDeEstreno(dexter, 1996).
anioDeEstreno(dragonBall, 1986).
anioDeEstreno(heyArnold, 1996).
anioDeEstreno(misterGo, 1996).
anioDeEstreno(losPadrinosMagicos, 1998).
anioDeEstreno(peppaPig, 2004).
anioDeEstreno(powerOfFour, 2016).
anioDeEstreno(tomYJerry, 1940).
anioDeEstreno(laVacaYElPollito, 1997).

% No necesariamente dibujitos, acá se detallan los últimos ganadores del oscar.
anioDeEstreno(greenBook, 2018).
anioDeEstreno(laFormaDelAgua, 2017).
anioDeEstreno(moonlight, 2016).
anioDeEstreno(spotlight, 2015).
anioDeEstreno(birdman, 2014).
anioDeEstreno(doceAniosDeEsclavitud, 2013).
anioDeEstreno(argo, 2012).
anioDeEstreno(elArtista, 2011).
anioDeEstreno(elDiscursoDelRey, 2010).
anioDeEstreno(theHurtLocker, 2009).
anioDeEstreno(titanic, 1997).

% Teniendo esta base de conocimiento ya podemos hacer consultas.

% ?- dibujitoAnimado(bobEsponja). 
% Nos dirá si bobEsponja es un dibujito animado.

% ?- anioDeEstreno(bobEsponja, 2000).
% Nos dirá si bobEsponja se estrenó en el año 2000.

% ¿Existe algún dibujito animado?
% Lo podemos saber usando un guión bajo
% ?- dibujitoAnimado(_).
% Nos dirá una lista de 'true' tan larga como valores posibles existan que hagan verdadera a esa expresión.
% Para continuar con las siguientes se debe apretar la n en el teclado, o enter para finalizar.

% También podemos hacer esta clase de consultas para relaciónes.
% ?- anioDeEstreno(_, 1998).
% Nos dirá una lista de 'true' tan larga como valores posibles existan que hagan verdadera a esa expresión.

% Esta clase de consultas son existenciales. Si nos "dice" al menos un true, entonces existe algún "dibujito",
% o en general, valor, que haga verdadera a esa expresión.

% También tenemos consultas VARIABLES, en la que le pasamos una incógnita y nos dice específicamente
% qué valores hacen verdadera a esa expresión, por ejemplo:
% ?- anioDeEstreno(Dibujito, 1998).
% Nos dirá cada uno de los dibujitos estrenados en 1998, hay que apretar n para poder ver los siguientes.
% Cabe destacar que las variables llevan como primera letra una MAYÜSCULA, mientras q en los átomos obligatoriamente
% empiezan con minúscula.

% Establecemos más relaciónes:

canalDeEmision(heyArnold, nickelodeon).
canalDeEmision(tomYJerry, cartoonNetwork).
canalDeEmision(tomYJerry, canalSiete).
canalDeEmision(peppaPig, canalNueve).
canalDeEmision(lasChicasSuperpoderosas, cartoonNetwork).
canalDeEmision(billyYMandy, cartoonNetwork).
canalDeEmision(misterGo, magicKids).

canalDeAire(canalSiete).
canalDeAire(canalNueve).

% Cuando era chico, no tenía cable así que quiero saber cuáles de los dibujitos podía ver,
% Para eso establecemos una regla.

ibaPorCanaldeAire(Dibujito) :-
    canalDeEmision(Dibujito, CanalDeEmision),
    canalDeAire(CanalDeEmision).

% En la expresión anterior ibaPorCanalDeAire/1 tiene una incógnita dibujito, que es enviada al predicado
% canalDeEmision/2 que además tiene como incógnita CanalDeEmision, ese predicado nos dirá 
% en qué canales se emitía tal dibujito, que posteriormente se utilza para saber
% si ese canal es de Aire.

% Nuevamente podemos hacer los tres tipos de consultas:

% Individual:

% ?- ibaPorCanalDeAire(peppaPig).
% true


% Existencial:

% ?- ibaPorCanalDeAire(_).
% true; --> tantas veces como dibujitos por canal de aire existan.
% false. --> Indica que ya terminó de comprobar


% Variable:

% ?- ibaPorCanalDeAire(Dibujito).
% Dibujito = tomYJerry;
% Dibujito = peppaPig.
% false. --> Indica que ya no hay más.

% Para prolog todo aquello que no se puede demostrar es falso.

% Establecemos nuevas reglas:

dibujitoViejo(Dibujito) :-
    anioDeEstreno(Dibujito, Anio),
    Anio < 2000.

% Nos dirá que un dibujito es viejo si se estrenó antes del 2000.

dibujitoViejoEn(Dibujito, Canal) :-
    dibujitoViejo(Dibujito),
    canalDeEmision(Dibujito, Canal).

% Nos dirá si un dibujito es viejo y además se transmitió en ese canal.

% Ya vamos viendo qué estructura tiene una regla
% Consecuente :- Antecedente
% :- actuaría de <= (entonces)

% Ahora tenemos un problema, en Prolog no existen los Tipos
% Entonces se termina mezclando todo, y podemos hacer consultas del estilo:
% ?- dibujitoViejo(titanic).
% Y nos diria true, porque definimos que se estrenó antes del 2000. (en el predicado anioDeEstreno/1)
% Para solucionarlo podemos hacer presente la existencia de tipos de la siguiente manera:

dibujitoViejoArreglado(Dibujito) :-
    dibujitoAnimado(Dibujito),
    anioDeEstreno(Dibujito, Anio),
    Anio < 2000.


% Se pueden hacer consultas conjuntas, utilizando el operador para la conjunción ','.
% anioDeEstreno(Dibujito, 1996), ibaPorCanalDeAire(Dibujito).

% Establecemos nuevas relaciónes:

protagonista(arenita, bobEsponja).
protagonista(cosmo, losPadrinosMagicos).
protagonista(wanda, losPadrinosMagicos).
protagonista(caillou, caillou).
protagonista(bombon, lasChicasSuperpoderosas).
protagonista(burbuja, lasChicasSuperpoderosas).
protagonista(bellota, lasChicasSuperpoderosas).
protagonista(brisa, powerOfFour).
    
% Veamos el caso de las chicas superpoderosas, fue "reestrenado" con una nueva protagonista
% en Power Of Four y resulta que las protagonistas de las chicas superpoderosas 
% también son protagonistas de Power of Four.
% Antes que volver a escribir que bombon, burbuja y bellota son protagonistas de power of four
% Podemos hacer una regla que nos sirva para eso

protagonista(Chica, powerOfFour) :-
    protagonista(Chica, lasChicasSuperpoderosas).

% O sea, si es protagonista de las chicas superpoderosas, entonces también es protagonista de power of four.

protagonistaCartoon(Protagonista) :-
    protagonista(Protagonista, Dibujito),
    canalDeEmision(Dibujito, cartoonNetwork).

% Nos dice aquellos protagonistas cuyo dibujito fue transmitido en Cartoon Network.

% Establecemos más relaciónes:

cantidadDeEpisodios(alejoYValentina, 53).
cantidadDeEpisodios(bananasEnPijamas, 104).
cantidadDeEpisodios(billyYMandy, 84).
cantidadDeEpisodios(bobEsponja, 244).
cantidadDeEpisodios(losCaballerosDelZodiaco, 114).
cantidadDeEpisodios(caillou, 144).
cantidadDeEpisodios(catDog, 68).
cantidadDeEpisodios(lasChicasSuperpoderosas, 78).
cantidadDeEpisodios(losChicosDelBarrio, 78).
cantidadDeEpisodios(corajeElPerroCobarde, 52).
cantidadDeEpisodios(dexter, 78).
cantidadDeEpisodios(dragonBall, 153).
cantidadDeEpisodios(heyArnold, 100).
cantidadDeEpisodios(misterGo, 25).
cantidadDeEpisodios(losPadrinosMagicos, 161).
cantidadDeEpisodios(peppaPig, 254).
cantidadDeEpisodios(powerOfFour, 120).
cantidadDeEpisodios(tomYJerry, 161).
cantidadDeEpisodios(laVacaYElPollito, 52).

% Un dibujito es memorable si es viejo o además su cantidad de episodios es >= 100

dibujitoMemorable(Dibujito) :-
    cantidadDeEpisodios(Dibujito, Episodios),
    Episodios > 100.

dibujitoMemorable(Dibujito) :-
    dibujitoViejo(Dibujito).

% Cada salto de línea (luego de un .) corresponde a un 'O'; mientras que la coma ',' corresponde a un 'Y'.

% Si también queremos que otros dibujitos fuera de esa regla sean memorables:

dibujitoMemorable(losSimpson).
dibujitoMemorable(bobElConstructor).
dibujitoMemorable(horaDeAventura).













