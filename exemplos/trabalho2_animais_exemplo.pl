
% seleciona uma resposta
resposta(A) :- random(0,2,X), ((A=s,X=1,!);(A=n,X=0,!)).

% main loop
ola :- resposta(A), 
        nl,
        write('Advinhe minha resposta, responderei sim ou nao? (s p/ sim, n para nao e q para sair)'),nl,
        write('Nao esqueca de finalizar sua resposta com . ex: s. ou n.'),nl,
        read(X),
        nl,
        (
            (X = 'q', write("ate breve!"), !, fail);
            (A = X, write("Voce acertou!"), nl, ola,!);
            (A \= X, write("Voce errou!"), nl, ola,!)
         ).
