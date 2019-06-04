" Markdown
" ========
"
" <F4>     insert new entry (# DD/MM/YYYY ...)
"
" <C-L>    markdown hyperlink
" <C-P>    markdown image
" <C-F>    latex include centered graphics
" <C-T>    insert tex code block (compiled as tex)
"
" <SPACE>  alternate current fold
"
" <LEADER>:
"   
"   lo     compile full file/selection and open output pdf
"   lc     compile full file/selection
"
"   <SPACE>  jumpy to last diary entry and unfold with todos
"
" Functions:
"
"   Comp(REGEX)         concat and compile all entries with headings matching
"                       REGEX to pdf
"
"   Compo(REGEX)        same as Comp(REGEX) but open pdf in viewer
"
"   CompoHTML(REGEX)    concat and compile all entries with headings matching
"                       REGEX to html, and open in browser
"
" Extra:
"   sets position for diary.md
"

nnoremap [24;5~ :vsplit ~/.vim/ftplugin/markdown.vim<CR>
let g:markdown_folding = 0
set foldlevel=0

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    " syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    "" hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

function! Comp(regex)
	echom a:regex
        echom system("~/Dropbox/notes/extractor.sh -v -c -r '" . a:regex . "' " . bufname("%"))
endfunction

nnoremap [15;2~ :!xdg-open out.pdf &> /dev/null<CR><CR>

function! Compo(regex)
	echom a:regex
        echom system("~/Dropbox/notes/extractor.sh -r '" . a:regex . "' " . bufname("%"))
endfunction

function! CompoHTML(regex)
	echom a:regex
        echom system("~/Dropbox/notes/extractor-html.sh -r '" . a:regex . "' " . bufname("%"))
endfunction

nnoremap <leader>lo :w !pandoc -o %:r.pdf<CR>:!xdg-open %:r.pdf &> /dev/null<CR><CR>
xnoremap <leader>lo :'<,'>:w !pandoc -o %:r.pdf<CR>:!xdg-open %:r.pdf &> /dev/null<CR><CR>

nnoremap <leader>lc :w !pandoc -o %:r.pdf<CR><CR>
xnoremap <leader>lc :'<,'>:w !pandoc -o %:r.pdf<CR><CR>

" # date (diary)
nnoremap <F4> :put =strftime('# %d/%m/%Y ')<CR>A
inoremap <F4> <ESC>:put =strftime('# %d/%m/%Y ')<CR>A

" jump to last entry and unfold with todos (diary)
nnoremap <leader><SPACE> Gzo{{zo}}{{


" some markdown shortcuts
" include tex (to be compiled)
inoremap  ```tex<CR><CR>```<ESC>ki
" link
inoremap  [<+text+>](<+link+>)<ESC>5bi
" figure (latex)
inoremap  ```tex<CR>\begin{center}<CR>\includegraphics[]{}<CR>\end{center}<CR>```<ESC>kkA<ESC>i
" image (markdown)
inoremap <C-P> ![<+caption+>](<+path+>)<ESC>5bi

" alternate folding with space bar
nnoremap <SPACE> za


" Fix bug in markdown folding for # inside code block
fun! SyntaxFix()
	setlocal foldmethod=syntax
	syn region mkdHeaderFold
	      \ start="^\s*\z(#\+\)"
	      \ skip="^\s*\z1#\+"
	      \ end="^\(\s*#\)\@="
	      \ fold contains=TOP
endfun

autocmd FileType markdown call SyntaxFix()

