#include <iostream>
#include <cinttypes>
#include "mystrlen.h"

using std::cout;
using std::endl;

int main()
{
    const char *str = "Name";

    cout << mystrlen("") << endl;
    cout << mystrlen("1") << endl;
    cout << mystrlen("12") << endl;
    cout << mystrlen("123") << endl;
    cout << mystrlen("1234") << endl;
    cout << mystrlen("12345") << endl;

    return 0;
}
