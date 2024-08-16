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

quicksort(_,[],[]).

quicksort(Rel,[Head|Tail],Sorted):-
    split(Rel, Head, Tail,Left,Right),
    quicksort(Rel,Left,SortedLeft),
    quicksort(Rel,Right,SortedRight),
    append(SortedLeft,[Head|SortedRight],Sorted).

split(_, _, [], [], []).

split(Rel, Middle, [Head|Tail], [Head|Left], Right) :-
    check(Rel, Head, Middle), 
    !,
    split(Rel, Middle, Tail, Left, Right).

split(Rel, Middle, [Head|Tail], Left, [Head|Right]) :-
    split(Rel, Middle, Tail, Left, Right).