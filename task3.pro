domains
	list_numbers = integer*
	
predicates
	readlist(list_numbers)
	max_item(list_numbers, integer, integer)

clauses
	readlist([Head|Tail]) :-
		write("enter element: "),
		readint(Head), !,
		readlist(Tail).		
	readlist([]).
	
	max_item([H|T], Max, Pos) :-
		max_item(T, MaxTail, PosTail),
		H < MaxTail,
		Max = MaxTail,
		Pos = PosTail + 1.
	max_item([H|_], H, 0).
	
goal
	readlist(List),
	max_item(List, Max, Pos),
	write(List), nl,
	write("Max: "), write(Max), nl,
	write("I: "), write(Pos), nl.