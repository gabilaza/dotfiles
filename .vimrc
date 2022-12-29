set nocompatible
filetype off


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'terryma/vim-smooth-scroll'

"Plugin 'davidhalter/jedi-vim'

Plugin 'kkoomen/vim-doge'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

"Plugin 'ryanoasis/vim-devicons'
"Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

call vundle#end()
filetype plugin indent on

"Coc
let g:coc_global_extensions = ['coc-docker', 'coc-git', 'coc-highlight', 'coc-pyright', 'coc-clangd', 'coc-angular', 'coc-java', 'coc-tsserver']

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f <Plug>(coc-format-selected)

"let g:jedi#popup_on_dot = 0
"let g:jedi#use_splits_not_buffers = "right"
"let g:jedi#goto_command = "gt"
"let g:jedi#documentation_command = "gd"
"let g:jedi#goto_assignments_command = "ga"
"let g:jedi#goto_stubs_command = ""
"let g:jedi#goto_definitions_command = "gf"
"let g:jedi#usages_command = "gu"
"let g:jedi#completions_command = ""
"let g:jedi#rename_command = ""


"Smooth
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 6, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 6, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 3, 1)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 3, 1)<CR>


"mapleader
let mapleader = " "

"doge
let g:doge_mapping = "<leader>a"

"Alt key mappings
if !has('nvim')
    for c in split('abcdefghijklmnopqrstuvwxyz0123456789-+', '\zs')
        silent execute "set <M-" . c . ">=\<Esc>" . c
    endfor
endif


"airline
let g:airline_theme='gruvbox'
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#nerdtree_status = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts=2
set t_Co=256
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ' '
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.dirty='⚡'


"theme
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='medium'
let g:gruvbox_termcolors=256


"Window switch
noremap <silent> <leader>h :wincmd h<CR>
noremap <silent> <leader>j :wincmd j<CR>
noremap <silent> <leader>k :wincmd k<CR>
noremap <silent> <leader>l :wincmd l<CR>
noremap <silent> <leader>o :on<CR>
noremap <silent> <leader>b :bd<CR>


"fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--preview 'head -500 {}'"
noremap <silent> <leader>, :Files<CR>
nnoremap <silent> <leader>s :call fzf#run({ 'window': { 'width': 0.9, 'height': 0.9 }, 'sink': 'split' })<CR>
nnoremap <silent> <leader>v :call fzf#run({ 'window': { 'width': 0.9, 'height': 0.9 }, 'sink':  'vertical split' })<CR>
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction
function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction
nnoremap <silent> <leader><Enter> :call fzf#run({ 'source':  reverse(<sid>buflist()), 'sink':    function('<sid>bufopen'), 'options': '+m', 'down':    len(<sid>buflist()) + 2})<CR>


"NERDTree
noremap <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


"Compile
autocmd filetype python nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!python -B '.shellescape('%')<CR>
autocmd filetype c nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && time ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && time ./'.shellescape('%:r')<CR>
"autocmd filetype c nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!clang '.shellescape('%').' -o '.shellescape('%:r').' && time ./'.shellescape('%:r')<CR>
"autocmd filetype cpp nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!clang++ '.shellescape('%').' -o '.shellescape('%:r').' && time ./'.shellescape('%:r')<CR>
autocmd filetype sh nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!sh '.shellescape('%')<CR>
autocmd filetype go nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!go run '.shellescape('%')<CR>
autocmd filetype rust nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!rustc '.shellescape('%')<CR>
autocmd filetype rust nnoremap <leader>r :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!rustc '.shellescape('%').' && time ./'.shellescape('%:r')<CR>

"Compile graphics with SFML (use Makefile now)
"autocmd filetype cpp nnoremap <leader>C :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!g++ -c '.shellescape('%').' -o '.shellescape('%:r').' -I./SFML/include && g++ '.shellescape('%:r').' -o sfml-app -L./SFML/lib -lsfml-graphics -lsfml-window -lsfml-system  && export LD_LIBRARY_PATH=./SFML/lib &&./sfml-app'<CR>
"Compile C++ with headers (use Makefile now)
"autocmd filetype cpp nnoremap <leader>r :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!g++ *.cpp -o a.out && time ./a.out'<CR>
"autocmd filetype cpp nnoremap <leader>r :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!clang++ *.cpp -o a.out && time ./a.out'<CR>

"Compile asm
autocmd filetype asm nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!nasm -felf32 '.shellescape('%').' && g++ -m32 '.shellescape('%:r').'.o -o '.shellescape('%:r').' && time ./'.shellescape('%:r')<CR>
"Compile asm with gdb
autocmd filetype asm nnoremap <leader>C :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!nasm -felf32 '.shellescape('%').' && g++ -m32 '.shellescape('%:r').'.o -o '.shellescape('%:r').' && gdb ./'.shellescape('%:r')<CR>

"Compile processing with java
"conflict with arduino
autocmd filetype arduino nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!~/processing4/processing-java --sketch='.getcwd().' --run'<CR>


