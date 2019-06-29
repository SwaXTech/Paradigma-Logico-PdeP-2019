% Teg
jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(rojo).

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(asia, filipinas).
estaEn(oceania, australia).
estaEn(oceania, sumatra).
estaEn(oceania, java).
estaEn(oceania, borneo).

ocupa(argentina, magenta).
ocupa(chile, negro).
ocupa(brasil, amarillo).
ocupa(uruguay, rojo).
ocupa(alaska, amarillo).
ocupa(yukon, amarillo).
ocupa(canada, amarillo).
ocupa(oregon, amarillo).
ocupa(kamchatka, negro).
ocupa(china, amarillo).
ocupa(siberia, amarillo).
ocupa(japon, amarillo).
ocupa(australia, negro).
ocupa(sumatra, negro).
ocupa(java, negro).
ocupa(borneo, negro).

% Usar este predicado para saber si son limítrofes, ya que es una relación simétrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina, brasil).
limitrofes(argentina, chile).
limitrofes(argentina, uruguay).
limitrofes(uruguay, brasil).
limitrofes(alaska, kamchatka).
limitrofes(alaska, yukon).
limitrofes(canada, yukon).
limitrofes(alaska, oregon).
limitrofes(canada, oregon).
limitrofes(siberia, kamchatka).
limitrofes(siberia, china).
limitrofes(china, kamchatka).
limitrofes(japon, china).
limitrofes(japon, kamchatka).
limitrofes(australia, sumatra).
limitrofes(australia, java).
limitrofes(australia, borneo).
limitrofes(australia, chile).


% ocupaContinente/2 que relaciona un jugador y un continente si el jugador ocupa todos los países del mismo.
ocupaContinente(Jugador, Continente) :-
    jugador(Jugador),
    continente(Continente),
    forall(ocupa(Pais, Jugador), estaEn(Continente, Pais)).


% desocupado/1, que es verdadero para un país si nadie lo ocupa.
desocupado(Pais) :-
    estaEn(_, Pais),
    not(ocupa(Pais, _)).

% estaPeleado/1 que se cumple para los continentes en los cuales todos los jugadores ocupan algún país.
estaPeleado(Continente) :-
    estaEn(Continente, _),
    forall(estaEn(Continente, Pais), ocupa(Pais, _)).

% continenteLibre/2, que relaciona un jugador y un continente si el jugador no ocupa ningún país del mismo.
continenteLibre(Jugador, Continente) :-
    jugador(Jugador),
    estaEn(Continente, _),
    forall(estaEn(Continente, Pais), noOcupaPais(Jugador, Pais)).

noOcupaPais(Jugador, Pais) :-
    not(ocupa(Pais, Jugador)).

% seAtrinchero/1 que se cumple para los jugadores que ocupan países en un único continente.
seAtrinchero(Jugador) :-
    jugador(Jugador),
    estaEn(Continente, _),
    forall(ocupa(Pais, Jugador), estaEn(Continente, Pais)).


% estaEnElHorno/1 que se cumple para los países cuyos limítrofes están todos ocupados por otros jugadores.
estaEnElHorno(Pais) :-
    estaEn(_, Pais),
    forall(sonLimitrofes(Pais, OtroPais), ocupa(OtroPais, _)).
