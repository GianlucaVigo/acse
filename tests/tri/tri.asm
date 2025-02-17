        .global _start
        .data
l_i:    .space 4
        .text
_start: li     s0, 1                                    # ./tests/tri/tri.c:3
        sub    s0, zero, s0
        la     s1, l_i
        sw     s0, 0(s1)
l_2:    la     s0, l_i                                  # ./tests/tri/tri.c:5
        lw     s0, 0(s0)
        li     s1, 10
        slt    s0, s0, s1
        beq    s0, zero, l_3
        la     s0, l_i                                  # ./tests/tri/tri.c:6
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        addi   a0, zero, 0
        ble    s0, zero, l_4
        addi   s1, s0, 1
        mul    a0, s0, s1
        li     s0, 2
        div    a0, a0, s0
l_4:    li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_i                                  # ./tests/tri/tri.c:7
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_2                                      # ./tests/tri/tri.c:8
l_3:    li     a7, 10
        ecall
