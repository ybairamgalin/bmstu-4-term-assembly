.section        __TEXT,__text,regular,pure_instructions # section def
.build_version  macos, 11, 0	sdk_version 12, 0       # os
.globl	        _mystrncpy
.p2align	    4, 0x90                                 # alignment

_mystrncpy:
        pushq   %rbp                   # save bp
        movq    %rsp, %rbp             #
        movq    %rdi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        movq    %rdx, -24(%rbp)
        movq    $0, -32(%rbp)
.LBB0_1:
        movq    -32(%rbp), %rax
        cmpq    -24(%rbp), %rax
        jae     .LBB0_4
        movq    -16(%rbp), %rax
        movq    -32(%rbp), %rcx
        movb    (%rax,%rcx), %dl
        movq    -8(%rbp), %rax
        movq    -32(%rbp), %rcx
        movb    %dl, (%rax,%rcx)
        movq    -32(%rbp), %rax
        addq    $1, %rax
        movq    %rax, -32(%rbp)
        jmp     .LBB0_1
.LBB0_4:
        movq    -8(%rbp), %rax
        popq    %rbp
        retq
retq
