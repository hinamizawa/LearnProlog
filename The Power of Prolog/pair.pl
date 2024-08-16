possible_pair(X,Y) :- boy(X),girl(Y).
possible_pair1(X,Y) :- boy(X),!,girl(Y).

boy(john).
boy(bob).
boy(charli).

girl(alice).
girl(eve).
girl(lily).
girl(lucy).