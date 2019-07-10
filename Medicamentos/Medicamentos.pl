vende(laGondoriana, trancosin, 35).
vende(laGondoriana, sanaSam, 35).
incluye(trancosin, athelas).
incluye(trancosin, cenizaBoromireana).
efecto(athelas, cura(desazon)).
efecto(athelas, cura(heridaDeOrco)).
efecto(cenizaBoromireana, cura(gripeA)).
efecto(cenizaBoromireana, potencia(deseoDePoder)).
estaEnfermo(eomer, heridaDeOrco). % eomer es varon
estaEnfermo(eomer, deseoDePoder).
estaEnfermo(eomund, desazon).
estaEnfermo(eowyn, heridaDeOrco). % eowyn es mujer
padre(eomund, eomer).
actividad(eomer, fecha(15, 6, 3014), compro(trancosin, laGondoriana)).
actividad(eomer, fecha(15, 8, 3014), preguntoPor(sanaSam, laGondoriana)).
actividad(eowyn, fecha(14, 9, 3014), preguntoPor(sanaSam, laGondoriana)).


% Medicamento util

medicamentoUtil(Persona, Medicamento) :-
    sirveParaCurar(Medicamento, Persona),
    not(potenciaEnfermedad(Persona, Droga)).

sirveParaCurar(Medicamento, Persona) :-
    estaEnfermo(Persona, Enfermedad),
    incluye(Medicamento, Droga),
    efecto(Droga, cura(Enfermedad)).

potenciaEnfermedad(Persona, Medicamento) :-
    incluye(Medicamento, Droga),
    estaEnfermo(Persona, Enfermedad),
    efecto(Droga, potencia(Enfermedad)).

medicamentoMilagroso(Persona, Medicamento) :-
    persona(Persona),
    incluye(Medicamento, _),
    forall(estaEnfermo(Persona, Enfermedad), curaLaEnfermedad(Medicamento, Enfermedad)),
    not(potenciaEnfermedad(Persona, Medicamento)).

persona(Persona) :- 
    estaEnfermo(Persona, _).

curaLaEnfermedad(Medicamento, Enfermedad) :-
    efecto(Droga, cura(Enfermedad)),
    incluye(Medicamento, Droga).

droga(Droga) :- incluye(_, Droga).

drogaSimpatica(Droga) :- 
    droga(Droga),
    curaALMenosCuatroEnfermedades(Droga),
    not(efecto(Droga, potencia(_))).

drogaSimpatica(Droga) :- %Hacer en términos de sirveParaCurar o similar.
    estaEnfermo(eomer, Enfermedad),
    efecto(Droga, cura(Enfermedad)),
    estaEnfermo(eowyn, OtraEnfermedad),
    not(efecto(Droga, cura(OtraEnfermedad))),
    Enfermedad \= OtraEnfermedad. 

drogaSimpatica(Droga) :-
    incluye(Medicamento, Droga),
    vende(_, Medicamento, _), 
    forall(vende(_, Medicamento, Precio), Precio < 10).

curaAlMenosCuatroEnfermedades(Droga):-
    findall(cura(Enfermedad), efecto(Droga, cura(Enfermedad)), Lista),
    length(Lista, EnfermedadesQueCura),
    EnfermedadesQueCura >= 4,

/*
tipoSuicida(Persona) :- %Mal
    estaEnfermo(Persona, Enfermedad),
    actividad(Persona, _, compro(Medicamento, _)),
    incluye(Medicamento, Droga),
    forall(estaEnfermo(Persona, AlgunaEnfermedad), not(efecto(Droga, cura(AlgunaEnfermedad)))),
    efecto(Droga, potencia(Enfermedad)).*/

tipoSuicida(Persona) :-
    estaEnfermo(Persona, Enfermedad),
    actividad(Persona, _, compro(Medicamento, _)),
    not(sirveParaCurar(Medicamento, Persona)),
    potenciaEnfermedad(Medicamento, Persona).

farmacia(Farmacia) :- vende(Farmacia, _, _).

tipoAhorrativo(Persona) :-
    persona(Persona),
    farmacia(Farmacia),
    forall(actividad(Persona, _, compro(Medicamento, Farmacia), comproMasBarato(Persona, Medicamento, Farmacia))).

comproMasBarato(Persona, Medicamento, UnaFarmacia) :-
    actividad(Persona, _, preguntoPor(Medicamento, OtraFarmacia)),
    vende(UnaFarmacia, Medicamento, PrecioComprado),
    vende(OtraFarmacia, Medicamento, PrecioPreguntado),
    PrecioPreguntado > PrecioComprado.

tipoActivoEn(Persona, Mes, Agno) :-
    actividad(Persona, fecha(_, Mes, Agno), _).

fecha(Fecha) :- actividad(_, Fecha, _).

diaProductivo(Fecha) :-
    fecha(Fecha),
    forall(actividad(UnaPersona, Fecha, Actividad), fueUtil(UnaPersona, Actividad)).

fueUtil(Persona, compro(Medicamento)) :-
    medicamentoUtil(Persona, Medicamento).

fueUtil(Persona, preguntoPor(Medicamento)) :-
    medicamentoUtil(Persona, Medicamento).

gastoTotal(Persona, Plata) :-
    actividad(Persona, _, _),
    findall(Precio, precio(Persona, Precio), Lista),
    sumlist(Lista, Plata).

precio(Persona, Precio) :-
    actividad(Persona, _, compro(Medicamento, Farmacia)),
    vende(Farmacia, Medicamento, Precio).

zafoDe(Persona, Enfermedad) :-
    ancestro(Persona, Padre),
    estaEnfermo(Padre, Enfermedad),
    not(estaEnfermo(Persona, Enfermedad)).

ancestro(Ancestro, Descendiente) :-
    padre(Ancestro, Descendiente).

ancestro(Ancestro, Descendiente) :-
    padre(Ancestro, Alguien),
    Ancestro(Alguien, Descendiente).




    



    