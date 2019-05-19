" Vundle Settings
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!

" My Bundles:

Bundle 'gmarik/vundle'

Bundle 'mattn/emmet-vim'

Bundle 'Lokaltog/vim-powerline'

Bundle 'ervandew/supertab'

Bundle 'Shougo/neocomplcache.vim'

Bundle 'terryma/vim-multiple-cursors'

Bundle 'kien/ctrlp.vim'

Bundle 'scrooloose/nerdtree'

Bundle 'sickill/vim-monokai'

Bundle 'kchmck/vim-coffee-script'

Bundle 'vim-scripts/vim-stylus'

Bundle 'godlygeek/tabular'

Bundle 'plasticboy/vim-markdown'

Bundle 'digitaltoad/vim-jade'

Bundle 'vim-scripts/nginx.vim'

Bundle 'tpope/vim-fugitive'

" React
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'

" Es6
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'garbas/vim-snipmate'
Bundle 'isRuslan/vim-es6'

Bundle 'posva/vim-vue'
Bundle 'rudes/vim-java'
Bundle 'leafgarland/typescript-vim'
Bundle 'ekalinin/Dockerfile.vim'


filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" Set Powserline
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
" let g:Powerline_symbols = 'fancy'

" tab_to_space
set ts=4
set expandtab
set autoindent

let &t_Co=256
syntax enable

colorscheme monokai


" neocomplcache auto completion
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1

" Set line number
set nu
set rnu

" Auto indent
set autoindent

" Set syntax highlighting
syntax on

" search highlight
set hlsearch
set cursorline
set cursorcolumn
set foldmethod=syntax
set nofoldenable

" key map
map <F10> :NERDTreeToggle<CR>
map <Space> <C-F>
map <C-c>,<C-p> :CtrlP<CR>

" emmet settings
let g:user_emmet_install_global = 0
autocmd FileType html,css,sass,scss,tpl,smarty EmmetInstall

" Ctrlp setting
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|incremental)|(\.(git|hg|svn|sass|cache|sass-cache))$',
  \ 'file': '\v\.(exe|so|dll|log|jpg|png|jpeg|gif|swf)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" https://github.com/kien/ctrlp.vim/blob/master/doc/ctrlp.txt
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 25
" nerdtree
" autocmd vimenter * NERDTree




" 记住上次编辑位置
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
