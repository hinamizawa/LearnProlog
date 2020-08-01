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

% 1.05 (*) Reverse a list.
my_reverse(L, R) :- my_reverse(L,[],R).

my_reverse([H|T],A,R) :- my_reverse(T,[H|A],R).
my_reverse([],R,R).

/*
reverse(Xs, Ys) :-
    reverse(Xs, [], Ys, Ys).

reverse([], Ys, Ys, []).
reverse([X|Xs], Rs, Ys, [_|Bound]) :-
    reverse(Xs, [X|Rs], Ys, Bound).
*/

% 1.06 (*) Find out whether a list is a palindrome.
palindrome(X) :- reverse(X,X).

% 1.07 (**) Flatten a nested list structure.