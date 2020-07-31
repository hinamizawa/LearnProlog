check(Rel,A,B) :- 
    Goal =.. [Rel,A,B],
    call(Goal).

bubblesort(Rel, List, Sorted) :-
    swap(Rel,List,NewList), !,
    bubblesort(Rel,NewList,Sorted).

bubblesort(_,Sorted,Sorted).

swap(Rel,[A,B|List],[B,A|List]) :-
    check(Rel,B,A).

swap(Rel,[A|List],[A|NewList]) :-
    swap(Rel,List, NewList).