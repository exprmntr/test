#pragma once

#include <catboost/libs/algo/train_model.h>

TFullModel TrainFloatCatboostModel() {
    TPool pool;
    pool.Docs.Resize(/*doc count*/3, /*factors count*/ 3, /*baseline dimension*/ 0);
    pool.Docs.Factors[0] = {+0.5f, +1.5f, -2.5f};
    pool.Docs.Factors[1] = {+0.7f, +6.4f, +2.4f};
    pool.Docs.Factors[2] = {-2.0f, -1.0f, +6.0f};
    pool.Docs.Target = {1.0f, 0.0f, 0.2f};

    TFullModel model;
    yvector<yvector<double>> testApprox;
    NJson::TJsonValue params;
    params.InsertValue("iterations", 5);
    TrainModel(params, Nothing(), Nothing(), pool, false, pool, "", &model, &testApprox);

    return model;
}
