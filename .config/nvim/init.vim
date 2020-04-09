" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

call plug#begin()

" Utilities
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-fugitive'

" UI
" Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'

" Linter
Plug 'dense-analysis/ale'

" Auto complete
Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
Plug 'nixprime/cpsm'
Plug 'deoplete-plugins/deoplete-jedi', {'for': 'python'}
Plug 'deoplete-plugins/deoplete-clang', {'for': ['c', 'cpp']}
Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'}

" Haskell
Plug 'twinside/vim-haskellfold', {'for': 'haskell'}

" Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" fzf
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Set up python
let g:python3_host_prog = '/usr/bin/python'

" Global conf
syntax on
set number
set mouse=a
set softtabstop=-1 " Use shiftwidth value
set shiftwidth=0 
set tabstop=4
set expandtab
set smarttab
set autoindent
set hidden  " allow non written buffer to be hidden
let mapleader = ';'

" UI
" let g:dracula_colorterm = 0
colorscheme nord
set background=dark
let g:airline_theme = 'nord'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Deoplete
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {
    \   'rust': ['ale', 'racer'],
    \   'haskell': ['ale'],
    \}
let g:deoplete#sources#rust#rust_source_path = 
    \'/home/tchamelot/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#racer_binary='/home/tchamelot/.cargo/bin/racer'

" Setup fuzzy finder
call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
call deoplete#custom#source('_', 'sorters', [])

" ALE
let g:ale_shell = '/bin/sh'
let g:ale_fixers = {
    \   'rust': ['rustfmt'],
    \}
let g:ale_linters = {
    \   'rust': ['rls'],
    \   'haskell': ['stack-build', 'hie'],
    \   'cpp': ['clang', 'clangcheck']
    \}
let g:ale_fix_on_save = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_haskell_hie_executable = 'hie-wrapper'
let g:ale_rust_rls_config = {
    \   'rust': {'clippy_preference': 'on'}
    \}

let g:ale_c_parse_compile_commands = 1
let g:ale_c_parse_makefile = 1

let g:ale_asm_gcc_executable = '~/.riscv/bin/riscv32-unknown-elf-gcc'

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" rust
let g:rust_fold = 2

" fzf
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

if has('nvim') && exists('&winblend') && &termguicolors
  set winblend=20

  hi NormalFloat guibg=None
  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border'
  endif

  function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

nnoremap <silent> <Leader>b  :Buffers<CR>
nnoremap <silent> <Leader>f  :Files 
