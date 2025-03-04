        .global _start
        .data
l_a:    .space 4
l_b:    .space 4
        .text
_start: li     a7, 5                                    # ./tests/softdiv/softdiv.c:3
        ecall
        addi   a0, a0, 0
        la     s0, l_a
        sw     a0, 0(s0)
        li     a7, 5                                    # ./tests/softdiv/softdiv.c:4
        ecall
        addi   a0, a0, 0
        la     s0, l_b
        sw     a0, 0(s0)
        la     s0, l_a                                  # ./tests/softdiv/softdiv.c:6
        lw     s0, 0(s0)
        la     s1, l_b
        lw     s1, 0(s1)
        div    s0, s0, s1
        la     s1, l_a
        lw     s1, 0(s1)
        la     s2, l_b
        lw     s2, 0(s2)
        addi   s3, zero, 0
        addi   s4, s1, 0
l_3:    slt    s4, s1, s2
        xori   s4, s4, 1
        beq    s4, zero, l_4
        addi   s3, s3, 1
        sub    s1, s1, s2
        j      l_3
l_4:    sub    s0, s0, s3
        sltiu  s0, s0, 1
        beq    s0, zero, l_5
        li     a0, 1                                    # ./tests/softdiv/softdiv.c:7
        li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        j      l_6                                      # ./tests/softdiv/softdiv.c:8
l_5:    li     a0, 0                                    # ./tests/softdiv/softdiv.c:9
        li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
l_6:    li     a7, 10
        ecall
