format elf64 executable 3

macro zer a* {
    xor a, a
}

macro halt errcode*, [msg*] {
forward
    mov rsi, msg + 1
    movzx rdx, byte [msg]
    mov edi, 2
    mov eax, 1
    syscall
common
    mov rdi, errcode
    mov eax, 60
    syscall
}

LF equ -10
TAB equ -9

segment executable readable
entry $

; Make sure an argument is passed.
    pop rcx
    cmp rcx, 2
    jnb @f

; Exit if not.
    halt 1, msgNoArg

; Skip the program name and go directly to the argument.
@@: add rsp, 8
    pop rdi

; Parse the argument.
    zer rax
    zer rsi
    mov cl, [rdi]
@@: sub cl, 48
    cmp cl, 9
    ja @f
    imul rax, rax, 10
    movzx rcx, cl
    add rax, rcx
    inc rsi
    mov cl, [rdi+rsi]
    cmp cl, 0
    jne @b

; Check whether a non-digit character is in input.
@@: cmp cl, 0
    je @f
    add cl, 48
    mov [msgBadDigit+2], cl
    halt 1, msgBadDigit 

; An indicator to print function that the results is over.
@@: push 0

; Include the actual algorithm.
    include 'body.fasm'

; Print the results that algorithm has pushed.
    printBuffer=buffer+20
    mov rbx, 10
printLoop:
    mov rdi, printBuffer
    pop rax
    cmp rax, 0
    je exitLabel
    jg printInt

printChar:
    imul rax, rax, -1
    mov [rdi], rax
    mov rsi, rdi
    mov rdx, 1
    mov edi, 1
    mov eax, 1
    syscall
    jmp printLoop

printInt:
    zer rdx
    div rbx
    add dl, 48
    dec rdi
    mov [rdi], dl
    cmp rax, 0
    jne printInt

    mov rsi, rdi
    mov rdx, printBuffer
    sub rdx, rdi
    mov edi, 1
    mov eax, 1
    syscall
    jmp printLoop

exitLabel:
    mov rdi, 0
    mov eax, 60
    syscall

segment writeable readable

    struc msg chars& {
        .len  db .lf+1-$
        .body db chars
        .lf   db 10
    }
    ; Some messages.
    msgNoArg    msg "An argument is required."
    msgBadDigit msg "'_' is not a digit." 

    ; Buffer for an algorithm.
    buffer rb 12000000
