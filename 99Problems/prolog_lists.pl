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
my_flatten([H],X) :- 
    (is_list(H) -> !, my_flatten(H,X); 
                   !, append([H],[],X)).

my_flatten([H|T],X) :-
    (is_list(H) -> !,append(Y,Z,X), my_flatten(H,Y), my_flatten(T,Z); 
                   !,append([H],Y,X), my_flatten(T,Y)).
/*
flatten(List, FlatList) :-
    flatten(List, [], FlatList0),
    !,
    FlatList = FlatList0.

flatten(Var, Tl, [Var|Tl]) :-
    var(Var),
    !.
flatten([], Tl, Tl) :- !.
flatten([Hd|Tl], Tail, List) :-
    !,
    flatten(Hd, FlatHeadTail, List),
    flatten(Tl, Tail, FlatHeadTail).
flatten(NonList, Tl, [NonList|Tl]).
*/

% 1.08 (**) Eliminate consecutive duplicates of list elements.
compress([],[]).
compress([X],[X]).
compress([X,X|T],[X|L]) :- !, compress([X|T],[X|L]).
compress([X,Y|T],[X,Y|L]) :- X \= Y, !,compress([Y|T],[Y|L]).