database
	xpositive(symbol, symbol)
	xnegative(symbol, symbol)

predicates
	do_expert_job
	do_consulting
	ask(symbol, symbol)
	gas_boiler_is(symbol)
	positive(symbol, symbol)
	negative(symbol, symbol)
	remember(symbol, symbol, symbol)
	clear_facts

goal	
	do_expert_job.
	
clauses
	do_expert_job :- 
		makewindow(1, 7, 7, "EXPERT ON GAS BOILERS", 1, 16, 22, 58),
		nl, write(" * * * * * * * * * * * * * * * * * * * * *  "),
		nl, write("          WELCOME!          "),nl,nl,
		nl, write("Please answer 'yes' or 'no' "),
		nl, write("to questions about the characteristics of a gas boiler that "),
		nl, write("do you want to define "),
		nl, write(" * * * * * * * * * * * * * * * * * * * * * * "),
		nl, nl, do_consulting, write("Press any key"),
		nl, readchar(_), removewindow.

	do_consulting :- 
		gas_boiler_is(X), !, nl, 
		write("You probably need a gas boiler like this - ", X, "."), nl,
		clear_facts.

	do_consulting :- 
		nl, write("I'm sorry, I can't help you.!"),
		clear_facts.

	ask(X, Y) :- 
		write("?:- ", X, "    ", Y, "? "), nl,
		readln(Reply),
		remember(X, Y, Reply).

	positive(X, Y) :- xpositive(X, Y), !.
	positive(X, Y) :- not(negative(X, Y)), !, ask(X, Y).
	negative(X, Y) :- xnegative(X, Y), !.
	remember(X, Y, yes) :- asserta(xpositive(X,Y)).
	remember(X, Y, no) :- asserta(xnegative(X,Y)),fail.
	
	clear_facts :- retract(xpositive(_,_)), fail.
	clear_facts :- retract(xnegative(_,_)), fail.
	
	gas_boiler_is("LUNA-3 Comfort 1.240 I") :- 
		positive("Type of installation", "Wall"),
		positive("Type of heating", "single_circuit"),
		positive("Combustion chamber", "open"),
		positive("Type of energy carrier", "gas"),
		positive("Heat exchange material", "steel"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[200; 300]").
	
	gas_boiler_is("ECO Four 24 F") :- 
		positive("Type of installation", "Wall"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "close"),
		positive("Type of energy carrier", "liquid_gas"),
		positive("Heat exchange material", "copper"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[200; 300]").
	
	gas_boiler_is("World Alpha-10") :- 
		positive("Type of installation", "Wall"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "close"),
		positive("Type of energy carrier", "liquid_gas"),
		positive("Heat exchange material", "steel"),
		positive("Built-in boiler", "Yes"),
		positive("Heated area", "[0; 100]").
	
	gas_boiler_is("Zena MS 24 FF") :- 
		positive("Type of installation", "Wall"),
		positive("Type of heating", "single_circuit"),
		positive("Combustion chamber", "close"),
		positive("Type of energy carrier", "gas"),
		positive("Heat exchange material", "iron"),
		positive("Built-in boiler", "Yes"),
		positive("Heated area", "[100; 200]").
	
	gas_boiler_is("FGB-K-24") :- 
		positive("Type of installation", "Wall"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "close"),
		positive("Type of energy carrier", "liquid_gas"),
		positive("Heat exchange material", "iron"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[200; 300]").
	
	gas_boiler_is("ecoTEC intro VUW 18/24 AS/1-1") :-
		positive("Type of installation", "Wall"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "close"),
		positive("Type of energy carrier", "gas"),
		positive("Heat exchange material", "copper"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[300; ...]").
	
	gas_boiler_is("LUNA-MIN 1.360 G") :-
		positive("Type of installation", "floor"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "open"),
		positive("Type of energy carrier", "gas"),
		positive("Heat exchange material", "iron"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[100; 200]").
	
	gas_boiler_is("ECO-TRY FIVE 11 E") :-
		positive("Type of installation", "floor"),
		positive("Type of heating", "single_circuit"),
		positive("Combustion chamber", "open"),
		positive("Type of energy carrier", "liquid_gas"),
		positive("Heat exchange material", "steel"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[300; ...]").
	
	gas_boiler_is("World Beta-17") :-
		positive("Type of installation", "floor"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "close"),
		positive("Type of energy carrier", "gas"),
		positive("Heat exchange material", "steel"),
		positive("Built-in boiler", "No"),
		positive("Heated area", "[0; 100]").
		
	gas_boiler_is("LUNA-3 Comfort 1.240 I") :-
		positive("Type of installation", "floor"),
		positive("Type of heating", "dual_circuit"),
		positive("Combustion chamber", "open"),
		positive("Type of energy carrier", "gas"),
		positive("Heat exchange material", "copper"),
		positive("Built-in boiler", "Yes"),
		positive("Heated area", "[200; 300]").