/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Find all stable matchings (stable marriages) by exhaustive search.
   Written Jan. 17th 2007 by Markus Triska (triska@metalevel.at)
   Public domain code.

   Note that there are much more efficient algorithms for this task!
   See for example the Gale-Shapley algorithm, available from:

   https://www.metalevel.at/misc/galeshapley.pl
   ============================================

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- use_module(library(pairs)).
:- use_module(library(clpz)).
:- use_module(library(lists)).
:- use_module(library(dif)).

man_preferences(a, [e,d,c,b,a]).
man_preferences(b, [a,e,d,c,b]).
man_preferences(c, [b,a,e,d,c]).
man_preferences(d, [c,b,a,e,d]).
man_preferences(e, [d,c,b,a,e]).

woman_preferences(a, [a,b,c,d,e]).
woman_preferences(b, [b,c,d,e,a]).
woman_preferences(c, [c,d,e,a,b]).
woman_preferences(d, [d,e,a,b,c]).
woman_preferences(e, [e,a,b,c,d]).

%?- stable_marriage(M).
%@    M = [a-a,b-b,c-c,d-d,e-e]
%@ ;  M = [a-e,b-a,c-b,d-c,e-d]
%@ ;  false.

stable_marriage(Pairs) :-
    Ms0 = [a,b,c,d,e],
    permutation(Ms0, Ms),
    pairs_keys_values(Pairs, Ms0, Ms),
    \+ unstable_marriage(Pairs).

unstable_marriage(Pairs) :-
    member(Man-Woman, Pairs),
    woman_index(Woman, Man, WI),
    dif(Man1, Man),
    member(Man1-Woman1, Pairs),
    man_index(Man1, Woman1, MI1),
    man_index(Man1, Woman, MI2),
    MI2 #< MI1,
    woman_index(Woman, Man1, WI1),
    WI1 #< WI.

man_index(Man, Woman, I) :- man_preferences(Man, Ps), once(nth0(I, Ps, Woman)).

woman_index(Woman, Man, I) :-
    woman_preferences(Woman, Ps),
    once(nth0(I, Ps, Man)).

permutation([], []).
permutation([X|Xs], Ys) :-
    permutation(Xs, Yss),
    select(X, Ys, Yss).

once(G) :- G, !.

nth0(N, Ls, L) :-
    zcompare(C, 0, N),
    nth0_(C, N, Ls, L).

nth0_(=, _, [L|_], L).
nth0_(<, N0, [_|Ls], L) :-
    N #= N0 - 1,
    zcompare(C, 0, N),
    nth0_(C, N, Ls, L).
