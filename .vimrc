set nocp
" setting FF type
set ff=unix
set laststatus=2

"set leader
let mapleader="\\"
"run pylint
nnoremap <leader>] :!pylint %<CR>
nnoremap <leader>e :!pylint -E %<CR>

"set foldmethod=indent
set foldlevel=-1
"set noexpandtab
set tabstop=4
set shiftwidth=4
"set expandtab
colorscheme torte

"call pathogen#infect()
syntax on
filetype plugin indent on
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on

"line number
set number

"set spell check
set spell

"au FileType python set omnifunc=pythoncomplete"Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <c-n> :NERDTreeToggle<CR>
map <c-g> :GundoToggle<CR>
"searching
map <leader>a: Ack!

"goto definition
let g:jedi#goto_definitions_command = "<leader>g"

"hilight cursor col
set colorcolumn=80 "limit 80 cols 
highlight colorcolumn ctermbg=white ctermfg=black
set cursorcolumn
highlight CursorColumn ctermbg=red
"highlight searched word
set hlsearch
"no need! set cursorline
"

func StripTrailingWS()
	%s/\s\+$//ge
endfunc

noremap <leader>w :call StripTrailingWS()<CR>

" put license, authorname (myname) :D in newly created Js files

"autocmd! BufNewFile *.js
"      \ exe "normal O/*\rCoffee - Collaborative Online File Editor.".
"	  \ "\r\rDate: " . strftime("%B %d %Y").
"	  \ "\rAuthor: Akash Shende <akash@anoosmar.com>"
"	  \ "\r\rCopyright (c) 2015 Vaultize"
"      \ "\r\r/\r\r"

autocmd! BufNewFile *.robot
			\ exe "normal O# -*- coding: robot -*-".
			\ "\n\n*** Settings ***".
			\ "\nLibrary      Selenium2Library     15".
			\ "\nResource     ../env/local/vars/global.txt".
			\ "\r\r".
			\ "*** Variables ***\r\r".
			\ "*** Keywords ***\r"

autocmd FileType python setlocal noet sw=4 ts=4 
set viminfo='20,<1000,s1000
