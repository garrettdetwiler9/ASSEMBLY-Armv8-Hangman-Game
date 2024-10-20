@ Garrett Detwiler

.cpu cortex-a53
.fpu neon-fp-armv8

.data 

.balign 4

keyword: .word 0 @ store the address of the keyword
user_guess: .word 0 @ store the address of the current state of guess string
print_char: .asciz "Guessed Character: %c\n"
printlen: .asciz "Length of keyword: %d\n"
printlives: .asciz "Lives: %d\n"
defeat: .asciz "YOU LOST!!! BOOOO!!!\n"
victory: .asciz "YOU WIN!!! YAY!!!\n"

.text
.align 2
.global main
.type main, %function

main:
	
	push {fp, lr}
	add fp, sp, #4
@@

	@ getword(keyword)
	ldr r0, =keyword
	ldr r1, =user_guess
	bl getword


	@ printword(keyword)
	ldr r0, =keyword
	bl printword


	@ initguess(keyword)
	ldr r0, =keyword
	ldr r0, [r0]
	ldr r1, =user_guess
	@ ldr r1, [r1]
	bl initguess

	@ r6 = strlen(keyword)
	ldr r0, =keyword
	ldr r0, [r0]
	bl strlen
	mov r6, r0 @ stores length of keyword string into r3
	
	@ display initial blank word
	ldr r0, =user_guess
	bl printguess

	mov r9, #10 @ # of lives
	mov r7, #0 @ # of correct characters
	play_game:
		
		@ printlives
		ldr r0, =printlives
		mov r1, r9
		bl printf

		@ trigger defeat message if lives == 0
		cmp r9, #0
		ble end_loss

		@ trigger victory message if word is completely guessed
		cmp r7, r6
		bge end_victory
	
		@ getguess() --> character
		bl getguess @ returns guess character in r0
		mov r4, r0 @ save guess char
	
		
		@ maybe remove until debug necessary?
		@ print out guess character entered
		mov r1, r0
		ldr r0, =print_char
		bl printf
	
		
		@ check_key(key, user_guess, guess_char)
		ldr r0, =keyword
		ldr r0, [r0]
		ldr r1, =user_guess
		ldr r1, [r1]
		mov r2, r4 @ guessed char
		bl check_key
	
	
		@ printguess(keyword)
		ldr r0, =user_guess
		bl printguess 
	
		b play_game

	end_loss:

	@ print loss message
	ldr r0, =defeat
	
	b end_game

	end_victory:

	@ print victory message
	ldr r0, =victory

	end_game:

	bl printf
	
@@
	sub sp, fp, #4
	pop {fp, pc}