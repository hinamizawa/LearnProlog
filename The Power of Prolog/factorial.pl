:- use_module(library(clpfd)).


factorial(0,1).
factorial(N,Nfact):- 
    N #> 0,
    N1 #= N-1,
    factorial(N1,Nfact1), 
    Nfact #= N * Nfact1.