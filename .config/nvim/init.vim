set runtimepath+=/usr/share/vim/vimfiles

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'rust-lang/rust.vim'
" Plug 'autozimu/LanguageClient-neovim', {'branch':'next', 'do':'./install.sh'}

Plug 'twinside/vim-haskellfold'

Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

colorscheme dracula
set termguicolors

syntax on
set background=dark
set mouse=a
set number
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set foldmethod=syntax

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'dracula'
let g:airline_minimalist_showmod = 1

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" ALE and Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {
    \   'rust': ['ale', 'racer'],
    \   'haskell': ['ale'],
    \}
let g:deoplete#sources#rust#rust_source_path = 
    \'~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

let g:ale_fixers = {
    \   'rust': ['rustfmt'],
    \}
let g:ale_haskell_hie_executable = 'hie-wrapper'
let g:ale_linters = {
    \   'rust': ['rls'],
    \   'haskell': ['stack-build', 'hie'],
    \}
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" let g:ale_rust_rls_toolchain = 'nightly-YYYY-MM-DD'
let g:ale_rust_rls_config = {
    \   'rust': {'clippy_preference': 'on'}
    \}
