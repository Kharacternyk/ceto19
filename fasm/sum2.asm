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
    mov rbx, rdi

; Counter.
    zer rcx

; Check every combination, x>=y.
    mov r12, 1 ; x
    xLoop:
        mov r13, 1 ; y
        yLoop:
            mov r15, [cubes+r12*8]
            add r15, [cubes+r13*8]

            cmp r15, rax
            ja @f
            inc rcx

        @@: inc r13
            cmp r13, r12
            jna yLoop
        inc r12
        cmp r12, rbx
        jna xLoop

; Output.
    push LF
    push rcx
