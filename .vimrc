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
Plugin 'christoomey/vim-tmux-navigator'

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

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash


" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_UseMakefile = 0

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape -synctex=1 -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'okular --unique'
function! SyncTexForward()
	let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
	let execstr = "silent !okular --unique".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
	exec execstr
endfunction
nnoremap <Leader>f :call SyncTexForward()<CR>

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

" paste mode
nnoremap <F2> :set paste! paste?<CR>

" date underlined (notes)
nnoremap <F5> :put =strftime('%d/%m/%Y')<CR>:put ='=========='<CR>:put =''<CR>:put =''<CR>

" auto complete
imap <TAB> <C-N>
imap <S-TAB> <C-X><C-F>


" VIM + TMUX
" vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

nnoremap <F12> :vsplit ~/.vimrc<CR>

" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

