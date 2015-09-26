
% test of encryption dec_solution(3, "All zebras", X).
dec_solution(Key, Cipher, Sentence) :-
	decrypt(Key, Cipher, Sentence),
	string_list(Print, Sentence),
	write('Plain text is: '), write(Print).
	
	
decrypt(Key, [H|[]], Result):- 

	% check if the letter is a valid letter
	%is_letter(H),
	
	% decrypt
	Temp is H-Key,
	% roll back the decrypt if necessary
	dec_roll_back(H, Temp, X),
	% insert the plain text instead of cipher text
	Result = [X].

decrypt(Key, [H|T], Result):-

	% check if the letter is a valid letter
	%is_letter(H),
 
	% decrypt all text
	decrypt(Key, T, Plain),
	
	% decrypt 
	Temp is H-Key,
	% roll back if necessary
	dec_roll_back(H, Temp, X),
	% insert the plain text instead of cipher text
	Result = [X | Plain].
	
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
	