domains
	list = integer*
	list_of_lists = list*

predicates
	readlist(list)
	reverse(list, list)
	reverse_internal(list, list, list)
	palindrom(list)
	subseq(list, list)
	prefix_subseq(list, list)
	lenght_list(list, integer)
	lenght_list_internal(list, integer, integer)
	all_subseq(list, list_of_lists)
	all_pal(list, list_of_lists)
	extractPalindrom(list_of_lists, list_of_lists)
	find_max_palindrom(list_of_lists, list)
	find_max_palindrom_internal(list_of_lists, list, integer, list)
	solve(list, list)

clauses
	/* Заполнение списка */
	readlist([Head|Tail]) :-
		write("enter element: "),
		readint(Head), !,
		readlist(Tail).		
	readlist([]).
	
	/*переворот списка*/
	reverse(List1, List2) :- 
		reverse_internal(List1, [], List2).
		
	reverse_internal([], Buffer, Buffer).
	
	reverse_internal([Head|Tail], Buffer, List2) :- 
		reverse_internal(Tail, [Head|Buffer], List2).
		
	/*проеврка на палиндром*/
	palindrom(List) :- reverse(List, List).

	/*получение всех подсписков*/
	subseq([], []).
	subseq([_|Xs], Ys) :- subseq(Xs, Ys).
	subseq([X|Xs], [X|Ys]) :- prefix_subseq(Xs, Ys).
	prefix_subseq(_, []).
	prefix_subseq([X|Xs], [X|Ys]) :- prefix_subseq(Xs, Ys).

	/*длина списка*/
	lenght_list(List, Length) :- lenght_list_internal(List, 0, Length).
	lenght_list_internal([], Lenght, Lenght).
	lenght_list_internal([_|Tail], BufferSize, Lenght) :-
		NewBufferSize = BufferSize + 1,
		lenght_list_internal(Tail, NewBufferSize, Lenght).

	/* Получение всех подсписков*/
	all_subseq(List, ListOfLists) :- findall(SubList, subseq(List, SubList), ListOfLists).

	/* извлечение подсписков, являющихся палиндромами */
	all_pal(List, Palindroms) :- 
		all_subseq(List, SubLists), extractPalindrom(SubLists, Palindroms).
	extractPalindrom([], []).
	extractPalindrom([SubList|RestSubLists], [SubList|RestPalindroms]) :- 
		palindrom(SubList), !, extractPalindrom(RestSubLists, RestPalindroms).
	extractPalindrom([_|T], Palindroms) :- extractPalindrom(T, Palindroms).

	/* Получение максимального палиндрома */
	solve(List, MaxPalindrom) :- 
		all_pal(List, Palindroms),
		find_max_palindrom(Palindroms, MaxPalindrom).

	find_max_palindrom([FirstPalindrom|Rest], MaxPalindrom) :-
		lenght_list(FirstPalindrom, Len),
		find_max_palindrom_internal(Rest, FirstPalindrom, Len, MaxPalindrom).

	find_max_palindrom_internal([], MaxPalindrom, _, MaxPalindrom).

	find_max_palindrom_internal([FirstPalindrom|Rest], _, CurrentLen, MaxPalindrom) :-
		lenght_list(FirstPalindrom, Len),
		Len > CurrentLen,
		find_max_palindrom_internal(Rest, FirstPalindrom, Len, MaxPalindrom).

	find_max_palindrom_internal([_|Rest], CurrentMaxPalindrom, CurrentLen, MaxPalindrom) :-
		find_max_palindrom_internal(Rest, CurrentMaxPalindrom, CurrentLen, MaxPalindrom).

goal
	readlist(List),
	solve(List, Res),
	write(Res), nl.