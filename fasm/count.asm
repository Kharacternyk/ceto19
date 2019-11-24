; The number of arguments to proccess.
    count=1000000

; Put the start of the arguments chunk into rax.
    sub rax, 1
    imul rax, count

; The lowest x that should be checked.
    mov r9, 1

; Fill `cubes` array.
    cubes=buffer
    zer rdi
cubesLoop:
    inc rdi
    mov rbx, rdi
    imul rbx, rdi; ^2
    imul rbx, rdi; ^3
    mov [cubes+rdi*8], rbx
    mov rcx, rbx
    imul rcx, 3
    cmp rcx, rax
    ja @f
    mov r9, rdi
@@: sub rbx, count
    cmp rbx, rax
    jl cubesLoop

; Store the highest index.
    mov rcx, rdi

; Prepare `results` array.
    results=buffer+5000*8
    zer r15
    zerLoop:
        mov byte [results+r15], 0
        inc r15
        cmp r15, count
        jna zerLoop

; Check every combination, x>=y>=z.
    mov r12, r9 ; x
    xLoop:
        mov r13, 1 ; y
        yLoop:
            mov r14, 1 ; z
            zLoop:
                mov r15, [cubes+r12*8]
                add r15, [cubes+r13*8]
                add r15, [cubes+r14*8]

                sub r15, rax
                cmp r15, 0
                jl @f
                cmp r15, count
                jg @f

                inc byte [results+r15]

            @@: inc r14
                cmp r14, r13
                jna zLoop
            inc r13
            cmp r13, r12
            jna yLoop
        inc r12
        cmp r12, rcx
        jna xLoop

; Push all results.
    zer r8
    pushLoop:
        movzx rbx, byte [results+r8]
        cmp rbx, 0
        je @f
        push LF
        push rbx
        push TAB
        mov r9, rax
        add r9, r8
        push r9
    @@: inc r8
        cmp r8, count
        jb pushLoop
