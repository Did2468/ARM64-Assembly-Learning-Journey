.global _main
.align 2

_main:
	mov x9,#100	//number taken
	mov x10,#0 	//factors count
	mov x11,#0	//i
	bl factors
	cmp x10,#1
	beq print_yes
	b print_no

factors:
	add x11,x11,#1	//i increment
	mov x5,#0
	mov x6,#0
	cmp x11,x9		// if n>i
	bge loop_end		//loop ending case
	udiv x5,x9,x11
	msub x6,x5,x11,x9
	cmp x6,#0
	beq count_increment
	b factors

count_increment:
	add x10,x10,#1		//count increment
	b factors	

loop_end:
	//mov x0,#0
	//mov x16,#1
	//svc #0
	ret

print_yes:
	mov x0,#1
	adrp x1,yes_msg@PAGE
	add x1,x1,yes_msg@PAGEOFF
	mov x2,#13
	mov x16,#4
	svc #0
	mov x0,#0
	mov x16,#1
	svc #0

print_no:
	mov x0,#1
	adrp x1,no_msg@PAGE
	add x1,x1,no_msg@PAGEOFF
	mov x2,#19
	mov x16,#4
	svc #0
	mov x0,#0
	mov x16,#1
	svc #0

yes_msg:
	.ascii "prime number!!"
no_msg:
	.ascii "Not a prime number!!"
