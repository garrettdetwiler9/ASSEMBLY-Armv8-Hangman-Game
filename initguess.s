.cpu cortex-a53
.fpu neon-fp-armv8

.data

.balign 4

printstr: .asciz "%s\n"
d: .asciz "%d\n"
dash: .asciz "%c"
copykey: .word 0
printlen: .asciz "Length of word: %d\n"

.text
.align 2
.global initguess
.type initguess, %function

initguess:

	push {fp, lr}
	add fp, sp, #4
	
	push {r0} @ keyword = fp - 8
	push {r1} @ user_guess = fp - 12
	push {r2}

	@ r4 = strlen(key)
    	ldr r0, [fp, #-8]
    	bl strlen  @ returns length of string into r0
    	mov r4, r0
	
	ldr r0, =printlen
	mov r1, r4
	bl printf
	
	add r0, r4, #1
	bl malloc
	ldr r1, [fp, #-12]
	str r0, [r1]
	ldr r1, [fp, #-8]
	bl strcpy
	
	mov r2, #0
	mov r3, #'-

	loop:

		cmp r2, r4
		bge end_loop

		ldr r1, [fp, #-12]
		ldr r1, [r1]
		strb r3, [r1, r2]

		@ldr r0, =dash
		@ldr r1, [r1, r2]
		@bl printf

		add r2, r2, #1 @ i++

		b loop

	end_loop:
	
	@ldr r0, [fp, #-12]
	@bl printf

	@ Free the allocated memory for keyword
    	@ldr r0, [fp, #-8]
    	@ldr r0, [r0]
    	@bl free

	@ Free the allocated memory for keyword
	@ldr r0, [fp, #-12]
	@ldr r0, [r0]
    	@bl free

	@ pop {r0}
	@ pop {r1}
	pop {r2}

	sub sp, fp, #4
	pop {fp, pc}
	