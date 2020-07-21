/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Gale-Shapley Algorithm for a STABLE MATCHING, implemented in Prolog
   This task is also known as determining a STABLE MARRIAGE.
   Written Jan. 17th 2007 by Markus Triska (triska@metalevel.at)
   Public domain code.

   Tested with Scryer Prolog.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- use_module(library(clpz)).
:- use_module(library(dcgs)).
:- use_module(library(lists)).
:- use_module(library(assoc)).
:- use_module(library(pairs)).

man_preferences(a, [c,b,d,a]).
man_preferences(b, [b,a,c,d]).
man_preferences(c, [b,d,a,c]).
man_preferences(d, [c,a,d,b]).

woman_preferences(a, [a,b,d,c]).
woman_preferences(b, [c,a,d,b]).
woman_preferences(c, [c,b,d,a]).
woman_preferences(d, [b,a,c,d]).

%?- stable_marriage(M).
%@    M = [a-d,b-a,c-b,d-c]
%@ ;  false.

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Structures used:

   MPs is an association list associating men with their remaining
   preference lists.

   WPs is an association list with keys wm(Woman,Man) associated to
   values -- lower value means higher preference of Woman for Man.

   A (tentative) marriage is represented as a list of pairs Man-Woman.

   Initially, all women are married to the "omega" man, who is worse
   than anyone on their preference lists. Men from the instance are
   wrapped with "user(_)" to also allow the atom "omega" in instances.

   DCGs are used to implicitly pass states through. See the DCG Primer
   for more information:

      https://www.metalevel.at/prolog/dcg
      ===================================

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

stable_marriage(Ms) :-
        initial_marriage(Ms0),
        findall(M-P, man_preferences(M,P), MPs0),
        list_to_assoc(MPs0, MPs),
        pairs_keys_values(MPs0, Men, _),
        findall(W-P, woman_preferences(W,P), WPs0),
        empty_assoc(E),
        phrase(women_preferences(WPs0), [E], [WPs]),
        phrase(marry_men(Men), [s(WPs,MPs,Ms0)], [s(_,_,Ms1)]),
        maplist(without_wrapper, Ms1, Ms2),
        keysort(Ms2, Ms).

without_wrapper(user(M)-W, M-W).

initial_marriage(Ms) :- findall(omega-W, woman_preferences(W,_), Ms).

women_preferences([]) --> [].
women_preferences([W-Ps|WPs]) -->
        preferences_woman(Ps, W, 0),
        women_preferences(WPs).

preferences_woman([], _, _) --> [].
preferences_woman([M|Ms], W, N0) -->
        state0_state(WPs0, WPs1),
        { put_assoc(wm(W,M), WPs0, N0, WPs1),
          N1 #= N0 + 1 },
        preferences_woman(Ms, W, N1).

marry_men([])     --> [].
marry_men([M|Ms]) --> marry_man(user(M)), marry_men(Ms).

state0_state(S0, S), [S] --> [S0].

marry_man(omega)     --> [].
marry_man(user(Man)) -->
        state0_state(s(WPs,MPs0,Ms0), s(WPs,MPs1,Ms2)),
        { get_assoc(Man, MPs0, [BestWoman|_]),
          memberchk(CurrentMan-BestWoman, Ms0),
          (   CurrentMan = user(Current) ->
              get_assoc(wm(BestWoman,Current), WPs, CurrentPref),
              get_assoc(wm(BestWoman,Man), WPs, NewPref)
          ;   true
          ),
          (   (   CurrentMan == omega ; NewPref #< CurrentPref ) ->
              once(select(CurrentMan-BestWoman, Ms0, Ms1)),
              Ms2 = [user(Man)-BestWoman|Ms1],
              X = CurrentMan
          ;   Ms2 = Ms0, X = user(Man)
          ),
          (   X = user(R) ->
              % man R was rejected, delete the woman from his preference list
              get_assoc(R, MPs0, RPs0),
              once(select(BestWoman, RPs0, RPs)),
              put_assoc(R, MPs0, RPs, MPs1)
          ;   MPs1 = MPs0
          ) },
        marry_man(X).
