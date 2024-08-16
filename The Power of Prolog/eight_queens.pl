:- use_module(library(clpfd)).

noattack(_,[]).

noattack(X/Y, [X1/Y1|Queens]):-
    X #\= X1,       % not in same column
    Y #\= Y1,       % not in same row
    Y1-Y #\= X1-X,  % not on ascending diagonal
    Y1-Y #\= X-X1,  % not on descending diagonal
    noattack(X/Y, Queens).


move(Queens,[X/Y|Queens]):-
    length(Queens, Length),
    X #= 8 - Length,
    Y in 1..8,
    noattack(X/Y, Queens),
    label([X,Y]).

goal(Queens) :- length(Queens,8).

solve_depthfirst(Node, [Node|Path]) :-
    depthfirst(Node, Path).

depthfirst(Node, []) :-
    goal(Node).

depthfirst(Node, [NextNode|Path]) :-
    move(Node, NextNode),depthfirst(NextNode, Path).