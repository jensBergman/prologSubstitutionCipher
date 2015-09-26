
dappend(A-B, B-C, A-C).

%LS=[1,2,3,4|LE],add(5,LS,LE,RS,RE), conv(6, LS-RE, Ans).


% check if a letter is a valid input
 is_letter(Letter) :-
 	( 
		% if valid
		is_sign(Letter) -> true;
		% Capital letters
		Letter < 91, Letter > 64 ->  true;
		% small letters
		Letter > 96, Letter < 123 -> true;
		% else
		write("Text include invalid chars! This program only deals with letters, spaces and punctuation"), nl, false
	).

is_sign(Sign) :-
 	( 
		% signs
		Sign < 65 -> true;
		Sign > 122 ->  true;
		Sign < 97, Sign > 90 -> true;
		% else
		false
	).

	
% check if the word exist by looking in the dictionary
word_exists(Cipher) :-
	atom_codes(X, Cipher),
	atom_uplow(X, AtomCipher),
	word(Word),
	Word == AtomCipher,!.
	
first_word([32|T], Word):-
	Word = [].
	
first_word([H|T], Word):-
	first_word(T, X),
	Word = [H|X].

next_word([], Word, Rest):-
	Word = [], Rest = [].
	
next_word([32|T], Word, Rest):-
	Word = [], Rest = T.
	
next_word([H|T], Word, Rest):-
		next_word(T, X, Rest), Word = [H|X].

remove_signs([H], Word):-
	(
		is_sign(H) -> Word = [];		
		Word = [H]
	).

remove_signs([H|T], Word):-
	remove_signs(T, Result),
	(
		is_sign(H) -> Word = Result;		
		Word = [H|Result]
	).
	
	