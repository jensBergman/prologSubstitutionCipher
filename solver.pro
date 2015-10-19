/**
* Author: Jens Bergman
* Date: 2015-09-27
* Course: ID2213, logic programming
* Info: Automatically decipher a text
*/

/**
* test 1 (key 1): solv_cipher("Bmm afcsbt dbo svo, (xifo uifz bsf bmjwf)!").
* test 2 (key 3): solv_cipher("Doo cheudv fdq uxq, (zkhq wkhb duh dolyh)!").
* test 3 (key 25): solv_cipher("Zkk ydaqzr bzm qtm, (vgdm sgdx zqd zkhud)!").
*/

/** automatic solver for monoalphabetic ciphers
* Desc: use this to get the plain text printed out
* Input: Cipher: this is the encoded text (char list)
*/
solv_cipher(Cipher) :-
	
	% find the key to the cipher
	test_keys(1, Cipher, Key),

	% decrypt the text with the found key
	decrypt(Key, Cipher, Sentence),
	
	% there can only be one solution so it´s safe to cut here
	% (all other branches must be failing)
	!,

	% print out the result
	string_list(Print, Sentence),
	write('The cipher is: '), write(Cipher), nl,
	write('The key is: '), write(Key), nl,
	write('Plain text is: '), write(Print).

/** test keys
* Desc: Tests all possible keys for the cipher and outputs the final key
* Input: Word (char list), Cipher: Cipher text (char list)
* Output: Key: final key that can be used to decipher the text
*/

% Here we have checked all keys and all was the wrong solution.
test_keys(26, Cipher, Result):- !, fail.

test_keys(Key, Cipher, Result) :-
	(
		% if the key can decipher the whole text we are done
		test_all(Key, Cipher) ->  Result = Key;
		% else test a new key
		NewKey is Key+1,
		test_keys(NewKey, Cipher, Result) 
	).
	
test_all(Key, []):- !.
		
test_all(Key, Cipher) :-
	next_word(Cipher, Next_word-Next_word, Rest),
	remove_signs(Rest, NewCipher),
	decrypt(Key, Next_word, Plain),!,
	% if this fail we will not backtrack because
	% then this is the wrong key
	word_exists(Plain),
	test_all(Key, NewCipher).	
	