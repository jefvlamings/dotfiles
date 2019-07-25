" General
set nocompatible
filetype off

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-haml'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
Plugin 'StanAngeloff/php.vim'
Plugin 'posva/vim-vue'
Plugin 'w0rp/ale'
Plugin 'Yggdroot/indentLine'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'moll/vim-node'
call vundle#end()

" General
filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized
set mouse=n
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set backspace=indent,eol,start    " Make backspace work in insert mode
set history=1000                	" How many lines of history to remember
set autoindent 						      	" Indenting based on file type
set nosi									      	" Smart indenting
set tabstop=2 						      	" 1 tab = 2 spaces
set shiftwidth=2					      	" 1 tab = 2 spaces
set number 								      	" Line numbers
set laststatus=2					      	" Show status bar at all times
set ruler									      	" Show current position in status bar
set wildmenu							      	" Turn on wildmenu
set hidden  							      	" Allow closing buffers without saving changes
set noerrorbells					      	" No error bell sound
set nowrap								      	" Don't wrap lines
set sidescroll=1					      	" Scroll horizontal if too many chars
set autoread							      	" Auto update files in buffers when changed
set ignorecase                  	" ignore case when searching
set incsearch                   	" search as characters are entered, as you type in more characters, the search is refined
set backupdir=~/.vim/backup/      " Don't backup in working directory
set directory=~/.vim/swap/        " Don't create swp in working directory
set undodir=~/.vim/undo/  	      " Don't create undo history in workign directory
set wildignore+=*.pdf,*.psd 			" Ignore documents
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico " Ignore images
set wildignore+=*/tmp/* " Ignore dependencies
set clipboard=unnamed 						" Copy paste from vim to os
set signcolumn=yes 								" Always show diff sign column

" On save
autocmd BufWritePost *  silent! "!ctags -R >/dev/null 2>&1" | redraw! " Run ctags
autocmd BufWritePost * GitGutter 																			" Run GitGutter 

" NERDTree
autocmd StdinReadPre * let s:std_in=1 " NERDTree: Start with vim 
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif " NERDTree: Start only in projects
let g:NERDTreeWinSize=60  	       " NERDTree: Set window width to 60 chars 
let NERDTreeShowHidden=1					 " Show hidden files
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf
set rtp+=/usr/local/opt/fzf        " Activate fzf
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0) " Add file preview
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --no-heading --line-number '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) " Add file preview

" Mappings
map <Char-167> :NERDTreeFind<CR>   " § to open current file in nerdtree
nnoremap <Backspace> :bp\|bd #<CR> " Close current buffer and go to next one
nnoremap <Tab> :bnext<CR>          " Go to next buffer
nnoremap <S-Tab> :bprevious<CR>    " Go to previous buffer
nnoremap <C-p> :Files<CR>					 " Find files with ctrl-P
nnoremap <C-f> :Rg<CR>						 " Find strings with ctrl-F
nmap =j :%!python -m json.tool<CR> " =j to pretty format json files
nnoremap gd g*						 				 " gd should jump to definition
nnoremap g* gd						 				 " g* should only highlight definition

" Set default ruby for autocompletion 
" source: https://github.com/tpope/gem-ctags
autocmd FileType ruby let &l:tags = pathogen#legacyjoin(pathogen#uniq(
      \ pathogen#split(&tags) +
      \ map(split($GEM_PATH,':'),'v:val."/gems/*/tags"')))

" ALE
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['php'] = ['php_cs_fixer']
let g:ale_fixers['ruby'] = ['rubocop']
let g:ale_fixers['typescript'] = ['prettier', 'tslint']
let g:ale_javascript_prettier_options = "--single-quote --trailing-comma es5 --print-width 80"
let g:ale_fixers['css'] = ['prettier']
let g:ale_fix_on_save = 1
