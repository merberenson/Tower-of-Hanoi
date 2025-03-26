# Tower of Hanoi (RISC-V Assembly)

## Overview
The Tower of Hanoi is a classic recursive puzzle involving three rods and multiple disks of varying sizes. The objective is to move the entire stack of disks from one rod to another, adhering to the following rules:

- Only one disk can be moved at a time.
- Each move consists of sliding the upper disk from one rod to another rod, on top of any disks that may already be present.
- No disk may be placed on top of a smaller disk.

This project implements the Tower of Hanoi puzzle solution using RISC-V assembly language, demonstrating recursive algorithms, binary calculations, and low-level programming.

## Features
- Recursive implementation in RISC-V assembly.
- Clear demonstration of stack usage and register management.
- Uses binary calculations to determine disk moves efficiently.
- Easily adjustable number of disks to demonstrate complexity and recursion depth.

## Implementation Approach
The Tower of Hanoi is implemented using binary calculations to optimize disk movements. Here's the step-by-step process:

1. **Initialize Registers**:
   - Load the number of disks into register `t0`.
   - Calculate the total moves (`2^n - 1`) and store in register `t1`.

2. **Create Move Loop**:
   - Iterate from 1 to `2^n - 1`, using a loop counter (`t2`) to track each move.

3. **Calculate Disk to Move**:
   - Identify the disk to move by finding the lowest bit set in the move counter (`disk = t2 & (-t2)`).

4. **Determine Source and Destination Rods**:
   - Calculate source rod using `(t2 & (t2 - 1)) % 3`.
   - Calculate destination rod using `((t2 | (t2 - 1)) + 1) % 3`.

5. **Execute Move**:
   - Output each move clearly to the console until completion.

## Getting Started
1. Ensure you have a RISC-V simulator or emulator (e.g., Venus Simulator).
2. Clone this repository and load the assembly file into your simulator.
3. Execute the program and observe the step-by-step disk movements displayed in the simulator's console output.

## Performance Notes
The current RISC-V implementation efficiently solves the Tower of Hanoi puzzle for around 15-16 disks. For 15 disks, the solution requires 32,767 moves; for 16 disks, it requires 65,535 moves. Performance limitations occur beyond this range due to simulator constraints.

## Requirements
- [Venus RISC-V Simulator](https://venus.cs61c.org/) or any compatible RISC-V simulator/emulator.

## Usage
Modify the number of disks by adjusting the initial argument in the assembly code to observe varying levels of recursion and complexity.

## Credits
- Implemented by **Meredith Berenson**.

Enjoy exploring recursion, binary calculations, and assembly programming with the Tower of Hanoi!

