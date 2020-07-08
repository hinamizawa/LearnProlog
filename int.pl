:- use_module(library(clpfd)).

is_integer(0).
is_integer(X) :- X #= Y+1, is_integer(Y).

is_integer1(0).
is_integer1(X) :- is_integer1(Y), X is Y+1.