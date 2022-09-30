predicates
	andInv(integer, integer, integer)
	diz(integer, integer, integer)
clauses
	andInv(0, 0, 1).
	andInv(0, 1, 1).
	andInv(1, 0, 1).
	andInv(1, 1, 0).
	diz(0, 0, 0).
	diz(0, 1, 1).
	diz(1, 0, 1).
	diz(1, 1, 1).
goal
	andInv(X1,X2,Y1),diz(X3,X4,Y2),andInv(Y1,Y2,Y3),diz(Y2,Y3,Y),
	write("Y X1-X4 -> "),write(Y),
	write(" "), write(X1), write(" "), write(X2),
	write(" "),write(X3), write(" "), write(X4),fail.
