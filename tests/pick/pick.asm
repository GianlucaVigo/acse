        .global _start
        .data
l_a:    .space 40
l_i:    .space 4
l_c:    .space 4
        .text
_start: li     s0, 0                                    # ./tests/pick/pick.c:3
        la     s1, l_i
        sw     s0, 0(s1)
l_4:    la     s0, l_i                                  # ./tests/pick/pick.c:5
        lw     s0, 0(s0)
        li     s1, 10
        slt    s0, s0, s1
        beq    s0, zero, l_5
        la     s0, l_i                                  # ./tests/pick/pick.c:6
        lw     s0, 0(s0)
        la     s1, l_i
        lw     s1, 0(s1)
        li     s2, 1
        add    s1, s1, s2
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        la     s0, l_i                                  # ./tests/pick/pick.c:7
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_4                                      # ./tests/pick/pick.c:8
l_5:    li     s0, 123456                               # ./tests/pick/pick.c:10
        addi   s1, zero, 0
        addi   s2, zero, 0
        li     s3, 10
        li     s4, 32
l_8:    slt    s5, s2, s3
        xori   s5, s5, 1
        bne    s5, zero, l_6
        slt    s5, s2, s4
        xori   s5, s5, 1
        bne    s5, zero, l_6
        sra    s5, s0, s2
        andi   s5, s5, 1
        bne    s5, zero, l_7
        addi   s2, s2, 1
        j      l_8
l_7:    la     s0, l_a
        li     s3, 4
        mul    s2, s2, s3
        add    s0, s0, s2
        lw     s0, 0(s0)
        add    s1, zero, s0
l_6:    li     s0, 1024
        mul    s1, s1, s0
        la     s0, l_c
        sw     s1, 0(s0)
        la     s0, l_c                                  # ./tests/pick/pick.c:12
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_c                                  # ./tests/pick/pick.c:14
        lw     s0, 0(s0)
        addi   s1, zero, 0
        addi   s2, zero, 0
        li     s3, 10
        li     s4, 32
l_11:   slt    s5, s2, s3
        xori   s5, s5, 1
        bne    s5, zero, l_9
        slt    s5, s2, s4
        xori   s5, s5, 1
        bne    s5, zero, l_9
        sra    s5, s0, s2
        andi   s5, s5, 1
        bne    s5, zero, l_10
        addi   s2, s2, 1
        j      l_11
l_10:   la     s0, l_a
        li     s3, 4
        mul    s2, s2, s3
        add    s0, s0, s2
        lw     s0, 0(s0)
        add    s1, zero, s0
l_9:    la     s0, l_c
        sw     s1, 0(s0)
        la     s0, l_c                                  # ./tests/pick/pick.c:16
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_c                                  # ./tests/pick/pick.c:18
        lw     s0, 0(s0)
        li     s1, 7168
        sub    s0, s0, s1
        addi   a0, zero, 0
        addi   s1, zero, 0
        li     s2, 10
        li     s3, 32
l_14:   slt    s4, s1, s2
        xori   s4, s4, 1
        bne    s4, zero, l_12
        slt    s4, s1, s3
        xori   s4, s4, 1
        bne    s4, zero, l_12
        sra    s4, s0, s1
        andi   s4, s4, 1
        bne    s4, zero, l_13
        addi   s1, s1, 1
        j      l_14
l_13:   la     s0, l_a
        li     s2, 4
        mul    s1, s1, s2
        add    s0, s0, s1
        lw     s0, 0(s0)
        add    a0, zero, s0
l_12:   li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     a7, 10
        ecall
