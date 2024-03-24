domains
	conditions = number*
	number = integer

database
	yes(number)
	no(number)

predicates
	do_expert_job
	do_consulting
	process(integer)
	
	clear
	eval_reply(char)
	
	go
	check(conditions)
	inpo(number, string, string)
	do_answer(number, number)

	cond(number, string, string)
	rule(number, string, conditions)

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
	cond(8, type_gas, liquid_gas).

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
	
	do_consulting :- clear, nl, go, !.		
	do_consulting :- nl, write("I cant help you").
	do_consulting.
	
	eval_reply('y'):- write("I hope you have found this helpful !").
	eval_reply('n'):- write("I am sorry I can't help you !").
	
	go :- 
		rule(_, Name, Conds),
		check(Conds),
		write("the gas boilers you have indicated is a(n)", Name, "."), nl,
		write("Is a gas boilers you would like to have (y/n)?"), nl,
		readchar(R),
		eval_reply(R).
	
	go :- write("Not found"), nl.
	
	check([CondNum | Rest]) :-
		yes(CondNum), !,
		check(Rest).
	
	check([CondNum | _]) :-
		no(CondNum), !, fail.
	
	check([CondNum | Rest]) :-
		cond(CondNum, Prop, Value),
		inpo(CondNum, Prop, Value),
		check(Rest).
		
	check([]).
	
	inpo(CondNum, Prop, Value) :-
		write("Question:- ", Prop, "    ", Value, " ? "), nl,
		write("\tType 1 for 'yes': "), nl,
		write("\tType 2 for 'no': "), nl,
		readint(Response),
		do_answer(CondNum, Response).
	
	do_answer(_, 0) :- exit.
	
	do_answer(CondNum, 1) :- 
		assert(yes(CondNum)),
		write("yes"), nl.
		
	do_answer(CondNum, 2) :- 
		assert(no(CondNum)),
		write("no"), nl, fail.

	clear:-
		retract(yes(_)), fail;
		retract(no(_)), fail;
		!.