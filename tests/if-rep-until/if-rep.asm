        .global _start
        .data
l_i:    .space 4
        .text
_start: li     a7, 5                                    # ./tests/if-rep-until/if-rep.c:3
        ecall
        addi   a0, a0, 0
        la     s0, l_i
        sw     a0, 0(s0)
        la     s0, l_i                                  # ./tests/if-rep-until/if-rep.c:5
        lw     s0, 0(s0)
        li     s1, 3
        slt    s0, s0, s1
        beq    s0, zero, l_2
l_3:    la     s0, l_i                                  # ./tests/if-rep-until/if-rep.c:6
        lw     s0, 0(s0)
        li     a7, 1
        addi   a0, s0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_i                                  # ./tests/if-rep-until/if-rep.c:7
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        la     s0, l_i                                  # ./tests/if-rep-until/if-rep.c:8
        lw     s0, 0(s0)
        li     s1, 6
        sub    s0, s0, s1
        sltiu  s0, s0, 1
        beq    s0, zero, l_3
l_2:    li     a0, 99                                   # ./tests/if-rep-until/if-rep.c:10
        li     a7, 1
        addi   a0, a0, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        li     a7, 10
        ecall
