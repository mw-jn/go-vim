" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set foldenable
set foldmethod=syntax
set foldlevelstart=99
" 共享剪贴板
set clipboard+=unnamed
" 设置显示状态栏
set laststatus=2

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
" set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " autocmd vimenter * NERDTree

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


set tags+=./tags;../tags;
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" golang -----------------------------------------------------
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'SirVer/ultisnips'
Plug 'fatih/molokai'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

filetype plugin indent on
syntax on

" let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

let g:go_fmt_command = "goimports"
let g:godef_split=0
let g:go_textobj_include_function_doc = 0
let g:go_def_mode = 'godef'

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd BufWritePre *.go :GoFmt

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }



"
" golang -----------------------------------------------------
"


"set fdm=indent
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
"  键映射
map <C-t> :NERDTreeToggle<CR>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
map <c-r> :GoReferrers<CR>
map <c-p> :GoImplements<CR>
map <c-c> :GoCallees<CR>

nnoremap <leader>a :cclose<CR>

" 
" ----------------------------syntastic-----------------------
" configure syntastic syntax checking to check on open as well as save
"let g:syntastic_check_on_open=1
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"
" ----------------------------syntastic-----------------------
