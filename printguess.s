.cpu cortex-a53
.fpu neon-fp-armv8

.data

.balign 4

guess_str: .asciz "Current guess: %s\n"

.text
.align 2
.global printguess
.type printguess, %function

printguess:

	push {fp, lr}
	add fp, sp, #4

	@ r0 = address of user_guess
	ldr r1, [r0]
	ldr r0, =guess_str
	bl printf
	
	sub sp, fp, #4
	pop {fp, pc}