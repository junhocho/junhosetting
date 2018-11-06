cd
wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh
bash Anaconda3-5.1.0-Linux-x86_64.sh

echo 'export PATH="/home/junho/anaconda3/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

conda install pytorch torchvision -c pytorch


