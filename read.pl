readterms(Infile):-
    seeing(S),see(Infile),
    repeat,read(X),write(X),nl,X=end,
    seen,see(S).

go :- readterms('read.txt').