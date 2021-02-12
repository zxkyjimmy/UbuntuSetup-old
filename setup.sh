#! /usr/bin/bash
set -euo pipefail

function step(){
  echo "$(tput setaf 10)$1$(tput sgr0)"
}

step "Configuring git"
git config --global user.name "Yen-Chi Chen"
git config --global user.email "zxkyjimmy@gmail.com"

step "Get useful commands"
sudo apt update
sudo apt install -y git curl zsh wget htop vim tree openssh-server lm-sensros \
                    python3-pip python-is-python3

step "Get oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

step "clean up"
sudo apt update
sudo apt upgrade
sudo apt autoremove -y
sudo apt autoclean
sudo chsh -s /usr/bin/zsh ${USER}
cp .p10k.zsh .zshrc ${HOME}/

step "Enter zsh"
zsh

step "Get conda"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
eval "$(${HOME}/miniconda/bin/conda shell.zsh hook)"
conda init
conda config --set auto_activate_base false

step "Get CUDA"
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt update
sudo apt install -y cuda-11-2
sudo apt install -y libcudnn8 libcudnn8-dev
