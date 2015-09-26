/** bugs: 
* encrypt with dot gives to lines of "text includes..."
* test_keys gives the same solution twice
*/

% test 1 (key 1): solv_solution("Bmm afcsbt dbo svo, (xifo uifz bsf bmjwf)!").
% test 2 (key 3): solv_solution("Doo cheudv fdq uxq, (zkhq wkhb duh dolyh)!").
% test 3 (key 25): solv_solution("Zkk ydaqzr bzm qtm, (vgdm sgdx zqd zkhud)!").

solv_solution(Cipher) :-
	solver(Cipher, Key),
	write('The cipher is: '), write(Cipher), nl,
	write('The key is: '), write(Key), nl,
	dec_solution(Key, Cipher, Sentence).

solver(Cipher, Result):-
	% get the first word (check possible solutions for one word
	% first such that we don't have to check all possible 25 keys for
	% long texts )
	next_word(Cipher, First_word, Rest),
	
	% check all possible solutions for first word
	% (necessary so that first solution is not a smokescreen)
	brute_force(First_word, PossibleKeys),
	
	% decipher with the possible keys
	test_keys(PossibleKeys, Cipher, Result).


% test keys --------------------------------------


test_keys([H], Cipher, Key):-
	test_all(H, Cipher),
	Key = H.
	

test_keys([H|T], Cipher, Key) :-
	test_all(H, Cipher), Key = H;
	test_keys(T, Cipher, Key). 
	
%--------------------------------
test_all(Key, []).
		
test_all(Key, Cipher) :-
	next_word(Cipher, Next_word, Rest),
	remove_signs(Next_word, Word),
	decrypt(Key, Word, Plain),
	word_exists(Plain),
	test_all(Key, Rest).
	
%--- Brute force ----------------
% input: cipher
% output: list of keys
brute_force(Cipher, Result):-
	Key = 1,
	brute_force(Cipher,Key, Result).
	
brute_force(Cipher,25, Result):-
	% try to decrypt the key
	decrypt(25, Cipher, Plain),
	( 
		% if it is a word then 25 is a possible key
		word_exists(Plain) -> Result = [25];
		% else 25 is not a possible key
		Result = []
	).
	
brute_force(Cipher,Key, Result):-

	% test a new key
	NewKey is Key+1,
	brute_force(Cipher,NewKey , CurrentResult),
	
		% try to decrypt the key
	decrypt(Key, Cipher, Plain),
	( 
		% if it is a word then 25 is a possible key
		word_exists(Plain) -> Result = [Key|CurrentResult];
		% else 25 is not a possible key
		Result = CurrentResult
	).
	

	
	