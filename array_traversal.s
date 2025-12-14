.global _main
.align 2

.data
arr:
	.word 5,4,3,2,1

.text

_main:
	adrp x9,arr@PAGE		//move arr into a register
	add x9,x9,arr@PAGEOFF
	mov x11,#0			//index
	sub sp,sp,#64			//stack pointer initialization
	mov x13,sp
loop_start:
	mov x14,x9		
	ldr w14,[x14,x11,LSL #2]			//move element at index 2 to x9
	add w14,w14,#'0'

	strb w14,[x13]			//copying word into stack
	
	mov x0,#1
	mov x1,x13
	mov x2,#1
	mov x16,#4
	svc #0
	
	add x11,x11,#1		//incrementer
	add x13,x13,#4	


	cmp x11,#5		//branching logic 

	bge end_loop		// if index becomes equals to 5 goto end loop and return 0 to system if not start loop_start function again 
	b loop_start

end_loop:
	add sp,sp,#64
	mov x0,#0
	mov x16,#1
	svc #0	
