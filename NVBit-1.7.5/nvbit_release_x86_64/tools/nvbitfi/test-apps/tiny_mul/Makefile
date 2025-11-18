TARGET = tiny_mul

# CUDA
NVCC = `which nvcc`
ARCH=60

all: clean $(TARGET) 

$(TARGET): 
	$(NVCC) -o $(TARGET) -Xptxas -v -arch=sm_$(ARCH) tiny_mul.cu 

test:
	./$(TARGET) 

golden:
	./$(TARGET) >golden_stdout.txt 2>golden_stderr.txt

clean:
	rm -f *.o *~ $(TARGET)

clobber: clean
	rm -f golden* *_regcount.p stdout* stderr*
