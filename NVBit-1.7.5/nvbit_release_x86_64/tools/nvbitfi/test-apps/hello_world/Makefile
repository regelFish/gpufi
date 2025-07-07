TARGET = hello_world

# CUDA
NVCC = `which nvcc`
ARCH=60

all: clean $(TARGET) 

$(TARGET): 
	$(NVCC) -o hello_world -Xptxas -v -arch=sm_$(ARCH) hello_world.cu 

test:
	./hello_world 

golden:
	./hello_world >golden_stdout.txt 2>golden_stderr.txt

clean:
	rm -f *.o *~ hello_world

clobber: clean
	rm -f golden* *_regcount.p stdout* stderr*
