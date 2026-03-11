TARGET = simple_subtract
# CUDA
NVCC = `which nvcc`
ARCH=60

all: clean $(TARGET) 

$(TARGET): 
	$(NVCC) -o simple_subtract -Xptxas -v -arch=sm_$(ARCH) simple_subtract.cu 

test:
	./simple_subtract 

golden:
	./simple_subtract >golden_stdout.txt 2>golden_stderr.txt

clean:
	rm -f *.o *~ simple_subtract

clobber: clean
	rm -f golden* *_regcount.p stdout* stderr*