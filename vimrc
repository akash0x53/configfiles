"----------- Functions -----------
func TrimTrailingWhiteSpaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunc

func InstallVimPlug()
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endfunc

"---------- Basic ----------
set nocompatible
set noswapfile    "disable ugly .swp files
set history=1000
set scrolloff=2   "number of screen lines below/above cursor while scrolling
set undodir=~/.vim/undodir
set undofile
set fileformat=unix
set showcmd       "show command at bottom bar
set lazyredraw
set showmatch     "show matching parenthesis or similar

"----------- Plugins --------------
call InstallVimPlug()
call plug#begin('~/.vim/plugins')
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
"Plug 'kien/ctrlp'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

"---------- Appearance ----------
set laststatus=2 "show filename in status bar
colorscheme gruvbox
set background=dark
set colorcolumn=80
highlight ColorColumn ctermbg=0 "80 column color
set linebreak
"set cursorcolumn  "highlight column where cursor is
"set cursorline "highlight line under the cursor

"---------- Line Number ----------
set numberwidth=3 "required for showing line & relative line number
set relativenumber "show relative line number
set number
set ruler "status line
set rulerformat=%l,%c%V

"---------- Indentation -----------
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set softtabstop=4 "remove tab by backspace even expandtab set

"tab-spaces visualisation
set list
set listchars=tab:>·,trail:·
set textwidth=79 "wrap after 79 char

filetype indent on "load file type specific indent files from ~/.vim/indent/XXX.vim

"---------- Code Formatting ---------
syntax on
set filetype=on

"---------- Searching ------------
set incsearch "incremental search
set ignorecase "ignore case-sensitivity
set smartcase "switch to case-sensitive on Upper case char
set hlsearch

"----------- Mapping -------------
let mapleader = ","
nnoremap <leader>e :!pylint -E %<CR>
noremap  <leader>w :call TrimTrailingWhiteSpaces()<CR>
noremap <leader><space> :nohl<CR>
if has('mac') 
    noremap <leader>t :botright terminal ++close ++rows=10 bash --rcfile ~/.bash_profile<CR>
else
    noremap <leader>t :botright terminal ++close ++rows=10 bash --rcfile ~/.bashrc<CR>
endif
noremap <leader>p :botright terminal ++close ++rows=10 python<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>

"----------- On Startup -----------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
