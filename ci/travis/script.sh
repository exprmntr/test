#!/bin/bash -ex

function install_cuda_linux()
{
    wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64-deb -O cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1404-8-0-local-ga2_8.0.61-1_amd64.deb
    sudo apt-get update
    sudo apt-get install cuda    
}

function install_cuda_darwin()
{
    if [ -f $HOME/.ya/cuda_8.0.61_mac.dmg ]; then
        rm $HOME/.ya/cuda_8.0.61_mac.dmg
    fi
    if [ $(openssl dgst -md5 -hex $HOME/.ya/cuda_9.0.176_mac.dmg | awk '{print $2;}') != 19369a391a7475cace0f3c377aebbecb ]; then
        rm $HOME/.ya/cuda_9.0.176_mac.dmg
    fi
    
    if [ ! -f $HOME/.ya/cuda_9.0.176_mac.dmg ]; then
        wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_mac-dmg -c -O cuda_9.0.176_mac.dmg
        if [ $(openssl dgst -md5 -hex cuda_9.0.176_mac.dmg | awk '{print $2;}') == 19369a391a7475cace0f3c377aebbecb ]; then
           mv cuda_9.0.176_mac.dmg $HOME/.ya/cuda_9.0.176_mac.dmg
        else
           exit 1
        fi
    fi
    hdiutil attach $HOME/.ya/cuda_9.0.176_mac.dmg
    sudo /Volumes/CUDAMacOSXInstaller//CUDAMacOSXInstaller.app/Contents/MacOS/CUDAMacOSXInstaller --accept-eula --no-window
    # exit 0  # XXX
}

if [ "${CB_BUILD_AGENT}" == 'clang-linux-x86_64-release-cuda' ]; then
    install_cuda_linux;
    ./ya make --stat -T -r -j 1 catboost/cuda/app -DCUDA_ROOT=/usr/local/cuda-8.0;
    cp $(readlink -f catboost/cuda/app/cb_cuda) catboost-cuda-linux;
fi


if [ "${CB_BUILD_AGENT}" == 'clang-linux-x86_64-release' ]; then
    ./ya make --stat -T -r -j 1 catboost/app;
    cp $(readlink -f catboost/app/catboost) catboost-linux;
fi

if [ "${CB_BUILD_AGENT}" == 'python2-linux-x86_64-release' ]; then
     install_cuda_linux;
     cd catboost/python-package;
     python2 ./mk_wheel.py -T -j 1 -DCUDA_ROOT=/usr/local/cuda-8.0;
fi

if [ "${CB_BUILD_AGENT}" == 'python35-linux-x86_64-release' ]; then
     install_cuda_linux;
     cd catboost/python-package;
     python3 ./mk_wheel.py -T -j 1 -DCUDA_ROOT=/usr/local/cuda-8.0;
fi

if [ "${CB_BUILD_AGENT}" == 'python36-linux-x86_64-release' ]; then
     install_cuda_linux;
     cd catboost/python-package;
     python3 ./mk_wheel.py -T -j 1 -DCUDA_ROOT=/usr/local/cuda-8.0;
fi

if [ "${CB_BUILD_AGENT}" == 'clang-darwin-x86_64-release' ]; then
    ./ya make --stat -T -r -j 2 catboost/app;
    cp $(readlink catboost/app/catboost) catboost-darwin;
fi

if [ "${CB_BUILD_AGENT}" == 'clang-darwin-x86_64-release-cuda' ]; then
    install_cuda_darwin;
    ./ya make --stat -T -r -j 2 catboost/cuda/app -DCUDA_ROOT=/usr/local/cuda;
    cp $(readlink catboost/cuda/app/catboost) catboost-cuda-darwin;
fi

if [ "${CB_BUILD_AGENT}" == 'python2-darwin-x86_64-release' ]; then
     install_cuda_darwin;
     cd catboost/python-package;
     python2.7 ./mk_wheel.py -T -j 2 -DCUDA_ROOT=/usr/local/cuda;
fi

if [ "${CB_BUILD_AGENT}" == 'python35-darwin-x86_64-release' ]; then
     install_cuda_darwin;
     pyenv install 3.5.2;
     cd catboost/python-package;
     $HOME/.pyenv/versions/3.5.2/bin/python3.5 ./mk_wheel.py -T -j 2 -DCUDA_ROOT=/usr/local/cuda -DPYTHON_CONFIG=$HOME/.pyenv/versions/3.5.2/bin/python3-config;
fi

if [ "${CB_BUILD_AGENT}" == 'python36-darwin-x86_64-release' ]; then
     install_cuda_darwin;
     cd catboost/python-package;
     pyenv install 3.6.3;
     $HOME/.pyenv/versions/3.6.3/bin/python3.6 ./mk_wheel.py -T -j 2 -DCUDA_ROOT=/usr/local/cuda -DPYTHON_CONFIG=$HOME/.pyenv/versions/3.6.3/bin/python3-config;
fi

