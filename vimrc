" Required vim 9

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""Plugins"""""""""""""""""""""""""""""""""""'""""""""""""""
call plug#begin('~/.vim/bundle')

" Match delimiter
Plug 'Raimondi/delimitMate'
" Disable ` quote for systemverilog/verilog
au FileType verilog,systemverilog let b:delimitMate_quotes = "\"" 

" File list
Plug 'scrooloose/nerdtree'
" Shortkey Map
map <C-n> :NERDTreeToggle<CR>
" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Remeber last position when reopen
Plug 'farmergreg/vim-lastplace'
" Remember last position when reopen
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g `\"" | endif
endif

" Commenter
Plug 'scrooloose/nerdcommenter'

" Colorscheme Pack
Plug 'rafi/awesome-vim-colorschemes'
Plug 'folke/tokyonight.nvim'
Plug 'arzg/vim-colors-xcode'

" Statusline Plugin
Plug 'vim-airline/vim-airline'

" Snippet Plugin
Plug 'honza/vim-snippets'

" LaTex Plugin
let g:tex_flavor='latex'
Plug 'vim-latex/vim-latex', {'for': 'tex'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Verilog plugin
Plug 'HonkW93/automatic-verilog', {'for': ['verilog', 'systemverilog']}
" AutoInst
let g:atv_autoinst_st_pos = 0
let g:atv_autoinst_io_dir = 0
let g:atv_autoinst_keep_chg = 1
let g:atv_crossdir_mode = 1
"0:normal 1:filelist 2:tags"
let g:atv_crossdir_flist_browse=0
let g:atv_crossdir_tags_browse = 0
let g:atv_autoinst_incl_width = 0
let g:atv_autoinst_95_support = 1
let g:atv_autoinst_incl_cmnt = 0
map <Leader>atic :call AutoInst(0)<ESC>
map <Leader>atia :call AutoInst(1)<ESC>

" Fuzzy search
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
" Enable popup mode
let g:Lf_WindowPosition='popup'
" Show icons
let g:Lf_ShowDevIcons=1
let g:Lf_ShortcutF="<leader>ff"
noremap <unique> <leader>fr :Leaderf rg --live<cr>
noremap <unique> <leader>frc :Leaderf rg --live --cword<cr>

"" Autoformat
"Plug 'sbdchd/neoformat'
"augroup fmt
    "autocmd!
    "autocmd BufWritePre * undojoin | Neoformat
"augroup END

" List key mappings
Plug 'liuchengxu/vim-which-key'

" Doxygen Plugin
Plug 'vim-scripts/DoxygenToolkit.vim'

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""Plugins End"""""""""""""""""""""""""""""""'""""""""""""""

set t_Co=256
set background=dark
"colorscheme gruvbox
colorscheme xcode
set termguicolors

syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set ruler
set hlsearch
filetype plugin indent on
set backspace=indent,eol,start

" make sure there are at least some lines below and above current cursor
set scrolloff=5

" spell check
" TODO: Needs to be debugged
au BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.md setlocal spelllang=en
au BufRead,BufNewFile *.md setlocal spellfile=$HOME/.vim/spell/en.utf-8.add

" Maintain undo history between sessions
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undofile
set undodir=~/.vim/undodir

" Insert single word and back to normal mode
nnoremap <C-i> i <ESC>r

" Map <ESC> key to jk and kj
inoremap jk <ESC>
inoremap kj <ESC>

" Filetype configuration of unrecognized file types
au BufRead,BufNewFile *.vh set filetype=verilog
au BufRead,BufNewFile *.v set filetype=verilog
au BufRead,BufNewFile *.do set filetype=tcl

"" Format options
"au BufRead,BufNewFile *.sv set fo-=cro
"au BufRead,BufNewFile *.v set fo-=cro
"au BufRead,BufNewFile *.py set fo+=cro

" Disable copy line when deleting
noremap <Leader>d "_dd

"""""""""""""""""""""""""' Coc.nvim Configuration""""""""""""""""""""""""""
" Set internal encoding of vim, not needed on neovim, since coc.nvim using
" some unicode characters in the file autoload/float.vim
set encoding=utf-8

"" TxtEdit might fail if hidden is not set
"set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

"" Give more space for displaying messages
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Done pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
set tagfunc=CocTagFunc
"""""""""""""""""""""""""' Coc.nvim Configuration""""""""""""""""""""""""""

"""""""""""""""""""""""""' Coc Snippets Configuration""""""""""""""""""""""""""
" Use <C-f> for trigger snippet expand
imap <C-f> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet
vmap <C-j> <Plug>(coc-snippets-select)

nnoremap <leader>f <Plug>(coc-fix-current)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
"""""""""""""""""""""""""' Coc Snippets Configuration End""""""""""""""""""""""

" Must have Coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-snippets', 'coc-pyright']

""""""""""""""""""""""gopls configuration"""""""""""""""""""""""""
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <leader>ft :call CocAction('format')<CR>
