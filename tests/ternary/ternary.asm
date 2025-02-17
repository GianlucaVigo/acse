        .global _start
        .data
l_a:    .space 4
        .text
_start: li     s0, 10                                   # ./tests/ternary/ternary.c:3
        la     s1, l_a
        sw     s0, 0(s1)
        la     s0, l_a                                  # ./tests/ternary/ternary.c:5
        lw     s0, 0(s0)
        li     s1, 5
        slt    s0, s1, s0
        li     s1, 5
        li     s2, 15
        beq    s0, zero, l_2
        addi   s1, s1, 0
        j      l_3
l_2:    addi   s1, s2, 0
l_3:    li     s0, 3
        add    s1, s1, s0
        la     s0, l_a
        sw     s1, 0(s0)
        la     s0, l_a                                  # ./tests/ternary/ternary.c:7
        lw     s0, 0(s0)
        li     s1, 8
        sub    s0, s0, s1
        sltiu  s0, s0, 1
        li     s1, 1
        li     s2, 0
        beq    s0, zero, l_4
        addi   s1, s1, 0
        j      l_5
l_4:    addi   s1, s2, 0
l_5:    li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     a7, 10
        ecall
