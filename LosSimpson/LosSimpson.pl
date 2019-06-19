% Los Simpson %
padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).
madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).


tieneHijo(Personaje) :-
    padreDe(Personaje, _).

tieneHijo(Personaje) :-
    madreDe(Personaje, _).

hermanos(HermanoUno, HermanoDos) :-
    padreDe(Padre, HermanoUno),
    padreDe(Padre, HermanoDos),
    madreDe(Madre, HermanoUno),
    madreDe(Madre, HermanoDos),
    HermanoUno \= HermanoDos.

medioHermanos(HermanoUno, HermanoDos) :-
    padreDe(Padre, HermanoUno),
    padreDe(Padre, HermanoDos).

medioHermanos(HermanoUno, HermanoDos) :-
    madreDe(Madre, HermanoUno),
    madreDe(Madre, HermanoDos).

tioDe(Tio, Sobrino) :-
    padreOMadreDe(Padre, Sobrino),
    hermanos(Padre, Tio).

tioDe(Tio, Sobrino) :-
    padreOMadreDe(Padre, Sobrino),
    hermanos(Padre, UnTio),
    sonPareja(UnTio, Tio).

abueloDe(Abuelo, Nieto) :-
    padreDe(Abuelo, Hijo),
    padreDe(Hijo, Nieto).

abueloDe(Abuelo, Nieto) :-
    madreDe(Abuelo, Hijo),
    madreDe(Hijo, Nieto).

abueloMultiple(Abuelo) :-
    abueloDe(Abuelo, HijoUno),
    abueloDe(Abuelo, HijoDos),
    HijoUno \= HijoDos.

sonPareja(Uno, Dos) :-
    madreDe(Uno, Hijo),
    padreDe(Dos, Hijo).

sonPareja(Uno, Dos) :-
    padreDe(Uno, Hijo),
    madreDe(Dos, Hijo).

cuniadoDe(CuniadoUno,CuniadoDos) :-
    hermanos(CuniadoUno, Hermanos),
    sonPareja(CuniadoDos, Hermanos).

suegroDe(Suegro, YernoNuera) :-
    sonPareja(YernoNuera, Pareja),
    padreDe(Suegro, Pareja).

suegroDe(Suegro, YernoNuera) :-
    sonPareja(YernoNuera, Pareja),
    madreDe(Suegro, Pareja).

yernoONueraDe(YernoONuera, SuegroOSuegra) :-
    suegroDe(SuegroOSuegra, YernoONuera).

padreOMadreDe(Padre, Hijo) :-
    padreDe(Padre, Hijo).

padreOMadreDe(Madre, Hijo) :-
    madreDe(Madre, Hijo).

sonPrimos(PrimoUno, PrimoDos) :-
    padreOMadreDe(Padre, PrimoUno),
    hermanos(Padre, Hermanos),
    padreOMadreDe(Hermanos, PrimoDos).

descendienteDe(Tatara, Hijo) :-
    padreOMadreDe(Tatara, Hijo).

descendienteDe(Tatara, Hijo) :-
    padreOMadreDe(Alguien, Hijo),
    descendienteDe(Tatara, Alguien).
    













    





    


