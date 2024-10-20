.cpu cortex-a53
.fpu neon-fp-armv8

.data

r7: .asciz "\n%d"
.text
.align 2
.global check_key
.type check_key, %function

check_key:

	push {fp, lr}
	add fp, sp, #4

	@ r0 = address of keyword
	@ r1 = address of user guess string "-----"
	@ r2 = guessed char

	@ saving these values for later so we can use these registers
	push {r0} @ fp - 8
	push {r1} @ fp - 12
	push {r2} @ fp - 16
	push {r10} @ counter variable

	mov r10, #0
	
	@ r3 = strlen(keyword)
	ldr r0, [fp, #-8]
	bl strlen
	mov r3, r0 @ stores length of keyword string into r3
	mov r8, #1
	begin_loop:

		cmp r10, r3
		bge end_loop

		@ if (key[r10] == user character)
		ldr r0, [fp, #-16] @ r0, = user character
		
		@ r1 = key[r10]
		ldr r1, [fp, #-8]
		ldrb r1, [r1, r10] @ r1 = keyword[r10] : don't need to mul by 4
				  @ because char = 1 memory byte location
		cmp r0, r1 @ keyword[r10] == user character?
		bne endif
		
			
			@ if the two characters are equal, change the guess string
			@ user_guess[r10] = user character
			ldr r2, [fp, #-12]
			strb r0, [r2, r10]
			add r7, r7, #1 @ keep track of # letters guessed
			mov r8, #0
			

		endif:	

		add r10, r10, #1 @ increment counter
		b begin_loop

	end_loop:

	sub r9, r9, r8

	@add sp, sp, #4

	@ restore registers 
	pop {r10}
	pop {r2}
	pop {r1}
	pop {r0}

	sub sp, fp, #4
	pop {fp, pc}