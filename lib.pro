 %use: atom_codes(X, "abc"). to turn word to atom

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
	
%is_punctuation(Punctuation) :-
% 	( 
		% if space or !
%		Punctuation < 34, Punctuation > 31 -> true;
		% if '(' or ')'
%		Punctuation < 42, Punctuation > 39 ->  true;
		% if '.', '-' or ','
%		Punctuation < 47, Punctuation > 43 -> true;
		% if '?'
%		Punctuation == 63 -> true;
		% else
%		false
%	).
	
% check if the word exist by looking in the dictionary
word_exists(Cipher) :-
	atom_codes(X, Cipher),
	atom_uplow(X, AtomCipher),
	word(Word),
	atom_codes(AtomWord, Word),
	AtomWord == AtomCipher.
	
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
	%(
	%	is_sign(H) -> Rest = T, Word = [];
		next_word(T, X, Rest), Word = [H|X].
	%).
	
%remove_next_sign([H|T],Rest):-
%	(
%		not(is_sign(H)) -> Rest = T;		
%		remove_next_sign(T, Rest)
%	).

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
	
	