"set runtimepath+=~/.vim_runtime

"source ~/.vim_runtime/vimrcs/basic.vim
"source ~/.vim_runtime/vimrcs/filetypes.vim
"source ~/.vim_runtime/vimrcs/plugins_config.vim
"source ~/.vim_runtime/vimrcs/extended.vim

"try
"source ~/.vim_runtime/my_configs.vim
"catch
"endtry

set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'majutsushi/tagbar'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
"Plugin 'file:///home/jackgrence/.vim/plugin/eclim.vim'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
" ctag
Plugin 'taglist.vim'
" yapf
Plugin 'mindriot101/vim-yapf'

Plugin 'tomasr/molokai'
" Plugin 'Yggdroot/indentLine'
" Plugin 'nathanaelkane/vim-indent-guides'
" All of your Plugins must be added before the following line

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" All of your Plugins must be added before the following line
call vundle#end() " required\
            
            
        
            
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe  代码自动补全
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'Valloric/YouCompleteMe'
"simple work            
set relativenumber
set nu
set ai
set cursorline
set background=dark
set hlsearch
set encoding=utf-8
" ( [ "
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>

syntax enable
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
set mouse=n

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_user_command = 'find %s -type f'



func! CIndent()
" GNU Coding Standards
setlocal cindent
setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=79
setlocal fo-=ro fo+=cql
endf

func! RubyIndent()
    set shiftwidth=2
    set softtabstop=2
endf

func! CodeStyle()
    exec "w"
    let l:exp = expand("%:e")
    if l:exp == 'py'
        exec "!pep8 %"
    elseif l:exp == 'rb'
        exec "!rubocop %"
    endif
endf


" expand( "%:e" )
func! Compile(...)
    exec "w"

    let l:args = ''
    if a:0 >= 1
        call inputsave()
        echo "\n"
        let l:args = ' ' . input('input your args:')
        call inputrestore()
    endif

    let l:exp = expand( "%:e" )
    if l:exp == 'c'
        exec CompileC() . l:args
    elseif l:exp == 'py'
        exec CompilePython() . l:args
    elseif l:exp == 'java'
        exec CompileJava() . l:args
    endif
endf



func! CompileJava()
    return "!sed -e 's/$/\r/' % > ms_% && javac -d . % && java %<"
endf

func! CompilePython()
    call inputsave()
    echo "\n(1)py2 (2)py3"
    let l:select = input('input:')
    call inputrestore()

    if l:select == '1'
        return "!python %"
    elseif l:select == '2'
        return "!python3 %"
    endif
    return 'protect'
endf

" other------
func! ToWindows()
    exec "!sed -e 's/$/\r/' % > ms_%"
endf
" test--------
func! MakeProject()
    exec "!make"
    exec "!./%<"
endf


" ------------
" keymap

nmap <F2> :TagbarToggle<CR>
nmap <F3> :NERDTreeToggle<cr>
nmap <F4> :call Yapf()<cr>
nnoremap <F5> :call Compile()<cr>
nnoremap <F6> :call Compile('with_arg')<cr>
nnoremap <F7> :call CodeStyle()<cr>
set pastetoggle=<F8>
"nnoremap <F9> :TlistToggle<CR>

nnoremap <c-j> :m+<cr>
nnoremap <c-k> :m-2<cr>
nnoremap <c-h> :tabp<cr>
nnoremap <c-l> :tabn<cr>

nmap <C-b>n  :bnext<CR>
nmap <C-b>p  :bprev<CR>

vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

nnoremap <c-z> :u<CR>      " Avoid using this**
inoremap <c-z> <c-o>:u<CR>


" tmux using
" copy to buffer
vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
" paste from buffer
map <C-v> :r ~/.vimbuffer<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2
let g:airline_theme='dark'

 let g:tagbar_left = 1
let g:tagbar_width = 30
autocmd VimEnter * nested :TagbarOpen
"autocmd FileType * nested :call tagbar#autoopen(0)
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" close view when autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
colorscheme molokai
let g:airline_powerline_fonts = 1

"NERDTRee
let g:NERDTreeWinSize=20
let g:NERDTreeWinPos= "right"

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:EclimCompletionMethod = 'omnifunc'

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
