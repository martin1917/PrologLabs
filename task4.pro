domains
	list_numbers = integer*
  
predicates
	readlist(list_numbers)
	split(list_numbers, list_numbers, list_numbers)
  
clauses
	readlist([Head|Tail]) :-
		write("enter element: "),
		readint(Head), !,
		readlist(Tail).		
	readlist([]).

	split([Head|Tail], [Head|TailPos], Neg) :- 
		Head >= 0,
		split(Tail, TailPos, Neg).
	split([Head|Tail], Pos, [Head|TailNeg]) :- 
		Head < 0, 
		split(Tail, Pos, TailNeg).
	split([],[],[]).
	
goal
	readlist(List),
	split(List, L1, L2),
	write(List), nl,
	write(L1), nl,
	write(L2), nl.