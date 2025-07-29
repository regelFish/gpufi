TARGET = simple_add

NVCC = `which nvcc`
ARCH = 60
ABI_FLAG = -Xcompiler -D_GLIBCXX_USE_CXX11_ABI=0

all: clean $(TARGET)

$(TARGET):
	$(NVCC) -o simple_add -Xptxas -v -arch=sm_$(ARCH) simple_add.cu $(ABI_FLAG)

test:
	./simple_add 

golden:
	./simple_add > golden_stdout.txt 2> golden_stderr.txt

clean:
	rm -f *.o *~ simple_add

clobber: clean
	rm -f golden* *_regcount.p stdout* stderr*
