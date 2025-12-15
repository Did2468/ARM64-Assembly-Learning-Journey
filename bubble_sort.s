.global _main
.align 2

.data
arr:
        .word 9,8,7,6,5,4,3,2,1
	//.word 5,4,3,2,1
.text

_main:
        adrp x9,arr@PAGE                //move arr into a register
        add x9,x9,arr@PAGEOFF
	mov x4,#9			//size of array  n
        mov x11,#0                      //index for loop counter while printing
        sub sp,sp,#64                   //stack pointer initialization
        mov x13,sp
	mov x5,#0		// i 
	b sort_outer
	//b loop_start
	
sort_outer:
	mov x6,#0		//inner loop variable which will become n-1-i
	cmp x5,x4		//checking in rane(n)?
	bge loop_start		//if condition fail come out of loop
	sub x6,x4,#1		//n-1
	sub x6,x6,x5			// (n-1-i)?
	mov x7,#0			// our j variable inintializing it to 0 before enterinng j loop
	mov x15,#1			//j+1 pointer initialize to 1 before going into the loop 
	bl sort_inner			//still valid outer loop go into inner j loop
	//add x5,x5,#1			// increment i 
	//b sort_outer			//call the i loop again cause assembly cant help it need to maunally call


sort_inner:
	//mov x15,#0
	cmp x7,x6		//comparing j with (n-1-i)
	bge sort_inner_end	//j>=n-1-i
	//add x15,x7,#1
	ldr w12,[x9,x7,LSL #2]		//j
	ldr w3,[x9,x15,LSL #2]		//j+1
	cmp w12,w3			// is j>j+1
	bgt swap
	add x7,x7,#1			// j increment
	add x15,x15,#1			//j+1 increment before going into the next iteration
	b sort_inner

sort_inner_end:
	//mov x6,#0
	//ret
	add x5,x5,#1		//after the inner loop is ending increment the i and give control to the outer loop
	b sort_outer

swap:
	ldr w19,[x9,x7,LSL #2]
	str w3,[x9,x7,LSL #2]
	str w19,[x9,x15,LSL #2]
	ret




loop_start:
        mov x14,x9
        ldr w14,[x14,x11,LSL #2]                        //move element at index 2 to x9
        add w14,w14,#'0'

        strb w14,[x13]                  //copying word into stack

        mov x0,#1
        mov x1,x13
        mov x2,#1
        mov x16,#4
        svc #0

        add x11,x11,#1          //incrementer
        add x13,x13,#4


        cmp x11,x4              //branching logic

        bge end_loop            // if index becomes equals to 5 goto end loop and return 0 to system if not start loop_start function again
        b loop_start

end_loop:
        add sp,sp,#64
        mov x0,#0
        mov x16,#1
        svc #0               
