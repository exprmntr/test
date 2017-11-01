#pragma once

#include <catboost/cuda/cuda_lib/kernel/kernel.cuh>

namespace NKernel {

    void CrossEntropyTargetKernel(const float* targetClasses, const float* targetWeights, ui32 size,
                                  const float* predictions,
                                  float* functionValue, float* der, float* der2,
                                  float border, bool useBorder,
                                  TCudaStream stream);


    void MseTargetKernel(const float* relevs, const float* weights, ui32 size,
                         const float* predictions,
                         float* functionValue, float* der, float* der2,
                         TCudaStream stream);
}
