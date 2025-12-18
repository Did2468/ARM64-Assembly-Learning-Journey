//this is array implementation of queue data structure kinda
//mid for any ineffeciencies or mistakes i debugged a lot and it ran fine and logic is what i designed
//only problem is its not menu driven hard codes but in assembly i think implementation is most important than making it in a menu based environment.
.global _main
.align 2
_main:
	adrp x19,heap@PAGE
	add x19,x19,heap@PAGEOFF	//heap base 
	
	adrp x10,buffer@PAGE		//buffer to store values to print them 
	add x10,x10,buffer@PAGEOFF
	
	mov x20,x19			//front pointer 
	mov x21,x19			//rear pointer
	mov x9,#0
	b queue_loop

queue_loop:
	cmp x9,#9	//comparing our loop counter(same as value we insert in queue)to #9 cause thats the largest we have 
	beq queue_end		
	str x9,[x21]		
	add x21,x21,#8
	add x9,x9,#1
	b queue_loop

queue_end:
	mov x13,#0		//print loop counter make it zero
	b print_start

print_start:
	cmp x13,x9		//compare the loop counter with x9(which hold the value 9 already because of previous loop)
	bge print_end
	
	ldr w14,[x20]
	add w14,w14,#'0'	//loading current value into buffer
	strb w14,[x10]
	
	mov x0,#1
	mov x1,x10		//printing the value
	mov x2,#1
	mov x16,#4
	svc #0
	
	add x20,x20,#8
	add x13,x13,#1
	
	
	b print_start
	
print_end:
	mov x0,#0
	mov x16,#1
	svc #0

.section __DATA,__data

buffer:
	.byte 4
heap:
	.space 160		//20 entries? each entry 8 bytes 
