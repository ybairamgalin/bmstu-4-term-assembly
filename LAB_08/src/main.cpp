#include <iostream>
#include <cinttypes>
#include "mystrlen.h"

using std::cout;
using std::endl;

extern "C"
{
    char *mystrncpy(char *dest, const char *src, size_t n);
}

int main()
{
    cout << mystrlen("") << endl;
    cout << mystrlen("1") << endl;
    cout << mystrlen("12") << endl;
    cout << mystrlen("123") << endl;
    cout << mystrlen("1234") << endl;
    cout << mystrlen("12345") << endl;


    const char *str = "Hello world!!!";
    char dest[120];
    mystrncpy(dest, str, mystrlen(str));

    printf("%s", dest);

    return 0;
}
