set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'tmhedberg/SimpylFold'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
syntax on


" searching
set ignorecase smartcase hls incsearch
nnoremap <F7> :let @/ = ""<CR>

" mouse mode
set mouse=a

" spell check
set spelllang=en_gb spell
set spellfile=/home/pete/Dropbox/vim/spell/en.utf-8.add
set nospell
nnoremap <F3> :set spell! spell?<CR>
inoremap <F3> <ESC>:set spell! spell?<CR>a

" paste mode
nnoremap <F2> :set paste! paste?<CR>
inoremap <F2> <ESC>:set paste! paste?<CR>a

" auto complete:
" - word in file
"imap <TAB> <C-N>
" - file path
imap <S-TAB> <C-X><C-F>

" VIM + TMUX
" vim splits
nnoremap j <C-W><C-J>
nnoremap k <C-W><C-K>
nnoremap l <C-W><C-L>
nnoremap h <C-W><C-H>

set splitbelow
set splitright

nnoremap <F12> :vsplit ~/.vimrc<CR>

" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'tex', 'sql']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

command CDC cd %:p:h
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

