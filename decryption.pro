/**
* Author: Jens Bergman
* Date: 2015-09-27
* Course: ID2213, logic programming
* Info: This file have all decryption procedures for a known key.
*/

% test of encryption dec_solution(3, "Doo cheudv", X).

/** print out the result from decrypting a cipher with a known key
* Desc: use this to get the plain text printed out
* Input: Key: key to be used to decrypt, Cipher: this is the encoded text (char list)
* Output: Result: plain text
*/
dec_solution(Key, Cipher, Result) :-
	decrypt(Key, Cipher, Result),	
	string_list(Print, Result),
	write('The cipher is: '), write(Cipher), nl,
	write('The key is: '), write(Key), nl,
	write('Plain text is: '), write(Print).

% decrypt any text
% input: Key: key to decrypt with, Cipher: encrypted text
% output: Result: plain text (for the key Key)
decrypt(Key, Cipher, Result):-
	decrypt_dl(Key, Cipher, Result-Result).

decrypt_dl(Key, [], Z):- !, Z=Sentence-[].

decrypt_dl(Key, [H|T], Sentence-Z):-
	% decrypt 
	Temp is H-Key,
	% roll back if necessary
	dec_roll_back(H, Temp, X),	
	% append to the rest of plain text
	add(Sentence-Z, [X|Z2]-Z2, Result),!,
	% decrypt rest of the text text
	decrypt_dl(Key, T, Result).
	
% roll back decryption if over Z or z (or do nothing on space)	
dec_roll_back(Cipher, Letter, Result) :-
		
	( 
		% if sign
		not(is_letter(Cipher)) -> Result = Cipher;
		% else is over Z
		Letter < 65, Cipher >= 65 ->  Result is Letter+26;
		% else is over z
		Letter < 97, Cipher >= 97 -> Result is Letter+26;
		% else
		Result = Letter
	).
	