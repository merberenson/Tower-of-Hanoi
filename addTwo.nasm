section .rodata
LC0 db "Enter two integers: ", 0
LC1 db "%d %d", 0
LC2 db "Sum: %d", 10, 0   ; '\n' is 10 in ASCII

section .text
global main
extern printf
extern scanf
extern __stack_chk_fail

main:
    push rbp                 ; Push the base pointer
    mov rbp, rsp             ; Move stack pointer to base pointer
    sub rsp, 32              ; Allocate space on the stack (32 bytes)
    
    mov rax, [fs:40]         ; Save stack protector canary
    mov [rbp-8], rax
    xor eax, eax             ; Clear eax (equivalent to setting return value to 0)
    
    ; Print "Enter two integers: "
    mov rdi, LC0             ; Move address of LC0 to rdi
    xor eax, eax             ; Clear eax before call (required for variadic functions)
    call printf
    
    ; Read two integers
    lea rdx, [rbp-16]        ; Load address for first integer
    lea rax, [rbp-20]        ; Load address for second integer
    mov rsi, rax             ; Move address of second integer into rsi
    mov rdi, LC1             ; Move address of format string to rdi
    xor eax, eax             ; Clear eax before call
    call scanf               ; Call scanf to get the input
    
    ; Add the two integers
    mov edx, [rbp-20]        ; Load second integer into edx
    mov eax, [rbp-16]        ; Load first integer into eax
    add eax, edx             ; Add the values
    mov [rbp-12], eax        ; Store the result (sum) in [rbp-12]
    
    ; Print the result
    mov eax, [rbp-12]        ; Load result into eax
    mov esi, eax             ; Move result into esi for printf
    mov rdi, LC2             ; Move format string to rdi
    xor eax, eax             ; Clear eax before call
    call printf              ; Print the result
    
    ; Exit
    mov rax, [rbp-8]         ; Load stack protector canary
    xor rax, [fs:40]         ; Compare with the original canary
    je .L3                   ; If equal, jump to L3
    call __stack_chk_fail    ; If not, call stack check fail
    
.L3:

    leave                    ; Restore stack and base pointer
    ret                      ; Return from the function
