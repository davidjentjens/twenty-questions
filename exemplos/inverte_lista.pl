amiga(joana, maria).
amiga(joana, juliana).
amiga(juliana, maria).
amiga(ana, joana).

homem(jose).
homem(joao).
homem(antonio).

mulher(joana).
mulher(juliana).
mulher(maria).
mulher(ana).

carrega_lista([]).
carrega_lista([H|T]) :- write(H), nl, carrega_lista(T).

inverte_lista([], L, L).
inverte_lista([H|T], L, A) :- inverte_lista(T,L,[H|A]).
inverte_lista(L1,L2) :- inverte_lista(L1,L2,[]).