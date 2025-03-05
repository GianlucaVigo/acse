        .global _start
        .data
l_a:    .space 40
l_b:    .space 4
l_i:    .space 4
        .text
_start: li     s0, 24                                   # ./tests/replace/replace.c:3
        la     s1, l_b
        sw     s0, 0(s1)
        li     s0, 0                                    # ./tests/replace/replace.c:4
        la     s1, l_i
        sw     s0, 0(s1)
l_4:    la     s0, l_i                                  # ./tests/replace/replace.c:7
        lw     s0, 0(s0)
        li     s1, 10
        slt    s0, s0, s1
        beq    s0, zero, l_5
        la     s0, l_i                                  # ./tests/replace/replace.c:8
        lw     s0, 0(s0)
        la     s1, l_i
        lw     s1, 0(s1)
        li     s2, 1
        add    s1, s1, s2
        la     s2, l_a
        li     s3, 4
        mul    s0, s0, s3
        add    s2, s2, s0
        sw     s1, 0(s2)
        la     s0, l_i                                  # ./tests/replace/replace.c:9
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_4                                      # ./tests/replace/replace.c:10
l_5:    li     s0, 0                                    # ./tests/replace/replace.c:12
        la     s1, l_i
        sw     s0, 0(s1)
        la     s0, l_b                                  # ./tests/replace/replace.c:14
        lw     s0, 0(s0)
        li     s1, 17
        sub    s0, s0, s1
        li     s1, 5
        addi   s2, zero, 0
        li     s3, 10
l_6:    bge    s2, s3, l_8
        la     s4, l_a
        li     s5, 4
        mul    s5, s2, s5
        add    s4, s4, s5
        lw     s4, 0(s4)
        beq    s4, s0, l_7
l_9:    addi   s2, s2, 1
        j      l_6
l_7:    la     s4, l_a
        li     s5, 4
        mul    s5, s2, s5
        add    s4, s4, s5
        sw     s1, 0(s4)
        j      l_9
l_8:    la     s0, l_i                                  # ./tests/replace/replace.c:16
        lw     s0, 0(s0)
        li     s1, 10
        slt    s0, s0, s1
        beq    s0, zero, l_11
        la     s0, l_i                                  # ./tests/replace/replace.c:17
        lw     s0, 0(s0)
        la     s1, l_a
        li     s2, 4
        mul    s0, s0, s2
        add    s1, s1, s0
        lw     s1, 0(s1)
        li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_i                                  # ./tests/replace/replace.c:18
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_8                                      # ./tests/replace/replace.c:19
l_11:   li     s0, 0                                    # ./tests/replace/replace.c:21
        la     s1, l_i
        sw     s0, 0(s1)
        li     s0, 5                                    # ./tests/replace/replace.c:23
        la     s1, l_b
        lw     s1, 0(s1)
        li     s2, 2
        div    s1, s1, s2
        addi   s2, zero, 0
        li     s3, 10
l_12:   bge    s2, s3, l_14
        la     s4, l_a
        li     s5, 4
        mul    s5, s2, s5
        add    s4, s4, s5
        lw     s4, 0(s4)
        beq    s4, s0, l_13
l_15:   addi   s2, s2, 1
        j      l_12
l_13:   la     s4, l_a
        li     s5, 4
        mul    s5, s2, s5
        add    s4, s4, s5
        sw     s1, 0(s4)
        j      l_15
l_14:   la     s0, l_i                                  # ./tests/replace/replace.c:25
        lw     s0, 0(s0)
        li     s1, 10
        slt    s0, s0, s1
        beq    s0, zero, l_17
        la     s0, l_i                                  # ./tests/replace/replace.c:26
        lw     s0, 0(s0)
        la     s1, l_a
        li     s2, 4
        mul    s0, s0, s2
        add    s1, s1, s0
        lw     s1, 0(s1)
        li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_i                                  # ./tests/replace/replace.c:27
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_14                                     # ./tests/replace/replace.c:28
l_17:   li     s0, 0                                    # ./tests/replace/replace.c:30
        la     s1, l_i
        sw     s0, 0(s1)
        la     s0, l_b                                  # ./tests/replace/replace.c:32
        lw     s0, 0(s0)
        sub    s0, zero, s0
        li     s1, 10
        mul    s0, s0, s1
        li     s1, 24
        sub    s1, zero, s1
        la     s2, l_b
        lw     s2, 0(s2)
        add    s1, s1, s2
        addi   s2, zero, 0
        li     s3, 10
l_18:   bge    s2, s3, l_20
        la     s4, l_a
        li     s5, 4
        mul    s5, s2, s5
        add    s4, s4, s5
        lw     s4, 0(s4)
        beq    s4, s0, l_19
l_21:   addi   s2, s2, 1
        j      l_18
l_19:   la     s4, l_a
        li     s5, 4
        mul    s5, s2, s5
        add    s4, s4, s5
        sw     s1, 0(s4)
        j      l_21
l_20:   la     s0, l_i                                  # ./tests/replace/replace.c:34
        lw     s0, 0(s0)
        li     s1, 10
        slt    s0, s0, s1
        beq    s0, zero, l_23
        la     s0, l_i                                  # ./tests/replace/replace.c:35
        lw     s0, 0(s0)
        la     s1, l_a
        li     s2, 4
        mul    s0, s0, s2
        add    s1, s1, s0
        lw     s1, 0(s1)
        li     a7, 1
        addi   a0, s1, 0
        ecall
        li     a0, 10
        li     a7, 11
        addi   a0, a0, 0
        ecall
        la     s0, l_i                                  # ./tests/replace/replace.c:36
        lw     s0, 0(s0)
        li     s1, 1
        add    s0, s0, s1
        la     s1, l_i
        sw     s0, 0(s1)
        j      l_20                                     # ./tests/replace/replace.c:37
l_23:   li     s0, 0                                    # ./tests/replace/replace.c:39
        la     s1, l_i
        sw     s0, 0(s1)
        li     a7, 10
        ecall
