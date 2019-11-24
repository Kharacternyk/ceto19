; Fill `cubes` array.
    cubes=buffer
    zer rdi
@@: inc rdi
    mov rbx, rdi
    imul rbx, rdi; ^2
    imul rbx, rdi; ^3
    mov [cubes+rdi*8], rbx
    cmp rbx, rax
    jb @b

; Store the highest index.
    mov rcx, rdi

; Counter.
    zer r9

; Check every combination, x>=y>=z.
    mov r15, rax
    mov r12, 1 ; x
    xLoop:
        mov r13, 1 ; y
        yLoop:
            mov r14, 1 ; z
            zLoop:
                mov rbx, [cubes+r12*8]
                add rbx, [cubes+r13*8]
                add rbx, [cubes+r14*8]
                cmp rbx, r15
                jne @f
                push LF
                push r12
                push TAB
                push r13
                push TAB
                push r14
                inc r9
            @@: inc r14
                cmp r14, r13
                jna zLoop
            inc r13
            cmp r13, r12
            jna yLoop
        inc r12
        cmp r12, rcx
        jna xLoop

; Push a counter.
    push LF
    push r9
