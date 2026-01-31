#include <stdio.h>
#include <cuda_runtime.h>
#include <cuda.h>
#include <cstdio>

#define THREADS_PER_WARP 32
#define WARPS_PER_CTA 32
#define DEFAULT_CTAS 10
#define DEFAULT_NREPS 10

__managed__ uint32_t global_sum;

///////////////////////////////////////////////////////////////////////////////
// The is the core function of this program. 
///////////////////////////////////////////////////////////////////////////////
__global__ void simple_subtract(int nreps)
{
	int local_sum = 0; 
	for (int i=0; i<nreps; i++) {
		local_sum += 1;
	}
	atomicSub(&global_sum, local_sum);
}

///////////////////////////////////////////////////////////////////////////////
// This is a wrapper to call the simple_subtract.
///////////////////////////////////////////////////////////////////////////////
void simple_subtract_wrapper(int ctas, int nreps)
{
	dim3 block(WARPS_PER_CTA * THREADS_PER_WARP, 1);
	dim3 grid(ctas, 1);
	cudaDeviceSynchronize(); 
	simple_subtract<<<grid,block,0>>>(nreps);
	cudaDeviceSynchronize(); 
	cudaError_t error = cudaGetLastError(); 
	if (error != cudaSuccess) {
		printf("Error: kernel failed %s\n", cudaGetErrorString(error));
	}
}

int main(int argc, char *argv[])
{
	setbuf(stdout, NULL); // Disable stdout buffering
	
	//Set the device
	int device = 0;
	cudaSetDevice(device);
	cudaDeviceProp cudaDevicePropForChoosing;
	cudaGetDeviceProperties(&cudaDevicePropForChoosing, device);
	printf("Device %d (%s) is being used\n", device, cudaDevicePropForChoosing.name);
	printf("memory: %.4f GB %s %d SMs x%d\n", 
		cudaDevicePropForChoosing.totalGlobalMem/(1024.f*1024.f*1024.f), 
		(cudaDevicePropForChoosing.ECCEnabled)?"ECC on":"ECC off", 
		cudaDevicePropForChoosing.multiProcessorCount, 
		cudaDevicePropForChoosing.clockRate);
	
	int nreps = DEFAULT_NREPS;
	int ctas = DEFAULT_CTAS;
	printf("#CTAs=%d, nreps=%d, threads/CTA=%d\n", ctas, nreps, THREADS_PER_WARP*WARPS_PER_CTA);
	
	// Initialize to a large value so subtraction doesn't underflow
	global_sum = 1000000; 
	printf("Initial global sum = %d\n", global_sum);
	
	// Call the main function now
	simple_subtract_wrapper(ctas, nreps);
	
	printf("Final global sum = %d\n", global_sum);
	printf("Amount subtracted = %d\n", 1000000 - global_sum); 
	
	return 0;
}