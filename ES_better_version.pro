domains
	list_int = integer*

database
	yes(integer)
	no(integer)
	maybe(integer)

predicates
	do_expert_job
	do_consulting
	process(integer)
	
	clear
	
	go(symbol)
	check(list_int)
	inpo(integer, string, string)
	do_answer(integer, integer)

	cond(integer, string, string)
	rule(integer, string, list_int)
	
	ex_cond(list_int)
	member(integer, list_int)
	subset(list_int, list_int)
	find_exc_conds(integer, list_int)
	add_exc_cond_to_no(integer, list_int)
	
	allYes(list_int)
	finding(list_int)

goal
	do_expert_job.

clauses
	/* напольный или настенный */
	cond(1, type_mount, wall).
	cond(2, type_mount, floor).

	/* Одноконтурный или Двухконтурный */
	cond(3, type_contur, single_circuit).
	cond(4, type_contur, dual_circuit).

	/* вид камеры сгорания (открытая, закрытая) */
	cond(5, burn_container, open).
	cond(6, burn_container, close).

	/* вид энергоносителя (газ или сжиженный газ) */
	cond(7, type_gas, simple_gas).
	cond(8, type_gas, list_intquid_gas).

	/* материал теплообменика (сталь, чугун, медь) */
	cond(9, material, copper).
	cond(10, material, steel).
	cond(11, material, iron).

	/* встроенный бойлер (да, нет) */
	cond(12, builtin_boiler, yes).
	cond(13, builtin_boiler, no).

	/* отапливаемая площадь */
	cond(14, square, "[0; 100]").
	cond(15, square, "[100; 200]").
	cond(16, square, "[200; 300]").
	cond(17, square, "[300; ...]").

	ex_cond([1, 2]).
	ex_cond([3, 4]).
	ex_cond([5, 6]).
	ex_cond([7, 8]).
	ex_cond([9, 10, 11]).
	ex_cond([12, 13]).
	ex_cond([14, 15, 16, 17]).

	rule(1, "LUNA-3 Comfort 1.240 I", [1, 3, 5, 7, 10, 13, 16]).
	rule(2, "ECO Four 24 F", [1, 4, 6, 8, 9, 13, 16]).
	rule(3, "World Alpha-10", [1, 4, 6, 8, 10, 12, 14]).
	rule(4, "Zena MS 24 FF", [1, 3, 6, 7, 11, 12, 15]).
	rule(5, "FGB-K-24", [1, 4, 6, 8, 11, 13, 16]).
	rule(6, "ecoTEC intro VUW 18/24 AS/1-1", [1, 4, 6, 7, 9, 13, 17]).
	rule(7, "LUNA-MIN 1.360 G", [2, 4, 5, 7, 11, 13, 15]).
	rule(8, "ECO-TRY FIVE 11 E", [2, 3, 5, 8, 10, 12, 17]).
	rule(9, "World Beta-17", [2, 4, 6, 7, 10, 13, 14]).
	rule(10, "LUNA-3 Comfort 1.240 I", [2, 4, 5, 7, 9, 12, 16]).
	
	do_expert_job :-
		makewindow(1, 7, 7, "Expert", 1, 16, 22, 58),
		nl,write(" * * * * * * * * * * * * * * * * * * * * *  "),
		nl,write("          Hello!          "),nl,nl,
		nl,write(" gas boiler identification in progress "),nl,nl,
		nl,write(" * * * * * * * * * * * * * * * * * * * * * * "),
		nl,nl,do_consulting,write("Press any key"),
		nl, readchar(_), removewindow.
	
	process(1):- do_consulting.
	process(2):- exit.
	
	do_consulting :- clear, nl, go("Start").
	
	go(G) :- 
		G="Start",
		rule(_, Name, Conds),
		check(Conds),
		go(Name).
	
	go(G) :- 
		not(G="Start"),
		allYes(Facts),
		write("Variants: "), nl,
		finding(Facts).
	
	go(_) :- write("Nothing :("), nl, !.
	
	check([CondNum | Rest]) :- yes(CondNum), !, check(Rest).
	check([CondNum | Rest]) :- maybe(CondNum), !, check(Rest).
	check([CondNum | _]) :- no(CondNum), !, fail.
	
	check([CondNum | Rest]) :-
		cond(CondNum, Prop, Value),
		inpo(CondNum, Prop, Value),
		check(Rest).
		
	check([]).
	
	inpo(CondNum, Prop, Value) :-
		write("Question:- ", Prop, "    ", Value, " ? "), nl,
		write("\tType 1 for 'yes': "), nl,
		write("\tType 2 for 'no': "), nl,
		write("\tType 3 for 'i don't know': "), nl,
		readint(Response),
		do_answer(CondNum, Response).
	
	do_answer(_, 0) :- exit.
	
	do_answer(CondNum, 3) :- 
		assert(maybe(CondNum)), nl.
	
	do_answer(CondNum, 2) :- 
		assert(no(CondNum)),
		write("no"), nl, fail.
	
	do_answer(CondNum, 1) :- 
		assert(yes(CondNum)),
		write("yes"), nl,
		find_exc_conds(CondNum, Res),
		add_exc_cond_to_no(CondNum, Res).	
	
	member(Elem, [Elem|_]).
	member(Elem, [_|Tail]):- member(Elem, Tail).
	
	subset([], _).
	subset([H|Rest], List) :-
		member(H, List),
		subset(Rest, List).
		
	allYes(Facts) :- findall(Num, yes(Num), Facts).
	
	finding(YesFacts) :-
		rule(_, Name, Conds),
		subset(YesFacts, Conds),
		write("Gas boilers: ", Name), nl, fail.
	
	find_exc_conds(N, Res) :-
		ex_cond(List),
		member(N, List), !,
		Res=List.
	
	add_exc_cond_to_no(_, []).
	
	add_exc_cond_to_no(N, [H|Rest]) :-
		N<>H,
		not(no(H)),
		assert(no(H)),
		add_exc_cond_to_no(N, Rest).
		
	add_exc_cond_to_no(N, [_|Rest]) :- add_exc_cond_to_no(N, Rest).

	clear:-
		retract(yes(_)), fail;
		retract(no(_)), fail;
		retract(maybe(_)), fail;
		!.