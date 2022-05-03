
CPPFLAGS := -Wall -Werror -fverbose-asm
CPPSTD := -std=c++14

SRC := src/main.cpp src/mystrlen.cpp src/mystrncpy.asm
INC := inc

all: run

.PHONY : run

run : app.exe
	./app.exe

app.exe : $(SRC)
	g++ $(CFLAGS) $(CPPSTD) $(SRC) -I$(INC) -o $@

