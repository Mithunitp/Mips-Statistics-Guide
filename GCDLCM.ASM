.data
msg1:	.asciiz "Enter N: "
msg2:	.asciiz "Enter P: "

.text
	li $v0, 4 
	la $a0, msg1 #printing msg1 onto console 
	syscall
	#input N value 
	li $v0, 5 
	syscall
	
	move $a1, $v0 #storing N in a1 
	
	li $v0, 4
	la $a0, msg2
	syscall 
	#input P value 
	li $v0, 5
	syscall 
	
	move $a2, $v0 #storing P in a2 
	
	move $t6,$a1
	move $t7,$a2 #storing N and P as backup 
	move $a0,$a1 #N is the first argument to procedure GCD_LCM
	move $a1,$a2 #P is the second argument  
	
	jal gcd_lcm 
	li $v0,10    # system call for exit 
	syscall 	
##########################################################################
#Routine to calculate GCD and LCM 
.data 
str1:	.asciiz	"GCD of the two numbers: "
str2:	.asciiz "\nLCM of the two numbers: " 
.text
gcd_lcm:
	move $t0, $a0#storing N in t0
	move $t1, $a1 #storing P in t1 
	
	move $t2,$a0
	move $t3,$a1 #Storing n and p as backup 
loop:
	beq $t1, $zero, done #if t1=0, branch to done label 
	div $t0, $t1   #divide n by p
	move $t0, $t1  #new value of n=old value of p
	mfhi $t1 #New value of p=n%p. Remainder of n/p moved from HI register to t1.
	j loop #unconditional jump to loop label 
done:
	li $v0, 4
	la $a0, str1
	syscall 
	move $a0, $t0 #t0 stores value of HCF. This value is transferred to a0 to print 
	li $v0, 1
	syscall #printing HCF 
	
	mul $a0, $t2, $t3 #n*p is stored in a0
	div $a0, $t0 #LCM=(n*p)/HCF 
	li $v0, 4
	la $a0, str2 
	syscall
	mflo $a0 #LCM value stored in LO. This is moved to a0 to print 
	li $v0, 1
	syscall #Printing LCM 
	jr $ra 
