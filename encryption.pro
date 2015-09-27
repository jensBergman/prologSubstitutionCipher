/**
* Author: Jens Bergman
* Date: 2015-09-27
* Course: ID2213, logic programming
* Info: This file have all encrypting procedures for a known key.
*/

% test of encryption enc_solution(3, "All zebras can run, (when they are alive)!", X).
enc_solution(Key, Sentence, Cipher) :-
	encrypt(Key, Sentence, Cipher),
	string_list(Print, Cipher),
	write(Print).


encrypt(Key, Plain, Result):-
	encrypt_dl(Key, Plain, Result-Result).	
	
encrypt_dl(Key, [], Z):- !, Z=Cipher-[].

encrypt_dl(Key, [H|T], Cipher-Z):-
	% encrypt
	Temp is H+Key,
	% roll back the encrypt if necessary
	enc_roll_back(H, Temp, X),
	% append to the rest of plain text
	add(Cipher-Z, [X|Z2]-Z2, Result),!,
	% decrypt rest of the text text
	encrypt_dl(Key, T, Result).
	
% roll back encryption if over Z or z (or do nothing on space)	
enc_roll_back(Letter, Cipher, Result) :-
		
	( 
		% if space
		is_sign(Letter) -> Result = Letter;
		% else is over Z
		Cipher > 90, Letter =< 90 ->  Result is Cipher-26;
		% else is over z
		Cipher > 122, Letter =< 122 -> Result is Cipher-26;
		% else
		Result = Cipher
	).
	