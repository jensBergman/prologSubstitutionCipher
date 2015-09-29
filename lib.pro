/**
* Author: Jens Bergman
* Date: 2015-09-27
* Course: ID2213, logic programming
* Info: Library, this is a file with different procedures that can be used by the other files
*/

% Appends two lists using difference lists
add(A-B, B-C, A-C).

% check if a letter is a valid input
 is_letter(Letter) :-
 	( 
		% if capital letters
		Letter < 91, Letter > 64 ->  true;
		% small letters
		Letter > 96, Letter < 123 -> true;
		% else
		false
	).
	
% check if the word exist by looking in the dictionary
word_exists(Cipher) :-
	% convert char-list to atom
	atom_codes(X, Cipher),
	% convert atom to use all small letter
	atom_uplow(X, AtomCipher),
	% check a word from the dictionary
	word(Word),
	% check if the cipher is included in the dictionary
	Word == AtomCipher,!.

/** Next_word
* Desc: Extract the next word from the text
* Input: Whole text
* Output: Word: the first word in the text, Rest: text without the first word
*/
next_word([], Word-[], []):- !.
	
next_word([H|T], Word-[], Z):- not(is_letter(H)), !, Z=T.
	
next_word([H|T], Word-Z, Rest):-
		add(Word-Z, [H|Z2]-Z2, Result),!,
		next_word(T, Result, Rest).

/** Remove_signs
* Desc: Remove signs until next letter from the text
* Input: Whole text
* Output: Rest: text that start with a letter
*/
remove_signs([], []):- !.
	
remove_signs([H|T], Z):- is_letter(H), !, Z = [H|T].
	
remove_signs([H|T], Rest):-
		remove_signs(T, Rest),!.

	
time_difference(time(H1,M1,S1), time(H2,M2,S2),
      [hours(H), mins(M), secs(S)] ) :-
   H3 is H1 - H2,
   M3 is M1 - M2,
   S3 is S1 - S2,
   (S3 < 0 ->
      M4 is M3 - 1,
      S is S3 + 60
      ;
      M4 = M3,
      S = S3),
   (M4 < 0 ->
      M is M4 + 60,
      H is H3 - 1
      ;
      H = H3,
      M = M4).