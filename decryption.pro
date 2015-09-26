
% test of encryption dec_solution(3, "Doo cheudv", X).
dec_solution(Key, Cipher, Result) :-
	decrypt(Key, Cipher, Result),	
	string_list(Print, Result),
	write('Plain text is: '), write(Print).

% decrypt any text
% input: Key: key to decrypt with, Cipher: encrypted text
% output: Result: plain text (for the key Key)
decrypt(Key, Cipher, Z):-
	decrypt_dl(Key, Cipher, Z-Z, Result).

decrypt_dl(Key, [], Sentence-[], NewResult).

decrypt_dl(Key, [H|T], Sentence-Z, Result):-
	% decrypt 
	Temp is H-Key,
	% roll back if necessary
	dec_roll_back(H, Temp, X),	
	% append to the rest of plain text
	dappend(Sentence-Z, [X|Z2]-Z2, NewResult),!,
	% decrypt rest of the text text
	decrypt_dl(Key, T, NewResult, Result).
	
% roll back decryption if over Z or z (or do nothing on space)	
dec_roll_back(Cipher, Letter, Result) :-
		
	( 
		% if space
		is_sign(Cipher) -> Result = Cipher;
		% else is over Z
		Letter < 65, Cipher >= 65 ->  Result is Letter+26;
		% else is over z
		Letter < 97, Cipher >= 97 -> Result is Letter+26;
		% else
		Result = Letter
	).
	