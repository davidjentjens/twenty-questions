/* Functions */

decision_tree(Decision, Guess) :-
  % (format('É um(a) ~w?', Animal), nl);
  % decision_tree(X).
  Decision = 'Incorrect', Guess = 'Fred'.

store_tree(Guess, Animal, Question, Answer)
  % TODO: Fazer os paranaues necessarios para a nova perguna existir
  % A pergunta substitui o Guess e recoloca ele do lado oposto a resposta nova colocada.
  
/* Execution */

start :-
  write('Bem-vindo ao jogo dos animais. Vou tentar adivinhar qual está pensando.'),nl,
  decision_tree(Decision, Guess),nl,
  (
    (
      Decision = 'Correct',
      write('YAY! Adivinhei seu animal!'), nl,
      !,
      fail
    );
    (
      Decision = 'Incorrect', 
      write('Puxa! Eu não sei! Qual animal pensou?'), nl,
      read(Animal),
      format('Qual pergunta devo fazer para distinguir \"~w\" de \"~w\"?', [Animal, Guess]), nl,
      read(Question),
      format('Agora digite qual a resposta certa para \"~w\" (s / n)', [Animal]), nl,
      read(Answer),
      write('YAAAY! Obrigado, agora eu sei como ler a sua mente mais um pouquinho! Toma um s7 ß!'), nl
      % TODO: Pegar a pergunta e a resposta e associar o animal.
    )
  ).