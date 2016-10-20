
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-7.0-cudnnv2/lib64"
export CUDA_HOME=/usr/local/cuda-7.0-cudnnv2
