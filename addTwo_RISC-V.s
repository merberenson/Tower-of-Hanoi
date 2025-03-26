.data
mystr:   .string "The sum is:\n"

num1:    .word 5
num2:    .word 6

.text
main:

# Load the integers into registers and sum them
lw     t0, num1
lw     t1, num2
add    a3, t0, t1

# Print the sum
la     a0, mystr   # Format of the string to print

# addi a1 x0 mystr
addi a0, x0, 4
la a1 mystr
ecall

addi a0 x0 1        # print_int ecall
add a1 x0 a3       # integer 42
ecall

# exit program
addi a0 x0 10
ecall

