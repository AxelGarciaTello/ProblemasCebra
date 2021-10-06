%========================================================================
% García Tello Axel
%
% Tarea 4. Problemas tipo cebra.
% Costruya programas Prolog para resolver las tres versiones recortadas
% del problema de la cebra.
%
% Version 2: 4 casas, 4 atributos y 6 pistas.
%   1)  El brasileño NO vive en la segunda casa...
%   2)  El dueño de perros juega baloncesto...
%   3)  Hay una casa intermedia entre la del que juega fútbol y la casa
%       roja...
%   4)  El dueño de peces vive junto al dueño de gatos...
%   5)  El dueño de perros vive junto a la casa verde...
%   6)  Un alemán vive en la tercera casa...
%========================================================================

%========================================================================
% Estructura usada para representar la información de las casas.
%   casa(Color,País,Mascota,Juego).
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
% intermedio/3.
%
% Dadas 2 casas y una lista, nos establece si entre estas 2 casas en la
% lista existe una casa.
%========================================================================

intermedio(C1, C2, L):- append(_,[C1,_,C2|_],L).
intermedio(C1, C2, L):- append(_,[C2,_,C1|_],L).

%========================================================================
% vecindario/1.
%
% Representa las pistas del problema de la cebra.
% Su parámetro es la estructura del resultado final del problema.
%========================================================================

vecindario(V):- length(V,3),
                (V = [casa(_,brazil,_,_),_,_];
                V = [_,_,casa(_,brazil,_,_)]),
                member(casa(_,_,perro,baloncesto),V),
                intermedio(casa(_,_,_,fútbol),casa(rojo,_,_,_),V),
                junto(casa(_,_,pez,_),casa(_,_,gato,_),V),
                junto(casa(_,_,perro,_),casa(verde,_,_,_),V),
                V = [_,_,casa(_,alemania,_,_)].

%========================================================================
% visualiza_vecindario/1.
%
% Con la ayuda del predicado vecindario/1, muestras todos los resultados
% posibles del poblema de la cebra en una lista.
%========================================================================

visualiza_vecindario(R):- vecindario(R), write(R).
