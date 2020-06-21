"----------- Platform Specific ---------
let s:bashrc="~/.bashrc"
let s:python="python"

if has('mac')
    let s:bashrc="~/.bash_profile"
endif
if executable("python3")
    let s:python="python3"
endif

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

func OpenConfigFile(switch)
    if a:switch ==? "bash"
        execute "tabedit " . s:bashrc
    elseif a:switch ==? "vim"
        execute "tabedit $MYVIMRC"
    else
        echo "Wrong choice."
    endif
endfunc

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function ToggleLineNumber()
    execute "set number!"
    execute "set relativenumber!"
endfunction

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
set noshowmode    "hide current Vim mode; will be available in lightlin
"----------- Plugins --------------
call InstallVimPlug()
call plug#begin('~/.vim/plugins')
Plug 'gruvbox-community/gruvbox'
" LSP configs
":CocInstall coc-tsserver coc-python coc-json coc-java coc-clangd
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
"Plug 'kien/ctrlp'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-wombat-scheme'
Plug 'tpope/vim-fugitive'
call plug#end()

"---------- Appearance ----------
set laststatus=2 "show filename in status bar
colorscheme wombat
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
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Git diff %<CR>
nnoremap <leader>gc :Git commit %<CR>
map <silent><F3> :call ToggleLineNumber()<CR>
execute "noremap <silent><leader>t :botright terminal ++close ++rows=10 bash --rcfile ".s:bashrc."<CR>"
execute "noremap <silent><leader>p :botright terminal ++close ++rows=10 ".s:python."<CR>"
map <C-n> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>

command! -nargs=1 Config :call OpenConfigFile(<f-args>)
command! -nargs=0 Reload :source $MYVIMRC

"----------- FZF ------------
if executable('ag')
    set grepprg='ag\ --nocolor\ --nogroup'
    let $FZF_DEFAULT_COMMAND='ag --literal --files-with-matches --nocolor -g ""'
    let $FZF_DEFAULT_OPTS="--height 100% --layout=reverse --border --info=inline"
endif

"----------- On Startup -----------
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
"
"----------- CoC vim Configs ----------
"
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-java', 'coc-python', 'coc-clangd']
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=number

"--- use <TAB> to trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


