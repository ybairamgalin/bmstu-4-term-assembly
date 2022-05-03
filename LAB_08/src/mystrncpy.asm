.section        __TEXT,__text,regular,pure_instructions # section def
.build_version  macos, 11, 0	sdk_version 12, 0       # os
.globl	        _mystrncpy
.p2align	    4, 0x90                                 # alignment

_mystrncpy:
        pushq   %rbp                   # save rbp
        movq    %rsp, %rbp             # rsp -> rbp

        cmp     %rdi, %rdi             # dest < src
        jbe     .COPY

        movq    %rdi, %rax
        subq    %rsi, %rax
        cmp     %rax, %rdx             # dest < src && dest - src > lng
        ja      .COPY

        addq    %rcx, %rdi
        subq    $1, %rdi
        addq    %rcx, %rsi
        subq    $1, %rsi

        std                            # set df flag
.COPY:
        movq    %rdx, %rcx
        rep     movsb
        movb    $0, (%rdi, %rcx)

.END:
        movq    %rdi, %rax
        popq    %rbp
        cld
        retq
