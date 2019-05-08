nnoremap [24;5~ :vsplit ~/.vim/ftplugin/tex.vim<CR>

" Enable ALT key macros (VimLatex)
let g:Tex_AdvancedMath = 1
set winaltkeys=no

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_UseMakefile = 0
let g:Tex_GotoError = 0

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape -synctex=1 -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'okular --unique'
function! SyncTexForward()
	let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
	let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
	exec execstr
endfunction
nnoremap <Leader>f :call SyncTexForward()<CR>

function! Compile()
  let s:mainFile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r")
  let execstr = "!pdflatex -shell-escape -synctex=1 -src-specials -interaction=nonstopmode ".s:mainFile.".tex"
  exec execstr
endfunction

function! Bib()
  let s:mainFile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r")
  let execstr = "!bibtex ".s:mainFile
  exec execstr
endfunction

" <F5> compile, <F6> compile with bib
nnoremap [15~ :w<CR>:call Compile()<CR>
nnoremap [17~ :w<CR>:call Compile()<CR> :call Bib()<CR> :call Compile()<CR> :call Compile()<CR>
