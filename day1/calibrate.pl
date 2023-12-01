

read_from_file(Filename, Lines) :-
	open(Filename, read, Stream),
	read_all_lines(Stream, Lines).

read_all_lines(Stream, []) :-
	at_end_of_stream(Stream).

read_all_lines(Stream, [X|L]) :-
	\+ at_end_of_stream(Stream),
	read_string(Stream, "\n", "\r", _, X),
	read_all_lines(Stream, L).

write_list(_, []).

write_list(Stream, [H|T]) :-
	write(Stream, H),
	write(Stream, "\n"),
	write_list(Stream, T).

write_to_file(F, L) :-
	open(F, write, Stream),
	write_list(Stream, L).


solve(R) :-
	read_from_file("input.txt", L),
	calibrate_list(L, C),
	sum(C, R),
	write_to_file("output.txt", C).

calibrate(X, R) :-
	string_chars(X, Chars),
	first_number(Chars, A),
	reverse(Chars, RChars),
	first_number(RChars, B),
	string_concat(A, B, R).

/*To get first number, either the head is a number or we need to check the rest of the string */
first_number(S, R) :-
	string_chars(S, [H|_]),
	atom_number(H, R).

first_number(S, R) :-
	string_chars(S, [H|T]),
	first_number(T, R).

calibrate_list([X|Y], [A|B]) :-
	calibrate(X,A),
	calibrate_list(Y,B).

calibrate_list([], []).

sum([H|T], R) :-
	atom_number(H, X),
	sum(T, Rest),
	R is X + Rest.

sum([], 0).
