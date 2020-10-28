/* Functions */

question_prompt(X) :-
  write('Is it a mammal?'),
  nl,
  read(X).

/* Execution */

start :-
  write('Welcome to 20 questions - Prolog version!'),nl,
  question_prompt(X),nl,
  format('You chose the answer ~w', X).