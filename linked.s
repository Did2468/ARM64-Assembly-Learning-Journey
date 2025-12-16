// Note: data cant be added by user a loop automatically inserts from 0 to 9.
// current limitation only single digits can be insertes cause i dont wanna make my life miserable by integration a itoa and atoi.

.section __DATA,__bss
.align 3

nodes:
	.skip 160		//allocating a heap of memory for 10 nodes 16 bytes for each node 8 for data 8 for next address value
.section __DATA,__data
buff:
	.space 4			// used to store temp buff to store current node while printing 4

.align 2
.text
.global _main
_main:
	adrp x19,nodes@PAGE
	add x19,x19,nodes@PAGEOFF		//moving the initial part of the allocated heap memory into the x19
	
	mov x20,x19 			//making this the head pointer     x20 
	mov x6,#0			//our 0 variable to maintain 

	// inserting first node kinda?
	
	mov x11,#0
	str x11,[x19]		//moving the first value into the first address
	str x6,[x19,#8]	//making the later part of the node the 8 bytes into 0 for now 
	mov x21,x19		//making the x21 register the tail register 
	add x19,x19,#16		//incrementing such that we point to next node 
	b insert_loop

insert_loop:
	cmp x11,#9		//our insertion loop runs from 0 to 9 
	mov x7,x20              //make a copy of the head variable cause printing it will mess with the value
	mov x13,#0	//making the print loop counter 0 and starting the print function
	bgt print	// go to printing all the insertion should be done
	b insert		//invoke the actual insert branch


insert:
	//inserting the second node
	
	add x11,x11,#1		// increment the value and loop counter at same time
	str x11,[x19]		//moving the value entered into current pointer 
	str x6,[x19,#8]		//making the later part 0
	str x19,[x21,#8]			//linking the previous one with current one 
	mov x21,x19			//making the current point tail 
	add x19,x19,#16			//incrementing such that we point to next node 
	b insert_loop		// branch back to insert_loop 

print_loop:
	cmp x13,x11
	bgt end_program
	b print
	
print:
	adrp x5,buff@PAGE			//store the current number
	add x5,x5,buff@PAGEOFF	
	ldr w14,[x7]				//load the current head into w14
	add w14,w14,#'0'			// convert ascii into number
	strb w14,[x5]

	mov x0,#1
	mov x1,x5				// printing the current node
	mov x2,#1
	mov x16,#4
	svc #0

	//add x7,x7,#16		//increment the head to next node
	ldr x7,[x7,#8]			// this is true linked list traversal above one is just array my bad 
	add x13,x13,#1			//increment the print loop count 
	b print_loop

end_program:
	mov x0,#0
	mov x16,#1			// end the system return 0
	svc #0
