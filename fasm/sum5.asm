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

; Check every combination, q>=j>=x>=y>=z.
    mov r10, 1 ; q
    qLoop:
        mov r11, 1; j
        jLoop:
            mov r12, 1 ; x
            xLoop:
                mov r13, 1 ; y
                yLoop:
                    mov r14, 1 ; z
                    zLoop:
                        mov r15, [cubes+r12*8]
                        add r15, [cubes+r13*8]
                        add r15, [cubes+r14*8]
                        add r15, [cubes+r11*8]
                        add r15, [cubes+r10*8]

                        cmp r15, rax
                        ja @f
                        inc rcx

                    @@: inc r14
                        cmp r14, r13
                        jna zLoop
                    inc r13
                    cmp r13, r12
                    jna yLoop
                inc r12
                cmp r12, r11
                jna xLoop
            inc r11
            cmp r11, r10
            jna jLoop
        inc r10
        cmp r10, rbx
        jna qLoop

; Output.
    push LF
    push rcx
