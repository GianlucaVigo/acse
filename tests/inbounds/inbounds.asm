        .global _start
        .data
l_v:    .space 4
l_i:    .space 4
l_a:    .space 20
        .text
_start: li     s0, 0                                    # ./tests/inbounds/inbounds.c:3
        li     s1, 8
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        li     s0, 1                                    # ./tests/inbounds/inbounds.c:4
        li     s1, 6
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        li     s0, 2                                    # ./tests/inbounds/inbounds.c:5
        li     s1, 9
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        li     s0, 3                                    # ./tests/inbounds/inbounds.c:6
        li     s1, 4
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        li     s0, 4                                    # ./tests/inbounds/inbounds.c:7
        li     s1, 7
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        li     s0, 0                                    # ./tests/inbounds/inbounds.c:10
        li     s1, 0
        addi   s2, zero, 5
        bge    s0, s2, l_4
        blt    s0, zero, l_4
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        lw     s2, 0(s2)
        la     s0, l_v
        sw     s2, 0(s0)
        li     s1, 1
l_4:    beq    s1, zero, l_5
        li     a0, 1                                    # ./tests/inbounds/inbounds.c:11
        li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        j      l_6                                      # ./tests/inbounds/inbounds.c:12
l_5:    li     a0, 2                                    # ./tests/inbounds/inbounds.c:13
        li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
l_6:    li     s0, 1                                    # ./tests/inbounds/inbounds.c:16
        sub    s0, zero, s0
        la     s1, l_v
        lw     s1, 0(s1)
        add    s0, s0, s1
        li     a0, 0
        addi   s1, zero, 5
        bge    s0, s1, l_7
        blt    s0, zero, l_7
        la     s1, l_a
        li     s2, 4
        mul    s0, s0, s2
        add    s1, s1, s0
        lw     s1, 0(s1)
        la     s0, l_v
        sw     s1, 0(s0)
        li     a0, 1
l_7:    li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s0, 2                                    # ./tests/inbounds/inbounds.c:18
        la     s1, l_i
        sw     s0, 0(s1)
l_8:    la     s0, l_i                                  # ./tests/inbounds/inbounds.c:19
        lw     s0, 0(s0)
        li     s1, 0
        addi   s2, zero, 5
        bge    s0, s2, l_9
        blt    s0, zero, l_9
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        lw     s2, 0(s2)
        la     s0, l_v
        sw     s2, 0(s0)
        li     s1, 1
l_9:    beq    s1, zero, l_10
        la     s0, l_v                                  # ./tests/inbounds/inbounds.c:20
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_i                                  # ./tests/inbounds/inbounds.c:21
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_8                                      # ./tests/inbounds/inbounds.c:22
l_10:   li     a7, 10
        ecall
