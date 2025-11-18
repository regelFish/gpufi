#include <stdint.h>

__global__ void mul2(float* a) {
    
    int i = threadIdx.x;
    a[i] = a[i] * 2.0f;
    
}

int main() {
    
    const uint16_t N = 4;
    float h_a[N] = {1, 2, 3, 4};

    float* d_a;
    cudaMalloc(&d_a, N * sizeof(float));
    cudaMemcpy(d_a, h_a, N * sizeof(float), cudaMemcpyHostToDevice);

    mul2<<<1, N>>>(d_a);

    cudaMemcpy(h_a, d_a, N * sizeof(float), cudaMemcpyDeviceToHost);
    cudaFree(d_a);

    return 0;


}
