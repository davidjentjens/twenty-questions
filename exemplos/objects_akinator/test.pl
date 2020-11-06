
go :-
  writeln('asd').

someClause(one, two).

someClause(a, one).
someClause(b, three).
someClause(c, four).
someClause(a, five).
someClause(c, five).
someClause(a, six).
someClause(a, seven).

show(a):- write('foi a'), nl.
show(b):- write('foi b'), nl.
show(c):- write('foi c'), nl.


show(one):- write('Rule One'), nl.
show(two):- write('Rule Two'), nl.
show(three):- write('Rule Three'), nl.
show(four):- write('Rule Four'), nl.

takeRead() :-
  read(Term),
  (Term = 'y' -> someClause(one,two), writeln('yes MAN !!!'), !;
  (Term = 'n' -> someClause(three,two), !)),
  fail.

takeRead() :-
  writeln('not today').


showlist([]).
showlist([H|T]) :-
  show(H),
  showlist(T).

arrayClauseList([], _).

arrayClauseList(List, AllClauses) :-
  sumClausesList(List, AllClauses, []).

sumClausesList([], AllClauses, Aux) :- AllClauses = Aux.

sumClausesList([H|T], AllClauses, Aux) :-
  setof(Clause, someClause(H,Clause), ClauseList),
  union(Aux, ClauseList, SumClauses),
  append([Aux,SumClauses],Aux2),
  sumClausesList(T, AllClauses, Aux2).


restrictList([],_).
restrictList([H|T],Obj) :-
  someClause(Obj,H),
  restrictList(T,Obj).

oneRule() :- false.
oneRule() :- true. % Always true