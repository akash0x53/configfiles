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
set expandtab
colorscheme desert

"call pathogen#infect()
syntax on
filetype plugin indent on
call pathogen#infect()
"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on

"line number
set number

"set spell check
"set spell

"au FileType python set omnifunc=pythoncomplete"Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <c-n> :NERDTreeToggle<CR>
let g:NERDTreeNodeDelimiter="\t"
map <c-g> :GundoToggle<CR>
"searching
map <leader>a: Ack!

"goto definition
let g:jedi#goto_definitions_command = "<leader>g"

"hilight cursor col
set t_Co=256
set colorcolumn=80 "limit 80 cols
set hlsearch
highlight Search ctermbg=yellow ctermfg=black
highlight ColorColumn ctermfg=white

func StripTrailingWS()
	%s/\s\+$//ge
endfunc

noremap <leader>w :call StripTrailingWS()<CR>


autocmd FileType python setlocal et sw=4 ts=4
set viminfo='20,<1000,s1000

" for Mac only
set backspace=indent,eol,start
