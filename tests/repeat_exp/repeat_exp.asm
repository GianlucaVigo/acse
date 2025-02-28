        .global _start
        .data
l_a:    .space 4
l_b:    .space 4
        .text
_start: li     s0, 0                                    # ./tests/repeat_exp/repeat_exp.c:3
        li     s1, 10
        la     s2, l_a
        sw     s0, 0(s2)
        ble    s1, zero, l_3
        add    s1, s1, zero
l_4:    beq    s1, zero, l_3
        addi   s1, s1, -1
        la     s0, l_a
        lw     s0, 0(s0)
        li     s2, 1
        add    s0, s0, s2
        la     s2, l_a
        sw     s0, 0(s2)
        j      l_4
l_3:    la     s0, l_a                                  # ./tests/repeat_exp/repeat_exp.c:5
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_a                                  # ./tests/repeat_exp/repeat_exp.c:7
        lw     s0, 0(s0)
        li     s1, 3
        mul    s0, s0, s1
        la     s1, l_a
        lw     s1, 0(s1)
        li     s2, 15
        sub    s1, s1, s2
        la     s2, l_b
        sw     s0, 0(s2)
        ble    s1, zero, l_5
        add    s1, s1, zero
l_6:    beq    s1, zero, l_5
        addi   s1, s1, -1
        la     s0, l_b
        lw     s0, 0(s0)
        li     s2, 1
        sub    s0, s0, s2
        la     s2, l_b
        sw     s0, 0(s2)
        j      l_6
l_5:    la     s0, l_b                                  # ./tests/repeat_exp/repeat_exp.c:9
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s0, 1000                                 # ./tests/repeat_exp/repeat_exp.c:11
        li     s1, 3
        la     s2, l_a
        sw     s0, 0(s2)
        ble    s1, zero, l_7
        add    s1, s1, zero
l_8:    beq    s1, zero, l_7
        addi   s1, s1, -1
        la     s0, l_a
        lw     s0, 0(s0)
        li     s2, 4096576
        la     s3, l_a
        lw     s3, 0(s3)
        div    s2, s2, s3
        add    s0, s0, s2
        li     s2, 2
        div    s0, s0, s2
        la     s2, l_a
        sw     s0, 0(s2)
        j      l_8
l_7:    la     s0, l_a                                  # ./tests/repeat_exp/repeat_exp.c:13
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
