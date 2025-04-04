        .global _start
        .data
l_a:    .space 4
l_i:    .space 4
        .text
_start: li     s0, 12345                                # ./tests/random/random.c:3
        li     s1, 0
        la     s2, l_i
        sw     s1, 0(s2)
l_3:    la     s1, l_i                                  # ./tests/random/random.c:4
        lw     s1, 0(s1)
        li     s2, 3
        slt    s1, s1, s2
        beq    s1, zero, l_4
        li     s1, 1664525                              # ./tests/random/random.c:5
        mul    s1, s0, s1
        li     s2, 1013904223
        add    s1, s1, s2
        add    s0, s1, zero
        li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s1, l_i                                  # ./tests/random/random.c:6
        lw     s1, 0(s1)
        li     s2, 1
        add    s1, s1, s2
        la     s2, l_i
        sw     s1, 0(s2)
        j      l_3                                      # ./tests/random/random.c:7
l_4:    li     s1, 12300                                # ./tests/random/random.c:9
        li     s2, 45
        add    s1, s1, s2
        li     s0, 12345
        li     s1, 1664525                              # ./tests/random/random.c:10
        mul    s1, s0, s1
        li     s2, 1013904223
        add    s1, s1, s2
        add    s0, s1, zero
        li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     s1, 1664525                              # ./tests/random/random.c:11
        mul    s1, s0, s1
        li     s2, 1013904223
        add    s1, s1, s2
        add    s0, s1, zero
        li     s0, 1000
        div    s1, s1, s0
        li     s0, 7
        add    s1, s1, s0
        la     s0, l_a
        sw     s1, 0(s0)
        la     s0, l_a                                  # ./tests/random/random.c:12
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