"Alki filetype
autocmd BufNewFile,BufRead *.alk set filetype=alkilanguage
"Alki syntax
autocmd BufNewFile,BufRead *.alk set syntax=cpp
"Alki language compile
autocmd filetype alkilanguage nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!~/alki/v3.0/bin/alki.sh -a '.shellescape('%').' -m -i '.shellescape('%:r').'.in'<CR>

"Lex
autocmd filetype lex nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!flex '.shellescape('%').' && gcc lex.yy.c -o '.shellescape('%:r').' && ./'.shellescape('%:r').' '.shellescape('%:r').'.txt'<CR>
"Yacc
autocmd filetype yacc nnoremap <leader>r :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!yacc -d '.shellescape('%').' && lex '.shellescape('%:r').'.l && gcc lex.yy.c y.tab.c -o '.shellescape('%:r').' && ./'.shellescape('%:r').' '.shellescape('%:r').'.txt'<CR>

"Java
autocmd filetype java nnoremap <leader>c :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!find ./src/ -type f -name "*.java" -exec javac -cp ./src/ -d ./out/ {} + && java -cp ./out/ '.shellescape('%:t:r')<CR>
"autocmd filetype java nnoremap <leader>r :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!find . -type f -name "*.java" -exec javac -cp . -d ./out/ {} + && java -cp ./out/ '.shellescape('%:t:r')<CR>

"Maven
autocmd filetype java nnoremap <leader>r :w! <bar> exec 'silent !clear' <bar> :redraw! <bar> exec '!mvn clean compile exec:java@'.shellescape('%:t:r')<CR>


"vim-javacomplete2'
"autocmd fileType java setlocal omnifunc=javacomplete#Complete
"let g:JavaComplete_EnableDefaultMappings = 1 "delete mapping from autoload/javacomplete.vim because the plugin is shit

"Jedi-vim
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-n>"
"let g:jedi#popup_on_dot = 0
"let g:jedi#use_splits_not_buffers = "right"
"let g:jedi#goto_command = "gt"
"let g:jedi#documentation_command = "gd"
"let g:jedi#goto_assignments_command = "ga"
"let g:jedi#goto_stubs_command = ""
"let g:jedi#goto_definitions_command = "gf"
"let g:jedi#usages_command = "gu"
"let g:jedi#completions_command = ""
"let g:jedi#rename_command = ""


"Buffer
nnoremap <silent> <leader>d :bp<bar>bd # <CR>
nnoremap <silent> <leader>n :bn <CR>
nnoremap <silent> <leader>N :bp <CR>


"Resize window
nnoremap <silent> <C-j> :resize +4<CR>
nnoremap <silent> <C-k> :resize -4<CR>
nnoremap <silent> <C-l> :vertical resize +4<CR>
nnoremap <silent> <C-h> :vertical resize -4<CR>


"Clipboard
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>P "+P
nnoremap <silent> <leader>yy "+yy


"Tab
nnoremap <silent> <M-1> 1gt<CR>
nnoremap <silent> <M-2> 2gt<CR>
nnoremap <silent> <M-3> 3gt<CR>
nnoremap <silent> <M-4> 4gt<CR>
nnoremap <silent> <M-5> 5gt<CR>
nnoremap <silent> <M-6> 6gt<CR>
nnoremap <silent> <M-7> 7gt<CR>
nnoremap <silent> <M-8> 8gt<CR>
nnoremap <silent> <M-9> 9gt<CR>
nnoremap <silent> <M-t> :tabnew<CR>
nnoremap <silent> <M-q> :tabclose<CR>
nnoremap <silent> <M-d> :windo bd<CR>
nnoremap <silent> <M--> :tabmove -1<CR>
nnoremap <silent> <M-+> :tabmove +1<CR>


"ctag
nnoremap <silent> <leader>t exec 'silent !ctags -R .'<CR>
nnoremap <silent> <leader>[ <C-T><CR>
nnoremap <silent> <leader>] <C-]><CR>
nnoremap <silent> <leader>{ :tf<CR>
nnoremap <silent> <leader>} :tl<CR>


"Macro
nnoremap <silent> Q @@<CR>


"Arrow keys disable
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>


"Self
syntax on
"set foldmethod=indent
set list
set autoindent
set smarttab
set hlsearch
set splitright
set splitbelow
"set showcmd       "Warning cursor flashing
set incsearch
set ignorecase
set hidden
set autoread
set noerrorbells
set novisualbell
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set cursorline
set relativenumber
set timeoutlen=1000 ttimeoutlen=0
set shell=/bin/bash
set encoding=UTF-8
noremap H ^
noremap L g_
noremap J 5j
vnoremap J 5j
noremap K 5k
vnoremap K 5k
nnoremap gh H
nnoremap gl L
nnoremap M gM
nnoremap gm M
nnoremap <CR> <Nop>
nnoremap <Space> <Nop>
nnoremap <silent> <leader>w :w!<CR>
nnoremap <silent> <leader>q :qa!<CR>
nnoremap <silent> <leader>m :noh <CR>
nnoremap <silent> da gg dG<CR>
" %!xxd see in bin
" or
" setlocal display=uhex
"
"g;    |     ``       
"au TextChanged <buffer> silent write
"au InsertLeave <buffer> silent write

