predicates
	parent(symbol, symbol)
	marriage(symbol, symbol)
	men(symbol)
	women(symbol)

	father(symbol, symbol)
	mother(symbol, symbol)
	grantfather(symbol, symbol)
	grantmother(symbol, symbol)
	hasSameParents(symbol, symbol)
	brother(symbol, symbol)
	sister(symbol, symbol)
	aunt(symbol, symbol)
	uncle(symbol, symbol)
	svecrove(symbol, symbol)
	teshja(symbol, symbol)


clauses

	women(galya).
	women(irina).
	women(larisa).
	women(lena).
	women(ylya).
	women(anya).
	women(tanya).
	women(masha).

	men(yra).
	men(kolya).
	men(vova).
	men(jenya).
	men(maksim).
	men(denis).

	marriage(galya, yra).
	marriage(irina, kolya).
	marriage(larisa, vova).
	marriage(tanya, maksim).
	marriage(masha, denis).

	parent(galya, irina).
	parent(galya, vova).
	parent(irina, lena).
	parent(irina, ylya).
	parent(larisa, anya).
	parent(larisa, jenya).
	parent(tanya, kollya).
	parent(masha, larisa).
	parent(yra, irina).
	parent(yra, vova).
	parent(kolya, lena).
	parent(kolya, ylya).
	parent(vova, anya).
	parent(vova, jenya).
	parent(maksim, kolya).
	parent(denis, larisa).


	mother(X, Y) :- parent(X, Y), women(X).
	father(X, Y) :- parent(X, Y), men(X).
	grantfather(X, Y) :- father(X, Y1), parent(Y1, Y).
	grantmother(X, Y) :- mother(X, Y1), parent(Y1, Y).

	hasSameParents(X, Y) :-
		mother(M, X), father(F, X),
		mother(M, Y), father(F, Y).

	brother(X, Y) :- 
		men(X),
		hasSameParents(X, Y).

	sister(X, Y) :- 
		women(X),
		hasSameParents(X, Y).

	aunt(X, Y) :-
		women(X),
		parent(P, Y),
		hasSameParents(X, P).
		
	uncle(X, Y) :-
		men(X),
		parent(P, Y),
		hasSameParents(X, P).
		
	svecrove(X, Y) :-
		mother(X, Son),
		men(Son),
		marriage(Son, Y),
		women(Y).
		
	teshja(X, Y) :-
		mother(X, D),
		women(D),
		marriage(D, Y),
		men(Y).