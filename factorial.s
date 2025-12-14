.global _main
.align 2

_main:
	mov x9,#1  //loop counter 
	mov x10,#1   //current value

loop_start:
	cmp x9,#21
	bge loop_end
	mul x10,x10,x9
	add x9,x9,#1	    //increment 
	b loop_start


loop_end:
	mov x11,x10		//copying final result to a temporary register
	bl print_number
	mov x0,#0
	mov x16,#1
	svc #0




print_number:
	sub sp,sp,#32
	mov x12,sp		//my stck pointer 
	mov x13,#0		// stack counter

convert_loop:
	mov x14,x11
	cmp x14,#0
	beq convert_done

	mov x5,#10	
	udiv x6,x11,x5
	msub x7,x6,x5,x11 
	
	add x7,x7,#'0'
	
	strb w7,[x12]
	add x12,x12,#1
	add x13,x13,#1

	mov x11,x6
	b convert_loop

convert_done:
	cmp x13,#0
	bne print_digits
	mov w3,#'0'
	strb w3,[x12]
	add x12,x12,#1
	add x13,x13,#1
	


print_digits:
	sub x12,x12,#1

print_loop:
	mov x0,#1
	mov x1,x12
	mov x2,#1
	mov x16,#4
	svc #0
	
	sub x12,x12,#1
	sub x13,x13,#1
	cmp x13,#0
	bne print_loop
	add sp,sp,#32
	ret
