luarocks install torch
luarocks install nn
luarocks install image
luarocks install lua-cjson
luarocks install https://raw.githubusercontent.com/qassemoquab/stnbhwd/master/stnbhwd-scm-1.rockspec
luarocks install --server=http://luarocks.org/dev torch-rnn

export CUDA_BIN_PATH=/usr/local/cuda-7.5-cudnnv5
export CUDNN_PATH=/usr/local/cuda-7.5-cudnnv5/lib64/libcudnn.so.5.0.5

luarocks install cutorch
luarocks install cunn
luarocks install cudnn
