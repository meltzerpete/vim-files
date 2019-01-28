nnoremap [24;5~ :vsplit ~/.vim/ftplugin/markdown.vim<CR>
let g:markdown_folding = 0
set foldlevel=0


function! Comp(regex)
	echom a:regex
        echom system("~/Dropbox/notes/extractor.sh -v -c -r '" . a:regex . "' " . bufname("%"))
endfunction

function! Compo(regex)
	echom a:regex
        echom system("~/Dropbox/notes/extractor.sh -r '" . a:regex . "' " . bufname("%"))
endfunction

nnoremap <leader>lo :w !pandoc -o %:r.pdf<CR>:!xdg-open %:r.pdf &> /dev/null<CR><CR>
xnoremap <leader>lo :'<,'>:w !pandoc -o %:r.pdf<CR>:!xdg-open %:r.pdf &> /dev/null<CR><CR>

nnoremap <leader>lc :w !pandoc -o %:r.pdf<CR><CR>
xnoremap <leader>lc :'<,'>:w !pandoc -o %:r.pdf<CR><CR>

" # date (notes)
nnoremap <F5> :put =strftime('# %d/%m/%Y ')<CR>A
inoremap <F5> <ESC>:put =strftime('# %d/%m/%Y ')<CR>A

