
% test of encryption enc_solution(3, "All zebras can run, (when they are alive)!", X).
enc_solution(Key, Sentence, Cipher) :-
	encrypt(Key, Sentence, Cipher),
	string_list(Print, Cipher),
	write(Print).
	
	
encrypt(Key, [H|[]], Result):- 
	
	% check if the letter is a valid letter
	%is_letter(H),
	
	% encrypt
	Temp is H+Key,
	% roll back the encrypt if necessary
	enc_roll_back(H, Temp, X),
	% insert the encrypted text instead of plain text
	Result = [X].

encrypt(Key, [H|T], Result):- 

	% check if the letter is a valid letter
	%is_letter(H),

	% encrypt all text
	encrypt(Key, T, Cipher),
	
	% encrypt 
	Temp is H+Key,
	% roll back if necessary
	enc_roll_back(H, Temp, X),
		% insert the encrypted text instead of plain text
	Result = [X | Cipher].
	
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
	