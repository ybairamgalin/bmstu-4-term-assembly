
CCFLAGS := -std=c++14 -O0

ifeq ($(OS),Windows_NT)
    CCFLAGS += -D WIN32
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        CCFLAGS += -D AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            CCFLAGS += -D AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            CCFLAGS += -D IA32
        endif
    endif
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CCFLAGS += -D LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        CCFLAGS += -D OSX
    endif
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        CCFLAGS += -D AMD64
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        CCFLAGS += -D IA32
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        CCFLAGS += -D ARM
    endif
endif

all: sse_main.exe fpu_main.exe asm_main.exe

run:
	@echo -------SSE-------
	./sse_main.exe
	@echo -------FPU-------
	./fpu_main.exe
	@echo -------ASM-------
	./asm_main.exe

sse_main.exe: main.cpp
	g++ $(CCFLAGS) main.cpp -DSSE -mno-80387 -o sse_main.exe

fpu_main.exe: main.cpp
	g++ $(CCFLAGS) main.cpp -DFPU -m80387 -o fpu_main.exe

asm_main.exe: main.cpp
	g++ $(CCFLAGS) main.cpp -DASM -masm=intel -o asm_main.exe

.PHONY: dis

dis: all
	objdump -D sse_main.exe > dis/sse_main.txt
	objdump -D fpu_main.exe > dis/fpu_main.txt
	objdump -D asm_main.exe > dis/asm_main.txt

.PHONY: clean

clean:
	rm -rf *.exe
