% 1.01 (*) Find the last element of a list.
my_last(X,[X]).
my_last(X,[_|T]) :- my_last(X,T).

% 1.02 (*) Find the last but one element of a list.
second_last(X,[X,_]).
second_last(X,[_|T]) :- second_last(X,T).

% 1.03 (*) Find the K'th element of a list.
element_at(X,[X|_],1).
element_at(X,[_|T],N) :-
    M is N-1,
    !,
    element_at(X,T,M).

% 1.04 (*) Find the number of elements of a list.
my_len([],0).
my_len([_|T],N) :-
    my_len(T,M),
    N is M+1.