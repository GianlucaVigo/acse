        .global _start
        .data
l_d:    .space 4
l_a:    .space 4
l_b:    .space 4
l_c:    .space 4
l_e:    .space 4
l_f:    .space 4
l_g:    .space 4
        .text
_start: li     s0, 34                                   # ./tests/multassign/multassign.c:2
        la     s1, l_d
        sw     s0, 0(s1)
        li     s0, 10                                   # ./tests/multassign/multassign.c:3
        la     s1, l_a
        sw     s0, 0(s1)
        li     s0, 23
        la     s1, l_b
        sw     s0, 0(s1)
        li     s0, 41
        la     s1, l_c
        sw     s0, 0(s1)
        la     s0, l_a                                  # ./tests/multassign/multassign.c:4
        lw     s0, 0(s0)
        li     s1, 2
        mul    s0, s0, s1
        la     s1, l_e
        sw     s0, 0(s1)
        li     s0, 16
        li     s1, 4
        div    s0, s0, s1
        la     s1, l_f
        sw     s0, 0(s1)
        la     s0, l_b
        lw     s0, 0(s0)
        la     s1, l_c
        lw     s1, 0(s1)
        mul    s0, s0, s1
        la     s1, l_g
        sw     s0, 0(s1)
        la     s0, l_d                                  # ./tests/multassign/multassign.c:7
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_a                                  # ./tests/multassign/multassign.c:10
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_b                                  # ./tests/multassign/multassign.c:11
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_c                                  # ./tests/multassign/multassign.c:12
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_e                                  # ./tests/multassign/multassign.c:15
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_f                                  # ./tests/multassign/multassign.c:16
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_g                                  # ./tests/multassign/multassign.c:17
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
