TARGET = simple_mul

# CUDA
NVCC = `which nvcc`
ARCH=60

all: clean $(TARGET) 

$(TARGET): 
	$(NVCC) -o simple_mul -Xptxas -v -arch=sm_$(ARCH) simple_mul.cu 

test:
	./simple_mul

golden:
	./simple_mul >golden_stdout.txt 2>golden_stderr.txt

clean:
	rm -f *.o *~ simple_mul

clobber: clean
	rm -f golden* *_regcount.p stdout* stderr*
