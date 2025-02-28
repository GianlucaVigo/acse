        .global _start
        .data
l_a:    .space 4
l_b:    .space 4
        .text
_start: li     s0, 10                                   # ./tests/cswap/cswap.c:3
        la     s1, l_a
        sw     s0, 0(s1)
        li     s0, 10                                   # ./tests/cswap/cswap.c:5
        li     s1, 11
        la     s2, l_a
        lw     s2, 0(s2)
        la     s3, l_b
        lw     s3, 0(s3)
        la     s3, l_b
        sw     s2, 0(s3)
        bne    s2, s0, l_3
        la     s0, l_a
        sw     s1, 0(s0)
l_3:    la     s0, l_a                                  # ./tests/cswap/cswap.c:7
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_b                                  # ./tests/cswap/cswap.c:8
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s0, 12                                   # ./tests/cswap/cswap.c:10
        li     s1, 15
        li     s2, 2
        mul    s1, s1, s2
        la     s2, l_a
        lw     s2, 0(s2)
        la     s3, l_b
        lw     s3, 0(s3)
        la     s3, l_b
        sw     s2, 0(s3)
        bne    s2, s0, l_4
        la     s0, l_a
        sw     s1, 0(s0)
l_4:    la     s0, l_a                                  # ./tests/cswap/cswap.c:13
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_b                                  # ./tests/cswap/cswap.c:14
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     a7, 10
        ecall
