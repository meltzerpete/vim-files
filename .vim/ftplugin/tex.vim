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

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape -synctex=1 -src-specials -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'okular --unique'
function! SyncTexForward()
	let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
	let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
	exec execstr
endfunction
nnoremap <Leader>f :call SyncTexForward()<CR>

