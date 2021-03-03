# sudo needed
# docker :  https://docs.docker.com/install/linux/docker-ce/ubuntu/
# nvidia container toolkit https://github.com/NVIDIA/nvidia-docker
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock
## apt-install
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install tmux zsh curl vim neovim ctags
