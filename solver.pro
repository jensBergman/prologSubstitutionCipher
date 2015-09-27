/**
* Author: Jens Bergman
* Date: 2015-09-27
* Course: ID2213, logic programming
* Info: Automatically decipher a text
*/

/**
* test 1 (key 1): solv_solution("Bmm afcsbt dbo svo, (xifo uifz bsf bmjwf)!").
* test 2 (key 3): solv_solution("Doo cheudv fdq uxq, (zkhq wkhb duh dolyh)!").
* test 3 (key 25): solv_solution("Zkk ydaqzr bzm qtm, (vgdm sgdx zqd zkhud)!").
*/

/** automatic solver for monoalphabetic ciphers
* Desc: use this to get the plain text printed out
* Input: Cipher: this is the encoded text (char list)
*/
solv_solution(Cipher) :-
	% find the key to the cipher
	solver(Cipher, Key),
	% decrypt the text with the found key
	decrypt(Key, Cipher, Sentence),
	% print out the result
	string_list(Print, Sentence),
	write('The cipher is: '), write(Cipher), nl,
	write('The key is: '), write(Key), nl,
	write('Plain text is: '), write(Print).

/** solver
* Desc: Gives the key to decipher the cipher
* Input: Cipher: encoded text (char list)
* Output: Result: This is the key to decipher the text
*/
solver(Cipher, Result):-
	% get the first word (check possible solutions for one word
	% first such that we don't have to check all possible 25 keys for
	% long texts )
	next_word(Cipher, First_word-First_word, Rest),
	
	% check all possible solutions for first word
	% (necessary so that first solution is not a smokescreen)
	brute_force(First_word, PossibleKeys),
	
	% decipher with the possible keys, and calculate the final key
	test_keys(PossibleKeys, Cipher, Result),
	
	% there can only be one solution so it´s safe to cut here
	% (all other branches must be failing)
	!.


/** test keys
* Desc: Tests all possible keys for the cipher and outputs the final key
* Input: Word (char list), Cipher: Cipher text (char list)
* Output: Key: final key that can be used to decipher the text
*/

% Here we have checked all keys and all was the wrong solution.
test_keys([], Cipher, Key):- !, fail.

test_keys([H|T], Cipher, Key) :-
	(
		% if the key can decipher the whole text we are done
		test_all(H, Cipher) ->  Key = H;
		% else we have to check the other keys
		test_keys(T, Cipher, Key) 
	).
	
/** test_all
* Desc: tries to decipher the whole text with the key
* Input: Key: key used for deciphering, Cipher: cipher text
* Output: the procedure results in either true or false
*/
test_all(Key, []):- !.
		
test_all(Key, Cipher) :-
	next_word(Cipher, Next_word-Next_word, Rest),
	remove_signs(Rest, NewCipher),
	decrypt(Key, Next_word, Plain),!,
	word_exists(Plain),
	test_all(Key, NewCipher).	
	
/**--- Brute force ----------------
* input: cipher
* output: list of keys
*
* Description: brute force a word with keys 1-25 to find possible keys to solve
* 					the rest of cipher.
*/
brute_force(Cipher, Result):-
	brute_force(Cipher,1, Result-Result).
	
brute_force(Cipher,26, Z):- !, Z=Result-[].
	
brute_force(Cipher,Key, Result-Z):-

	% test a new key
	NewKey is Key+1,
	
	% try to decrypt the key
	decrypt(Key, Cipher, Plain),
	( 
		% if it is a word then this is a possible key
		word_exists(Plain) -> 
			add(Result-Z, [Key|Z2]-Z2, NewResult),!,
			brute_force(Cipher,NewKey , NewResult);
		% else this is not a possible key
		!,brute_force(Cipher,NewKey , Result-Z)
	).
	

	

	
	