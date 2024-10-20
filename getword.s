@ Garrett Detwiler

.cpu cortex-a53
.fpu neon-fp-armv8

.data 

strinp: .asciz "%s"
rfile: .asciz "r"
dict: .asciz "dict.txt"
iinp: .asciz "%d"

.text
.align 2
.global getword
.type getword, %function


getword:

	push {fp, lr}
	add fp, sp, #4
	
	@ r0 = address of keyword
	push {r0} @ store keyword address at fp - 8
	
	@ fileptr = fopen()
	ldr r0, =dict
	ldr r1, =rfile
	bl fopen
	
	push {r0} @ store file pointer at fp - 12
	
	@ allocate up to 80 bytes to store keyword
	mov r0, #80
	bl malloc

	@ store into keyword
	ldr r1, [fp, #-8]
	str r0, [r1] @ store address of dynamic memory at address of keyword
	
	@ read meta data
	@ fscanf(fptr, "%d", sp)
	ldr r0, [fp, #-12] @ r0 = file pointer
	ldr r1, =iinp
	sub sp, sp, #4 @ allocate free stack memory
	mov r2, sp
	bl fscanf
	
	@generate random number
	mov r0, #0
	bl time
	bl srand
	
	bl rand
	@ mod(r0, number of words)
	ldr r1, [fp, #-16]
	bl modulo
	add r4, r0, #1 @ r4 = random number from 1 to number of words
	
	mov r10, #0 @ i = 0
	begin_while:
	
		cmp r10, r4
		bge end_while
		
		ldr r0, [fp, #-12] @ r0 = filepointer
		ldr r1, =strinp
		ldr r2, [fp, #-8] @ address of keyword
		ldr r2, [r2]
		
		bl fscanf
		
		add r10, r10, #1 @ increment i
		b begin_while

	end_while:

		ldr r0, [fp, #-12]
		bl fclose

		@ Free the allocated memory for keyword
    		ldr r0, [fp, #-8]
    		ldr r0, [r0]
    		bl free

		sub sp, fp, #4
		pop {fp, pc}




