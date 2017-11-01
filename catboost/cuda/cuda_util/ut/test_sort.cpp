#include <catboost/cuda/cuda_util/sort.h>
#include <catboost/cuda/cuda_util/cpu_random.h>
#include <library/unittest/registar.h>
#include <iostream>
#include <catboost/cuda/cuda_util/dot_product.h>
#include <catboost/cuda/cuda_lib/cuda_profiler.h>
using namespace std;
using namespace NCudaLib;

SIMPLE_UNIT_TEST_SUITE(TSortTest) {
    SIMPLE_UNIT_TEST(TestSort) {
        StartCudaManager();
        {
            ui64 tries = 20;
            TRandom rand(0);
            for (ui32 k = 0; k < tries; ++k) {
                yvector<float> vec;
                ui64 size = rand.NextUniformL() % 10000000;
                for (ui64 i = 0; i < size; ++i) {
                    vec.push_back(rand.NextUniform());
                }

                auto mapping = TStripeMapping::SplitBetweenDevices(size);
                auto cVec = TStripeBuffer<float>::Create(mapping);
                cVec.Write(vec);

                RadixSort(cVec);

                yvector<float> result;
                cVec.Read(result);

                for (ui32 dev : cVec.NonEmptyDevices()) {
                    const auto slice = mapping.DeviceSlice(dev);

                    for (auto i = slice.Left + 1; i < slice.Right; ++i) {
                        UNIT_ASSERT_VALUES_EQUAL(result[i - 1] <= result[i], true);
                    }
                }
            }
        }
        StopCudaManager();
    }

    SIMPLE_UNIT_TEST(TestSortWithLinked) {
        StartCudaManager();
        {
            ui64 tries = 20;
            TRandom rand(0);
            for (ui32 k = 0; k < tries; ++k) {
                yvector<float> vec;
                ui64 size = rand.NextUniformL() % 10000000;
                for (ui64 i = 0; i < size; ++i) {
                    vec.push_back(rand.NextUniform());
                }

                auto mapping = TStripeMapping::SplitBetweenDevices(size);
                auto cVec = TStripeBuffer<float>::Create(mapping);
                auto cVecLinked = TStripeBuffer<float>::Create(mapping);
                cVec.Write(vec);
                cVecLinked.Write(vec);

                RadixSort(cVec, cVecLinked);

                yvector<float> result;
                yvector<float> result2;
                cVec.Read(result);
                cVecLinked.Read(result2);

                for (ui32 dev : cVec.NonEmptyDevices()) {
                    const auto slice = mapping.DeviceSlice(dev);

                    for (auto i = slice.Left + 1; i < slice.Right; ++i) {
                        UNIT_ASSERT_VALUES_EQUAL(result[i - 1] <= result[i], true);
                        UNIT_ASSERT_VALUES_EQUAL(result2[i - 1] <= result2[i], true);
                    }
                }
            }
        }
        StopCudaManager();
    }

    SIMPLE_UNIT_TEST(TestSortWithExternalBuffer) {
        StartCudaManager();
        {
            ui64 tries = 20;
            TRandom rand(0);
            for (ui32 k = 0; k < tries; ++k) {
                yvector<float> vec;
                ui64 size = rand.NextUniformL() % 10000000;
                for (ui64 i = 0; i < size; ++i) {
                    vec.push_back(rand.NextUniform());
                }

                auto mapping = TStripeMapping::SplitBetweenDevices(size);

                auto cVec = TStripeBuffer<float>::Create(mapping);
                auto cVecLinked = TStripeBuffer<float>::Create(mapping);

                auto tmp1 = TStripeBuffer<float>::Create(mapping);
                auto tmp2 = TStripeBuffer<float>::Create(mapping);

                cVec.Write(vec);
                cVecLinked.Write(vec);

                RadixSort(cVec, cVecLinked, tmp1, tmp2);

                yvector<float> result;
                yvector<float> result2;
                cVec.Read(result);
                cVecLinked.Read(result2);

                for (ui32 dev : cVec.NonEmptyDevices()) {
                    const auto slice = mapping.DeviceSlice(dev);

                    for (auto i = slice.Left + 1; i < slice.Right; ++i) {
                        UNIT_ASSERT_VALUES_EQUAL(result[i - 1] <= result[i], true);
                        UNIT_ASSERT_VALUES_EQUAL(result2[i - 1] <= result2[i], true);
                    }
                }
            }
        }
        StopCudaManager();
    }

    SIMPLE_UNIT_TEST(TestSortPerformance) {
        StartCudaManager();
        {
            ui64 tries = 20;
            TRandom rand(0);
            auto& profiler = NCudaLib::GetCudaManager().GetProfiler();
            SetDefaultProfileMode(EProfileMode::ImplicitLabelSync);

            for (ui32 size = 100; size < 10000001; size *= 10) {
                for (ui32 k = 0; k < tries; ++k) {
                    yvector<float> vec;
                    for (ui64 i = 0; i < size; ++i) {
                        vec.push_back(rand.NextUniform());
                    }

                    auto mapping = TSingleMapping(0, size);
                    auto cVec = TSingleBuffer<float>::Create(mapping);
                    cVec.Write(vec);
                    {
                        auto guard = profiler.Profile(TStringBuilder() << "Sort #" << size << " elements");
                        RadixSort(cVec);
                    }

                    yvector<float> result;
                    cVec.Read(result);
                }
            }
        }
        StopCudaManager();
    }
}
