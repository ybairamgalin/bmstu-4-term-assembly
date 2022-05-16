#include <iostream>
#include <time.h>

using namespace std;

#define REPEATS 1e7


template<typename T>
inline T asmAdder(const T a, const T b)
{
    T res;


#ifndef OSX
    __asm__("fld %1\n"
            "fld %2\n"
            "faddp\n"
            "fstp %0\n"
            : "=m"(res)
            : "m"(a),
            "m"(b)
    );
#else
    __asm__("fldl %1\n"
            "fldl %2\n"
            "faddp\n"
            "fstpl %0\n"
            : "=m"(res)
            : "m"(a),
            "m"(b)
    );
#endif

    return res;
}

template<typename T>
inline T asmMul(const T a, const T b)
{
    T res;
#ifndef OSX
    __asm__("fld %1\n"
            "fld %2\n"
            "fmulp\n"
            "fstp %0\n"
        : "=m"(res)
        : "m"(a),
        "m"(b)
    );
#else
    __asm__("fldl %1\n"
            "fldl %2\n"
            "fmulp\n"
            "fstpl %0\n"
        : "=m"(res)
        : "m"(a),
        "m"(b)
    );
#endif

    return res;
}

template<typename T>
inline T mul(const T first, const T second)
{
    return first * second;
}

template<typename T>
inline T adder(const T first, const T second)
{
    return first + second;
}


template<typename T>
void timeIt(T (*add)(const T, const T),
        const T first, const T second)
{
    T sum;
    auto start = clock();

    for (size_t i = 0; i < REPEATS; i++)
        sum = add(first, second);

    auto taken = clock() - start;

    cout << "TIME TAKEN: " << taken << endl;
}

void timeAdd()
{
#ifndef ASM
    cout << "C ADDITION\n";
    cout << "FLOAT\t";
    timeIt(adder<float>, float(100.12), float(20000.432));
    cout << "DOUBLE\t";
    timeIt(adder<double>, 100.312, 3372036854775.807);

#ifndef SSE
    cout << "LDOUBLE\t";
    timeIt(adder<long double>, 100.4134L, 3372036854775807.123L);
#endif // SSE

//#ifdef FPU
//    cout << "F 80\t";
//    timeIt(adder<__float80>, 100.4134L, 3372036854775807.123L);
//#endif // FPU

#endif // ASM

#ifdef ASM
    cout << "INLINE ASM ADDITION\n";
    cout << "FLOAT\t";
    timeIt(asmAdder<float>, float(100.3213), float(20000));
    cout << "DOUBLE\t";
    timeIt(asmAdder<double>, 100.124124, 33726854775807.3);
    cout << "LDOUBLE\t";
    timeIt(asmAdder<long double>, 100.4134L, 3372036875807.123L);
#endif // ASM
}

void timeMul()
{
#ifndef ASM
    cout << "C MUL\n";
    cout << "FLOAT\t";
    timeIt(mul<float>, float(100.12), float(20000.432));
    cout << "DOUBLE\t";
    timeIt(mul<double>, 100.312, 3372036854775.807);

#ifndef SSE
    cout << "LDOUBLE\t";
    timeIt(mul<long double>, 100.4134L, 3372036854775807.123L);
#endif // SSE

#ifndef OSX
#ifdef FPU
    cout << "F 80\t";
    timeIt(mul<__float80>, 100.4134L, 3372036854775807.123L);
#endif // FPU
#endif // OSX

#endif // ASM

#ifdef ASM
    cout << "INLINE ASM MUL\n";
    cout << "FLOAT\t";
    timeIt(asmMul<float>, float(100.3213), float(20000));
    cout << "DOUBLE\t";
    timeIt(asmMul<double>, 100.124124, 33726854775807.3);
    cout << "LDOUBLE\t";
    timeIt(asmMul<long double>, 100.4134L, 3372036875807.123L);
#endif // ASM
}

int main(void)
{
    timeAdd();
    timeMul();

    return EXIT_SUCCESS;
}
