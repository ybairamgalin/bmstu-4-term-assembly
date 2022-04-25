#include "mystrlen.h"

uint64_t mystrlen(const char *str)
{
    uint64_t lng = 0;

    __asm__(
        "movq   %1,       %%rax        \n\t" // put pointer value at rax
        "L_START:                      \n\t"
        "movb   (%%rax),  %%bl         \n\t" // read from rax
        "cmpb   $0x0,     %%bl         \n\t" // cmp
        "je     L_END                  \n\t" // jump if zero
        "addq   $0x1,     %%rax        \n\t" // increase address by 1
        "jmp    L_START                \n\t"
        "L_END:                        \n\t"
        "subq   %1,       %%rax        \n\t"
        "movq   %%rax, %0              \n\t"

        : "=r" (lng)
        : "r" (str)
        : "rax", "rbx"
    );

    return lng;
}
