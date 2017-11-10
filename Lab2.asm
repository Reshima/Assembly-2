# who:  Rachael Shima
# what:  Lab2
		 # Lab2.asm
# why: Lab2 for cs264 
		 # Accepts a number between 1 and 47
		 # Calculates the fibonacci sequence up to that number
		 # prints the nth fibonacci number and the rest of the sequence which is stored in an array
# When: 9 May 2017
		 # 12 May 2017
		 
	.data
	
			prompt: 	.asciiz "How many elements would you like to see? (0 to end program): "
			ofb:        .asciiz "That integer cannot be stored in 32 bits, please choose an int between 1 and 47"
			line:		.asciiz "\n" 
			space:		.asciiz " "
			max:		.word 47
			array:		.space 188
	
	  .text
		.globl main
main:
			li $t1, 0				#t = $t1 = 0
			li $t2, 1				#h = $t2 = 1
			
			li $v0, 4				#print string
			la $a0, prompt			#ask for user integer
			syscall
			
			li $v0, 5				#read user input
			syscall
			
			add $t0, $zero, $v0		#save user input
			add $t5, $zero, $t0
			
			bgt $t0, 47, newint		#determine if in range branch for newint otherwise
			blt $t0, 0, newint		#determine if in range branch for newint otherwise
			beq $t0, 0, finish  	#0 to quit
			la $t4, array 			#load the array for fibloop
			la $t6, array			#load the array for printloop

fibloop: 	
			ble $t0, 1, print		#branch if n <= 1
			addi $t4, $t4, 4		#incriment by four
			addu $t3, $t1, $t2		#tmp = $t3 = t + h
			move $t1, $t2			#t = h
			move $t2, $t3			#h = tmp
			sw $t1, 0($t4)			#store t in an array
			addi $t0, $t0, -1		#n--
			b fibloop				#loop

newint:
			la $a0, ofb				#print error message
			li $v0, 4				#print string
			syscall
			
			la $a0, line			#print new line
			li $v0, 4				#print string
			syscall
			
			b main					#loop back to main
		
print:
			move $a0, $t1			#print nth fibonnaci number
			li $v0, 1				#print int
			syscall
			
			la $a0, line			#print new line
			li $v0, 4				#print string
			syscall
			
printloop:
			lw $a0, 0($t6)			#print int at index
			li $v0, 1				#print int
			syscall
			
			la $a0, space			#print space between numbers
			li $v0, 4				#print string
			syscall
			
			addi $t5, $t5, -1 		#decriment counter
			addi $t6, $t6, 4		#incriment pointer
			beq $t5, 0, finish		#branch if array is empty
			b printloop				#loop
			
finish:
			li $v0, 10				#terminate program
			syscall