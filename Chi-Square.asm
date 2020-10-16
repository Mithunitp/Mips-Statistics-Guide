#SAMPLE PROBLEM
#A 6-sided die is thrown 60 times. The number of times it lands with 1, 2, 3, 4, 5 and 6 face up is 5, 8, 9, 8, 10 and 20, respectively.
#Calculate the Pearson's chi squared test staistic.
#Done by Mithun and Anirudh for Digital assignment -2 ,VIT Chennai

.data
Oi: .word 5,8,9,8,10,20 # Oi = {5,8,9,8,10,20}
Ei: .word 10 #Ei= 60/6=10 
length: .word 6 # the length of the array is 6
Chisq: .word 0 # The Pearson's chi squared test staistic
ResultMessage: .asciiz "The Chi-Square test coefficient is: "



.text
main:

li $t0, 0 # load immediate 0 in register $t0 (Oi-Ei)^2
lw $t5, Ei # load Ei in register $t5 
la $t3, Oi # load base addr. of array into $t3
lw $t2, length # load length in register $t2
addi $t2, $t2, -1 # $t2 = length - 1
li $t1, 0 # initialize i in $t1 to 0


loop:

bgt $t1, $t2, exit # exit loop when i > (length-1)
mul $t4, $t1, 4 # multiple i by 4 to get offset within array
add $t4, $t3, $t4 # add base addr. of array to $t4 to get addr. of Oi[i]
lw $t4, 0($t4) # load value of array[i] from memory into $t4
sub $t4, $t4, $t5 # Oi= (Oi-Ei)
mul $t4, $t4, $t4 # Calculate (Oi-Ei)^2
add $t0,$t0,$t4 # update Sum((Oi-Ei)^2)
addi $t1, $t1, 1 # increment i

j loop

exit:
mtc1  $t0,$f1 #Moving Sum((Oi-Ei)^2) into float register $f1
mtc1 $t5,$f2 #Moving Ei into float register $f2
div.s $f3,$f1,$f2 #Finding chi-square statistic/coefficient

#Printing the result message
li      $v0,4
la      $a0,ResultMessage
syscall

#Printing the Chi square coefficient value
li $v0, 2
mov.s $f12, $f3  
syscall
