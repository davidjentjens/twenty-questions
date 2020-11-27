/* Base Tree */

tree(guessTree, 
  t('É um mamífero?', 
    t('Tem listras?', 
      t('Zebra', nil, nil),
      t('Leão', nil, nil)
    ),
    t('É um passaro?',
      t('Ele voa?', 
        t('Águia', nil, nil),
        t('Pinguim', nil, nil)
      ),
      t('Lagarto', nil, nil)
    )
  )
).

/* Helper Functions */

istree(nil).
istree(t(_,L,R)) :- istree(L), istree(R).

is_animal(t(_,L,R)) :- L = nil, R = nil.

extract_guess(t(String,_,_), String).

extract_left_branch(t(_,L,_), L).
extract_right_branch(t(_,_,R), R).

/* Add new animal and question */


replace_existing_fact(OldFact, NewFact) :-
  call(OldFact), !,   % Dont backtrack to find multiple instances of old fact
  retract(OldFact),
  assertz(NewFact).

find_and_replace_leaf(t(CurrentNodeName, L, R), nil, NewLeafName, NewTree).
find_and_replace_leaf(t(CurrentNodeName, L, R), OldLeafName, NewLeafName, NewTree) :- 
  (
    extract_guess(L, LeftName),
    OldLeafName = LeftName,
    replace_existing_fact(L, NewTree),
    !
  );
  (
    extract_guess(R, RightName),
    OldLeafName = RightName,
    replace_existing_fact(R, NewTree),
    !
  );
  (
    find_and_replace_leaf(L, OldLeafName, NewLeafName, NewTree),
    find_and_replace_leaf(R, OldLeafName, NewLeafName, NewTree)
  ).
  /*
  CurrentNodeName = OldLeafName,
    replace_existing_fact(CurrentNodeName, NewLeafName)
  */

/* Functions */



decision_tree(GuessTree, GuessedAnimal, Decision) :-
  (
    is_animal(GuessTree),
    extract_guess(GuessTree, Animal),
    write('É um '), write(Animal), write('? (s/n)'),
    read(IsCorrect), nl,
    GuessedAnimal = GuessTree,
    (
      (
        IsCorrect = s,
        Decision = 'Correto'
      );
      (
        IsCorrect = n,
        Decision = 'Incorreto'
      )
    )
  );
  (
    extract_guess(GuessTree, Question), write(Question), write(' (s/n)'),
    read(Answer), nl,
    (
      Answer = s,
      extract_left_branch(GuessTree, L),
      decision_tree(L, GuessedAnimal, Decision)
    );
    (
      Answer = n,
      extract_right_branch(GuessTree, R),
      decision_tree(R, GuessedAnimal, Decision)
    )
  ).

store_tree(GuessTree, GuessedAnimalName, AnimalName, Question, Answer) :- 
  (
    Answer = s,
    NewTree = t(Question, t(AnimalName, nil, nil), t(GuessedAnimalName, nil, nil))
  );
  (
    Answer = n,
    NewTree = t(Question, t(GuessedAnimalName, nil, nil), t(AnimalName, nil, nil))
  ),
  find_and_replace_leaf(GuessTree, GuessedAnimalName, AnimalName, NewTree).

/* Execution */

start :-
  write('Bem-vindo ao jogo dos animais. Vou tentar adivinhar qual está pensando.'),nl,
  tree(guessTree, GuessTree), 
  decision_tree(GuessTree, GuessedAnimal, Decision), nl,
  (
    (
      Decision = 'Correto',
      write('YAY! Adivinhei seu animal!'), nl,
      !,
      fail
    );
    (
      Decision = 'Incorreto', 
      write('Puxa! Eu não sei! Qual animal pensou?'), nl,
      read(AnimalName),
      extract_guess(GuessedAnimal, GuessedAnimalName),
      format('Qual pergunta devo fazer para distinguir "~w" de "~w"?', [AnimalName, GuessedAnimalName]), nl,
      read(Question),
      format('Agora digite qual a resposta certa para "~w" (s / n)', [AnimalName]), nl,
      read(Answer),
      store_tree(GuessTree, GuessedAnimalName, AnimalName, Question, Answer),
      write('YAAAY! Obrigado, agora eu sei como ler a sua mente mais um pouquinho! Toma um s7 ß!'), nl
    )
  ).

  /*
  teste :- 
  Old = t('Leão', nil, nil),
  New = t('Ele ruge?', t('Leão', nil, nil), t('Cavalo', nil, nil)),
  replace_existing_fact(Old, New).

replace_each_existing_fact(OldFact, NewFact) :-
    forall(replace_existing_fact(OldFact, NewFact), true).
  
  write().
  % TODO: Fazer os paranaues necessarios para a nova pergunta existir
  % A pergunta substitui o Guess e recoloca ele do lado oposto a resposta nova colocada.*/

  /*
  decision_tree(Decision, Guess) :-
    is_animal(Guess), Aswer = ;
    decision_tree()
    % (format('É um(a) ~w?', Animal), nl);
    % decision_tree(X).
    Decision = 'Incorrect', Guess = 'Fred'.
    */