@ Garrett Detwiler

.cpu cortex-a53
.fpu neon-fp-armv8

.data

print_key: .asciz "Keyword: %s\n"

.text
.align 2
.global printword
.type printword, %function

printword:
	
	push {fp, lr}
	add fp, sp, #4
	
	@ r0 = address of keyword
	ldr r1, [r0]
	ldr r0, =print_key
	bl printf
	
	sub sp, fp, #4
	pop {fp, pc}