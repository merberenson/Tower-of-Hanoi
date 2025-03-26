.data
movdisk:    .string " Move disk : "
to:         .string " to: "
newline:    .string "\n"

# Input number of disks
disknum:    .word 3

.text
toh:
    # Load the value of disknum into a register
    lw t0, disknum

    # Calculate number of steps: 2^n - 1
    li t1, 1                # Initialize t1 to 1 for 2^n calculation
    sll t1, t1, t0          # t1 = 2^n
    addi t1, t1, -1         # t1 = 2^n - 1

loop:
    bgt t2, t1, end         # If t2 > (2^n - 1), exit loop

movedisk:
    # Start the Tower of Hanoi calculation
    neg t3, t2
    and t3, t2, t3

    li t4, 1

whichdisk:
    srli t3, t3, 1
    beqz t3, printdisk      # If t3 is zero, we've found the disk
    addi t4, t4, 1
    j whichdisk             # Repeat until disk is found

printdisk:
    addi a0, x0, 4          # System call for print string
    la a1, movdisk          # Load " Move disk "
    ecall

    # Print disk number
    addi a0, x0, 1          # System call for integer print
    add a1, x0, t4          # Disk number
    ecall

towhichrod:
    # Calculate destination rod
    addi t4, t2, -1         # t4 = t2 - 1
    or t5, t2, t4           # t5 = t2 | (t2 - 1)
    addi t5, t5, 1          # t5 = (t2 | (t2 - 1)) + 1
    li t6, 3
    rem t5, t5, t6          # t5 = ((t2 | (t2 - 1)) + 1) % 3
    addi t5, t5, 1          # Convert to 1-indexed rods (1-3)

    # Print " to rod "
    addi a0, x0, 4          # System call for print string
    la a1, to               # Load " to: "
    ecall

    # Print rod number
    addi a0, x0, 1          # System call for integer print
    add a1, x0, t5          # Destination rod number
    ecall

end:
    addi t2, t2, 1          # Increment move counter
    j loop                  # Repeat until all disks are moved
