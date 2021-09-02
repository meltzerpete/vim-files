#!/bin/bash

# create symbolic links
dir=`pwd`
cd ~
ln -s ${dir}/.vim
ln -s ${dir}/.vimrc

echo You may need to run the following command:
echo git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

