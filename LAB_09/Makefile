
all: sse_main.exe fpu_main.exe asm_main.exe

run:
	./sse_main.exe
	./fpu_main.exe
	./asm_main.exe

sse_main.exe: main.cpp
	g++ main.cpp -O0 -DSSE -mno-80387 -o sse_main.exe

fpu_main.exe: main.cpp
	g++ main.cpp -O0 -DFPU -m80387 -o fpu_main.exe

asm_main.exe: main.cpp
	g++ main.cpp -O0 -DASM -masm=intel -o asm_main.exe

.PHONY: dis

dis: all
	objdump -D sse_main.exe > dis/sse_main.txt
	objdump -D fpu_main.exe > dis/fpu_main.txt
	objdump -D asm_main.exe > dis/asm_main.txt

.PHONY: clean

clean:
	rm -rf *.exe
