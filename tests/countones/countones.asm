        .global _start
        .data
l_a:    .space 4
l_b:    .space 4
        .text
_start: li     s5, 123456                               # ./tests/countones/countones.c:2
        la     s6, l_a
        sw     s5, 0(s6)
        la     s5, l_a                                  # ./tests/countones/countones.c:4
        lw     s5, 0(s5)
        li     s6, 31
l_3:    sra    s7, s5, s6
        andi   s7, s7, 1
        add    s4, s4, s7
        beq    s6, zero, l_4
        addi   s6, s6, -1
        j      l_3
l_4:    li     s5, 100
        add    s4, s4, s5
        la     s5, l_b
        sw     s4, 0(s5)
        la     s4, l_b                                  # ./tests/countones/countones.c:5
        lw     s4, 0(s4)
        li     a7, 1
        addi   a0, s4, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s4, l_a                                  # ./tests/countones/countones.c:7
        lw     s4, 0(s4)
        li     s5, 64
        sub    s4, s4, s5
        li     s5, 255
        add    s4, s4, s5
        li     s5, 31
l_5:    sra    s6, s4, s5
        andi   s6, s6, 1
        add    s3, s3, s6
        beq    s5, zero, l_6
        addi   s5, s5, -1
        j      l_5
l_6:    la     s4, l_b
        sw     s3, 0(s4)
        la     s3, l_b                                  # ./tests/countones/countones.c:8
        lw     s3, 0(s3)
        li     a7, 1
        addi   a0, s3, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s3, 1                                    # ./tests/countones/countones.c:10
        sub    s3, zero, s3
        li     s4, 31
l_7:    sra    s5, s3, s4
        andi   s5, s5, 1
        add    s2, s2, s5
        beq    s4, zero, l_8
        addi   s4, s4, -1
        j      l_7
l_8:    la     s3, l_b
        sw     s2, 0(s3)
        la     s2, l_b                                  # ./tests/countones/countones.c:11
        lw     s2, 0(s2)
        li     a7, 1
        addi   a0, s2, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s2, 16                                   # ./tests/countones/countones.c:13
        sub    s2, zero, s2
        li     s3, 31
l_9:    sra    s4, s2, s3
        andi   s4, s4, 1
        add    s1, s1, s4
        beq    s3, zero, l_10
        addi   s3, s3, -1
        j      l_9
l_10:   li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s1, 19                                   # ./tests/countones/countones.c:14
        li     s2, 31
l_11:   sra    s3, s1, s2
        andi   s3, s3, 1
        add    s0, s0, s3
        beq    s2, zero, l_12
        addi   s2, s2, -1
        j      l_11
l_12:   li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     a7, 10
        ecall
