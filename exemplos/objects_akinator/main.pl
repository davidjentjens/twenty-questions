% showQuestion() :- writeln('The object is ?').
showQuestion(sharp) :- writeln('The object is sharp?').
showQuestion(cheese) :- writeln('The object is used to cut cheese?').
showQuestion(duel) :- writeln('The object is a weapon for duel?').
showQuestion(readable) :- writeln('The object is readable?').
showQuestion(advertise) :- writeln('The object has any type of adverstisement?').
showQuestion(author) :- writeln('The object has specific author(s)?').
showQuestion(wearable) :- writeln('The object is wearable?').
showQuestion(protectFeets) :- writeln('The object is used to protect your feets?').
showQuestion(stylish) :- writeln('The object can be used as a stylish accessory?').
showQuestion(protectEyes) :- writeln('The object is used to protect your eyes from sun?').
showQuestion(problemEyes) :- writeln('The object is used to correct some of your eyes problem?').
showQuestion(protectCold) :- writeln('The object is used to protect from cold?').
showQuestion(write) :- writeln('The object is used to write?').
showQuestion(grafite) :- writeln('The object has grafite?').
showQuestion(colors) :- writeln('The object can have various colors?').
showQuestion(children) :- writeln('The object is usually used as a weapon against the walls for children?').
showQuestion(alchool) :- writeln('The object is related to alchool?').
showQuestion(wood) :- writeln('The object is made of wood?').
showQuestion(plastic) :- writeln('The object is made of plastic?').
showQuestion(handled) :- writeln('The object can be handled?').
showQuestion(heavy) :- writeln('The object is heavy?').
showQuestion(concave) :- writeln('The object can be used to drink?').
showQuestion(backpack) :- writeln('The object is usually carried on a backpack?').
showQuestion(neck) :- writeln('The object has a tapered neck?').
showQuestion(tech) :- writeln('The object is any type of tech?').

are(knife, sharp). % knife is sharp
are(knife, cheese).

are(sword, sharp). % sword is sharp too
are(sword, duel). % sword can be handle to duel

are(book, handled).
are(book, readable).
are(book, author).
are(book, backpack).

are(magazine, handled).
are(magazine, readable).
are(magazine, advertise).
are(magazine, plastic).
are(maganize, backpack).

are(shoes, stylish).
are(shoes, handled).
are(shoes, wearable).
are(shoes, protectFeets).

are(sunglasses, stylish).
are(sunglasses, protectEyes).
are(sunglasses, handled).
are(sunglasses, plastic).
are(sunglasses, problemEyes).
are(sunglasses, wearable).
are(sunglasses, backpack).

are(glasses, problemEyes).
are(glasses, stylish).
are(glasses, plastic).
are(glasses, handled).
are(glasses, wearable).
are(glasses, backpack).

are(jacket, protectCold).
are(jacket, wearable).
are(jacket, backpack).

are(pen, write).
are(pen, plastic).
are(pen, handled).
are(pen, backpack).

are(pencil, write).
are(pencil, wood).
are(pencil, handled).
are(pencil, backpack).

are(crayons, write).
are(crayons, handled).
are(crayons, children).
are(crayons, backpack).

are(marker, write).
are(marker, handled).
are(marker, alchool).
are(marker, backpack).

are(desk, heavy).
are(desk, wood).

are(bottle, handled).
are(bottle, concave).
are(bottle, neck).
are(bottle, backpack).

are(cup, concave).
are(cup, handled).

are(pc, tech).
are(pc, backpack).

obj(knife).
obj(sword).
obj(book).
obj(magazine).
obj(shoes).
obj(sunglasses).
obj(glasses).
obj(jacket).
obj(pen).
obj(marker).
obj(pencil).
obj(crayons). % giz de cera
obj(desk).
obj(bottle).
obj(cup).
obj(pc).

show(knife) :- writeln("The object is a knife").
show(sword) :- writeln("The object is a sword").
show(book) :- writeln("The object is a book").
show(magazine) :- writeln("The object is a magazine").
show(shoes) :- writeln("The object is a shoes").
show(sunglasses) :- writeln("The object is a sunglasses").
show(glasses) :- writeln("The object is a glasses").
show(jacket) :- writeln("The object is a jacket").
show(pen) :- writeln("The object is a pen").
show(marker) :- writeln("The object is a marker").
show(pencil) :- writeln("The object is a pencil").
show(crayons) :- writeln("The object is a crayons").
show(desk) :- writeln("The object is a desk").
show(bottle) :- writeln("The object is a bottle").
show(cup) :- writeln("The object is a cup").
show(pc) :- writeln("The object is a pc").

% Game
startGame :-
  writeln('Welcome to ObjAkinator, we can find any object in the world. Give us a try...'), nl,
  writeln(' ! answer: y. or n.'), nl,
  setof(Obj, obj(Obj), ListOfObjects),
  setof(Rule, Obj^are(Obj, Rule), ListOfRules),
  findRule([], ListOfRules, ListOfObjects, []),
  true.
% Game

findRule(_, _, ListOfObjects, _) :-
  [Last|_] = ListOfObjects,
  length(ListOfObjects,L),
  (L = 1 -> show(Last), true, !); false.

findRule(_, [], _, _) :-
  writeln("The object is not in ours data base... sorry"), nl.

findRule(WrongRules,ListOfRules, ListOfObjects, GoneRules) :-
  [H|T] = ListOfRules,
  showQuestion(H),
  read(Answer),
  nl,nl,
  (Answer = 'y' ->
      append( [[H],GoneRules],SumedGoneRules),
      % writeln("added"),
      updateGame(WrongRules,SumedGoneRules), !;
  (Answer = 'n' ->
      append( [[H],WrongRules],SumedWrongRules),
      findRule(SumedWrongRules,T, ListOfObjects, GoneRules) % continue to find a rule
    )), true. % until it fails

updateGame(SumedWrongRules,GoneRules) :-
  setof(Obj, restrictList(GoneRules,Obj), ObjList),
  arrayObjList(SumedWrongRules,WrongObjList),
  subtract(ObjList, WrongObjList, FinalObjList),
  arrayRuleList(ObjList, Rules),
  subtract(Rules, GoneRules, LessRules),
  subtract(LessRules, SumedWrongRules, FinalRules),
  findRule(SumedWrongRules,FinalRules, FinalObjList, GoneRules).



% Auxiliary functions

arrayObjList([], AllObjs) :- AllObjs = [].
arrayObjList(Rules, AllObjs) :-
  % write("entrou:"), showlist(Rules),nl,nl,
  sumObjList(Rules, AllObjs, []).

sumObjList([], AllObjs, Aux) :- AllObjs = Aux.
sumObjList([Rule|T], AllObjs, Aux) :-
  setof(Obj, are(Obj,Rule), ObjList),
  append([Aux,ObjList],Aux2),
  sumObjList(T, AllObjs, Aux2).

arrayRuleList([], AllRules) :- AllRules = [].
arrayRuleList(List, AllRules) :-
  sumRuleList(List, AllRules, []).

sumRuleList([], AllRule, Aux) :- AllRule = Aux.
sumRuleList([Obj|T], AllRule, Aux) :-
  setof(Clause, are(Obj,Clause), ClauseList),
  append([Aux,ClauseList],Aux2),
  sumRuleList(T, AllRule, Aux2).


restrictList([],_).
restrictList([H|T],Obj) :-
  are(Obj,H),
  restrictList(T,Obj).

showlist([]).
showlist([H|T]) :-
  show(H),
  showlist(T).