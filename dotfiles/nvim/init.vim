set nocompatible
set history=1000

set lcs=tab:+.,eol:·
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block
set scrolloff=3
set linebreak
set confirm
set shortmess+=a
set showcmd

set backspace=indent,eol,start

set completeopt=menuone,longest,preview  " bash-like tab completion on insert
set hlsearch  " highlight search results
set incsearch  " as I type my search, start moving through the file
set laststatus=2  " always show status bar, even if it's the last window

" Tabbing. Any settings other than these are evil.
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
filetype indent on  " filetype specific indenting

" folding
set foldmethod=syntax
set foldlevel=2

set mouse=a

" Persist undo across sessions
set undofile
set undodir=~/.vim/undo

let mapleader = "\\"

" Cycle tabbing options
map <leader><tab> :call CycleTabs()<CR>
fun! CycleTabs()
    if !&expandtab
        echo "4 space tabs"
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
        set expandtab
    elseif &expandtab && &shiftwidth == 4
        echo "2 space tabs"
        set shiftwidth=2
        set softtabstop=2
        set tabstop=2
        set expandtab
    else
        echo "Tab characters"
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
        set noexpandtab
    endif
endfun

" Keep text highlighted after shifting
vnoremap < <gv
vnoremap > >gv

syntax on  " syntax highlighting
filetype plugin on  " change settings and syntax highlighting based on filetype

" In Vim 7.4+ the combination of these two variables will show the absolute
" line number on the current line and relative line number on every other line
set relativenumber
set number

set ignorecase " Needed for smartcase to work
set smartcase " case insensitive search unless search has uppser case chars
set t_Co=256  " 256 colors

" list all matches and complete til longest common string (command line)
set wildmode=list:longest

" linenum, columnnum, percentage through file, modification flag, file path,
" read only/help/preview flags, file format, fugitive status
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})
" if exists("fugitive#statusline")
"     set statusline.=\ %{fugitive#statusline()}
" endif

" spell/nospell
nmap <leader>s :set spell<CR>
nmap <leader>S :set nospell<CR>

" paste/nopaste
nmap <leader>p :set paste<CR>
nmap <leader>P :set nopaste<CR>

" list/nolist
nmap <leader>l :set list<CR>
nmap <leader>L :set nolist<CR>

" toggle relative/normal line numbers
nmap <leader>n :set rnu<CR>:set nu<CR>
nmap <leader>N :set nornu<CR>:set nu<CR>

" toggle nerdtree
nmap <leader>t :NERDTreeFocus<cr>
nmap <leader>T :NERDTreeClose<cr>

" mundo
nmap <leader>u :MundoToggle<CR>

" hide matches on <leader>space
nmap <leader><space> :nohlsearch<cr>

" Bind a key to toggle coloring lines past 80
nmap <leader>8 :call eighty#ToggleColorColumn()<cr>

" Close buffer without closing the window
nmap <leader>c :bprevious<bar>split<bar>bnext<bar>bdelete<CR>

" cursor positioning
set cursorline
set cursorcolumn
highlight CursorColumn ctermbg=234 cterm=NONE
highlight CursorLine ctermbg=234 cterm=NONE

" I'll never use modula
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" sudo write this file
cmap W! w !sudo tee % >/dev/null

" neo-plug plugins
try
    call plug#begin('~/.vim/plugged')
    Plug 'leafgarland/typescript-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nijotz/eighty-columns'
    Plug 'ternjs/tern_for_vim'
    Plug 'tomlion/vim-solidity'
    Plug 'digitaltoad/vim-pug'
    Plug 'dag/vim-fish'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'altercation/vim-colors-solarized'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'j5shi/ctrlp_bdelete.vim'
    Plug 'dense-analysis/ale'
    Plug 'scrooloose/nerdtree'
    Plug 'leafgarland/typescript-vim'
    Plug 'simnalamburt/vim-mundo'
    Plug 'JamshedVesuna/vim-markdown-preview'
    Plug 'elubow/cql-vim'
    Plug 'rust-lang/rust.vim'
    Plug 'moll/vim-node'
    Plug 'mhinz/vim-grepper'
    Plug 'CaffeineViking/vim-glsl'
    Plug 'hashivim/vim-terraform'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'jremmen/vim-ripgrep'
    call plug#end()
catch
endtry

" ALE settings
let g:ale_set_highlights = 0
let g:ale_virtualtext_cursor = 0
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_fixers = ['eslint']

" Declare CoC extensions
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

" Use powerline fonts
let g:airline_powerline_fonts = 1

" markdown setup
" let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Firefox'
let vim_markdown_preview_hotkey='<leader>m'
let vim_markdown_preview_github=1

" tell syntastic which utilities to use
let g:syntastic_python_checkers=['pyflakes']

" Set tidy as the indent program when editting xml files
au FileType xml setlocal equalprg=tidy\ -i\ -xml\ --indent-spaces\ 4\ 2>/dev/null

" Set tidy as the indent program when editting html files
au FileType html setlocal equalprg=tidy\ -i\ -html\ --indent-spaces\ 4\ 2>/dev/null

" Default to two space tabs for javascript
au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

" colors
set background=dark
try
    let g:solarized_termcolors=16
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    " Color scheme doesn't exist
endtry

" I'm using solarized dark (patched) in iterm so some adjustments need to be made
hi QuickFixLine ctermbg=234
hi Visual ctermbg=12
hi Normal ctermbg=NONE

let g:ctrlp_map = '<leader>f'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_working_path_mode = 0  " Don't mess with the search path
if exists("ctrlp_bdelete#init()")
    call ctrlp_bdelete#init()  " Plugin to delete buffers in CtrlPBuf mode
endif

" I don't need branch info or file encoding
let g:airline_section_b = ''
let g:airline_section_y = ''

let g:python3_host_prog = '/opt/homebrew/bin/python3'
set pyxversion=3

let g:eighty_columns_show = 0
let g:eighty_columns_toggles = [80, 90, 100, 120, 0]

" Setup RipGrep through fzf
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always"
  \ -g "*.{js,jsx,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,liquid,scss,css}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* FileRg call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

map <leader>r :FileRg<CR>
