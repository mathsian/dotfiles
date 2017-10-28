echo ".cfg" >> .gitignore
git clone --bare https://github.com/mathsian/dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
