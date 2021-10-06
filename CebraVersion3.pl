%========================================================================
% García Tello Axel
%
% Tarea 4. Problemas tipo cebra.
% Costruya programas Prolog para resolver las tres versiones recortadas
% del problema de la cebra.
%
% Version 3: 4 casas, 4 atributos y 9 pistas.
%   1)  Hay dos casas entre la del bolichista y la del nadador...
%   2)  Hay una casa entre la del irlandés y la del que juega
%       voleyball...
%   3)  La segunda casa es negra...
%   4)  Hay una casa entre la del dueño de caballos y la casa roja...
%   5)  Un escocés vive junto al dueño de tortugas...
%   6)  Hay dos casas entre la del dueño de caballos y la casa del dueño
%       de mariposas...
%   7)  El bolichista vive en algún lugar posterior a la casa del
%       tenista...
%   8)  Hay una casa entre la del que juega voleyball y la casa blanca...
%   9)  Un ruso vive en la primera casa...
%========================================================================

%========================================================================
% Estructura usada para representar la información de las casas.
%   casa(Color,País,Mascota,Juego).
%========================================================================

%========================================================================
% repetido/2.
%
% Indica si algunos de los elementos que compone las 2 casas indicadas
% en los parámetros, es repetido.
%========================================================================

repetido(casa(Color1,País1,Mascota1,Juego1),
         casa(Color2,País2,Mascota2,Juego2)):- (Color1   == Color2;
                                                País1    == País2;
                                                Mascota1 == Mascota2;
                                                Juego1   == Juego2),!.

%========================================================================
% member/2.
%
% Dada una casa, nos indica si existe una casa con algún elemento igual
% en la lista de casas del segundo parámetro.
%========================================================================

member(C1,[C2|_]):- repetido(C1,C2),!.
member(C1,[_|L]):- member(C1,L).

%========================================================================
% no_repetidos/1.
%
% Dada una lista de casas, nos indica si existes 2 o más casas con
% elementos repetidos.
%========================================================================

no_repetidos([]).
no_repetidos([C1|L]):- \+ member(C1,L), no_repetidos(L).

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
% intermedio2/3.
%
% Dadas 2 casas y una lista, nos establece si entre estas 2 casas en la
% lista existe dos casas.
%========================================================================

intermedio2(C1, C2, L):- append(_,[C1,_,_,C2|_],L).
intermedio2(C1, C2, L):- append(_,[C2,_,_,C1|_],L).

%========================================================================
% posterior/3.
%
% Dadas 2 casas y una lista, nos establece si nuestra primera casa es
% posterior a la segunda casa en la lista.
%========================================================================

posterior(C1, C2, L):- append(_,[C2|C],L), member(C1,C).

%========================================================================
% vecindario/1.
%
% Representa las pistas del problema de la cebra.
% Su parámetro es la estructura del resultado final del problema.
%========================================================================

vecindario(V):- length(V,4),
                intermedio2(casa(_,_,_,bolinche),casa(_,_,_,natación),V),
                intermedio(casa(_,irlanda,_,_),casa(_,_,_,voleyball),V),
                V = [_,casa(negro,_,_,_)|_],
                intermedio(casa(_,_,caballo,_),casa(rojo,_,_,_),V),
                junto(casa(_,escocia,_,_),casa(_,_,tortuga,_),V),
                intermedio2(casa(_,_,caballo,_),casa(_,_,mariposa,_),V),
                posterior(casa(_,_,_,bolinche),casa(_,_,_,tenis),V),
                intermedio(casa(_,_,_,voleyball),casa(blanco,_,_,_),V),
                V = [casa(_,rusia,_,_)|_],
                no_repetidos(V).

%========================================================================
% visualiza_vecindario/1.
%
% Con la ayuda del predicado vecindario/1, muestras todos los resultados
% posibles del poblema de la cebra en una lista.
%========================================================================

visualiza_vecindario(R):- vecindario(R), write(R).
