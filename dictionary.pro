:- load(list).
:- import(list).

word("alive").
word("all").
word("and").
word("are").
word("bmm"). % same as all but shifted 1 place (to see if it work when there many possible keys)
word("can").
word("they").
word("run").
word("when").
word("work").
word("zebras").

sol(Length) :-
	word_of_length(Length, Word),
	write(Word), nl,
	fail,
	sol(Length).

word_of_length(Length, Result) :-
	word(X),
	length(X, Length).
	
exists(Word):-
	word(X),
	Word == X.

