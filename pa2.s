.section .data

input_x_prompt	:	.asciz	"Please enter x: "
input_y_prompt	:	.asciz	"Please enter y: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"x^y = %d\n"

.section .text

.global main

main:

# add code and other labels here

	ldr x0, =input_x_prompt
	bl printf

	bl get_input
	mov x19, x0

	ldr x0, =input_y_prompt
	bl printf

	bl get_input
	mov x20, x0

	mov x0, x19
	mov x1, x20
	mov x2, 19
	bl power

	ldr x0, =result
	mov x1, x2
	bl printf

	b exit

get_input:
	sub sp, sp, 8
	str x30, [sp]

	ldr x0, =input_spec
	sub sp, sp, 8
	mov x1, sp
	bl scanf

	ldrsw x0, [sp]
	ldr x30, [sp, 8]
	add sp, sp, 16
	ret

 
power:
	
	cbz x0, return_0

	cmp x1, 0
	b.lt return_0

	cbz x1, return_1


	sub sp, sp, 24
	stur x30, [sp, 16]
	stur x0, [sp, 8]
	stur x1, [sp]
	sub x1, x1, 1

	bl power
	ldur x0, [sp, 8]
	ldur x1, [sp]
	ldur x30, [sp, 16]
	add sp, sp, 24
	mul x2, x2, x0
	br x30

	return_0:
		mov x2, 0
		ret

	return_1:
		mov x2, 1
		br x30



	 



	


	



# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret
