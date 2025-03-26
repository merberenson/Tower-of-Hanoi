.data
movdisk: .string "Move disk: "
to: .string " to: "
newline: .string "\n"

#Input number of disks
disknum:    .word 4

.text
toh: 
    #Load the value of disknum into a register
    lw t0, disknum

    #Calculate number of steps: 2^n - 1
    li t1, 1
    sll t1, t1, t0
    addi t1, t1, -1

loop:
    bgt t2, t1, end

movedisk:
    # start the tower of hanoi
    neg t3, t2
    and t3, t2, t3

    li t4, 1

whichdisk:
    srli t3, t3, 1
    beqz t3, printdisk
    addi t4, t4, 1
    j whichdisk

printdisk:
    addi a0, x0, 4
    la a1, movdisk
    ecall

    #, print disk number
    addi a0, x0, 1
    add a1, x0, t4 
    ecall

towhichrod:
    # Calculate destination rod 
    addi t4, t2, -1
    or t5, t2, t4
    addi t5, t5, 1
    li t6, 3
    rem t5, t5, t6
    addi t5, t5, 1

    # Print " to rod " 
    addi a0, x0, 4
    la a1, to
    ecall 

    # Print rod number
    addi a0, x0, 4
    la a1, to
    ecall

    # Print newline 
    addi a0, x0, 4
    la a1, newline
    ecall

nextstep:
    # Update previous and current number
    addi t2, t2, 1
    j loop

    # Jump back to continue next move
    bgt t2, t1, end
    j movedisk

end: 
    # Exit program
    addi a0, x0, 10
    ecall
    