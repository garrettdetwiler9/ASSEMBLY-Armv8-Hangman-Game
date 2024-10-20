.cpu cortex-a53
.fpu neon-fp-armv8

.data

.balign 4

inp_char: .asciz "%c"
u_instr: .asciz "Enter the guess character: "
clr_input: .asciz "%*[^\n]%*c\n"

.text
.align 2
.global getguess
.type getguess, %function

getguess:

	push {fp, lr}
	add fp, sp, #4

	mov r0, #0

	@ scanf("%c", &variable)
	ldr r0, =u_instr
	bl printf

	while_loop:

	ldr r0, =inp_char
	sub sp, sp, #4
	mov r1, sp
	bl scanf

	@ load char in sp into r0
	ldrb r0, [sp]

	add sp, sp, #4

	@ avoid '\n'
	cmp r0, #0x0A @ compares user input to '\n'
	beq while_loop

	@sub sp, fp, #4
	pop {fp, pc}