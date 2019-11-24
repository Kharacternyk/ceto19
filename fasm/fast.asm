; An array to quickly determine whether a number is a cube.
    marks=buffer+5000*8

; An array to store cubes.
    cubes=buffer

; Zero the `marks` array.
    zer rdi
@@: mov byte [marks+rdi], 0
    inc rdi
    cmp rdi, rax
    jb @b

; Fill the arrays.
    zer rdi
@@: inc rdi
    mov r8, rdi
    imul r8, rdi; ^2
    imul r8, rdi; ^3
    mov [cubes+rdi*8], r8
    mov byte [marks+r8], 1
    cmp r8, rax
    jb @b

; Store the highest index.
    mov rcx, rdi

; Counter.
    zer r9

; Check every combination, x>=y>=z.
    mov r12, 1 ; x
    xLoop:
        mov r13, 1 ; y
        yLoop:
            mov r15, rax
            sub r15, [cubes+r12*8]
            sub r15, [cubes+r13*8]
            cmp r15, [cubes+r13*8]
            ja @f
            cmp byte [marks+r15], 0
            je @f
            inc r9
        @@: inc r13
            cmp r13, r12
            jna yLoop
        inc r12
        cmp r12, rcx
        jna xLoop

; Push a counter.
    push LF
    push r9
