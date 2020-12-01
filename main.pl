:- dynamic tree/2.

/* ----- EXEMPLO DE ÁRVORE ----- */

/*
tree(guessTree, 
  t('É um mamífero?', 
    t('Tem listras?', 
      t('Zebra', nil, nil),
      t('Ele ruge?',
        t('Ele hiberna?',
          t('Urso',nil,nil),
          t('Leão',nil,nil),
        )
        t('Cavalo',nil,nil))
      ),
    ),
    t('É um passaro?',
      t('Ele voa?', 
        t('Águia', nil, nil),
        t('Pinguim', nil, nil)
      ),
      t('Ele tem pernas?',
        t('Lagarto',nil,nil),
        t('Cobra',nil,nil)
      )
    )
  )
).
*/


/* ----- HELPER FUNCTIONS ----- */

/* Read tree from file */
read_tree() :- 
  see('saved_tree.txt'),
  read(Tree),
  seen,
  retractall(tree(guessTree, _)),
  asserta(tree(guessTree, Tree)).

/* Save tree to file */
save_tree_to_file() :- 
  tell('saved_tree.txt'),
  tree(guessTree, Tree),
  print(Tree),
  write('.'),
  told.

/* Checks if a given tree is a leaf */
is_animal(t(_,L,R)) :- L = nil, R = nil.

/* Extract guess string from tree node */
extract_guess(t(String,_,_), String).

/* Extract left or right branch from tree node */
extract_left_branch(t(_,L,_), L).
extract_right_branch(t(_,_,R), R).

/* Add new animal and question */
replace_leaf(t(Name, _, _), Name, NewTree, NewTree):- !.
replace_leaf(t(N, L, R), Name, NewTree, t(N, Ret, R)):- replace_leaf(L, Name, NewTree, Ret).
replace_leaf(t(N, L, R), Name, NewTree, t(N, L, Ret)):- replace_leaf(R, Name, NewTree, Ret).

find_and_replace_leaf(Name, NewTree) :-
  tree(guessTree, R),
  replace_leaf(R, Name, NewTree, Ret),
  retractall(tree(guessTree, _)),
  asserta(tree(guessTree, Ret)),
  !.


/* ----- LOGIC FUNCTIONS ----- */

/* Run through the decision tree to guess the user's answer */
decision_tree(GuessTree, GuessedAnimal, Decision) :-
  (
    is_animal(GuessTree),
    extract_guess(GuessTree, Animal),
    write('É um(a) '), write(Animal), write('? (s/n)'), nl,
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
    extract_guess(GuessTree, Question), write(Question), write(' (s/n)'), nl,
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

/* Store newly obtained knowledge in the tree file */
store_tree(GuessedAnimalName, AnimalName, Question, Answer) :- 
  (
    (
      Answer = s,
      NewTree = t(Question, t(AnimalName, nil, nil), t(GuessedAnimalName, nil, nil)),
      find_and_replace_leaf(GuessedAnimalName, NewTree)
    );
    (
      Answer = n,
      NewTree = t(Question, t(GuessedAnimalName, nil, nil), t(AnimalName, nil, nil)),
      find_and_replace_leaf(GuessedAnimalName, NewTree)
    )
  ),
  save_tree_to_file().


/* ----- EXECUTION ----- */

start :-
  read_tree(),
  write('Bem-vindo ao jogo dos animais. Pense em um animal e vou tentar adivinhar qual é.'), nl,
  tree(guessTree, GuessTree),
  decision_tree(GuessTree, GuessedAnimal, Decision), nl,
  (
    (
      Decision = 'Correto',
      write('YAY! Adivinhei seu animal!'), nl,
      !
    );
    (
      Decision = 'Incorreto', 
      write('Puxa! Eu não sei! Qual animal pensou? (Coloque sua resposta entre aspas simples: \')'), nl,
      read(AnimalName),
      extract_guess(GuessedAnimal, GuessedAnimalName),
      format('Qual pergunta devo fazer para distinguir "~w" de "~w"? (Coloque sua resposta entre aspas simples: \')', [AnimalName, GuessedAnimalName]), nl,
      read(Question),
      format('Agora digite qual a resposta certa para "~w" (s/n)', [AnimalName]), nl,
      read(Answer),
      store_tree(GuessedAnimalName, AnimalName, Question, Answer),
      write('YAAAY! Obrigado, agora eu sei como ler a sua mente mais um pouquinho!'), nl
    )
  ).