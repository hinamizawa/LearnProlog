:- use_module(library(clpfd)).

test(X,Y):-
    X in 0..10,
    Y in 4..8,
    X #> Y.


foo(X) :- X in 1..3.
foo(X) :- X in 5..7.
foo(X) :- X in 8..12.

puzzle([S,E,N,D]+[M,O,R,E]=[M,O,N,E,Y]):-
    Vars= [S,E,N,D,M,O,R,Y],
    Vars ins 0..9,
    all_distinct(Vars),
        S*1000+E*100+N*10+D+
        M*1000+O*100+R*10+E #=
        M*10000+O*1000+N*100+E*10+Y,
    M #\= 0, S#\= 0,
    label(Vars).

puzzle2([F,O,R,T,Y]+[T,E,N]+[T,E,N]=[S,I,X,T,Y]) :-
    Vars = [F,O,R,T,Y,E,N,X,S,I],
    Vars ins 0..9,
    all_distinct(Vars),
    F*10000+O*1000+R*100+T*10+Y+
    T*100+E*10+N+
    T*100+E*10+N #=
    S*10000+I*1000+X*100+T*10+Y,
    F #\= 0, T #\= 0, S #\= 0,
    label(Vars).

increase([]).
increase([_]).
increase([X,Y]) :- X #< Y, !.
increase([X,Y|T]) :- X #< Y, !, increase([Y|T]).