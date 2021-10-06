%========================================================================
% García Tello Axel
%
% Tarea 4. Problemas tipo cebra.
% Costruya programas Prolog para resolver las tres versiones recortadas
% del problema de la cebra.
%
% Version 1: 3 casas, 2 atributos y 3 pistas.
%   1)  El español vive junto a la casa roja...
%   2)  El noruego vive en la casa azul...
%   3)  Un italiano vive en la segunda casa...
%========================================================================

%========================================================================
% Estructura usada para representar la información de las casas.
%   casa(Color,País).
%========================================================================

%========================================================================
% junto/3.
%
% Dadas 2 casas y una lista, nos establece si estas 2 casas estan juntas
% en la lista.
%========================================================================

junto(C1, C2, L):- append(_,[C1,C2|_],L).
junto(C1, C2, L):- append(_,[C2,C1|_],L).

%========================================================================
% vecindario/1.
%
% Representa las pistas del problema de la cebra.
% Su parámetro es la estructura del resultado final del problema.
%========================================================================

vecindario(V):- length(V,3),
                junto(casa(_,españa),casa(rojo,_),V),
                member(casa(azul,noruega),V),
                V = [_,casa(_,italia),_].

%========================================================================
% visualiza_vecindario/1.
%
% Con la ayuda del predicado vecindario/1, muestras todos los resultados
% posibles del poblema de la cebra en una lista.
%========================================================================

visualiza_vecindario(R):- vecindario(R), write(R).
