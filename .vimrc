
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" This makes Vim use the indent of the previous line for a newly created line
set autoindent		" always set autoindenting on

if has('vms')
   set nobackup
else
   set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set nu              " display line number before every line
set tabstop=4           " tab 4 space
set softtabstop=4       " tab change to 4 space
set shiftwidth=4        " indent 4 space
set expandtab           " tab auto expand to space
set foldenable          " open file fold
set foldmethod=syntax   " fold by method
set foldlevelstart=99   " fold level
set clipboard+=unnamed  " use clipboard
set laststatus=2
set encoding=utf-8
set showmatch
set copyindent


" Don't use Ex mode, use Q for formatting
map Q gq

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
  au FileType text setlocal textwidth=78
  " autocmd vimenter * NERDTree

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " golang autocmd group
  augroup golang
  au!

  au Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
  au BufWritePre *.go :GoFmt

  augroup END

else


endif " has("autocmd")


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
" set mouse=a
"endif



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
Plug 'SirVer/ultisnips'
Plug 'fatih/molokai'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

" let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

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

"set fdm=indent
"
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_function_parameters = 0
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1 
let g:go_highlight_generate_tags = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_highlight_format_strings = 1
let g:go_highlight_array_whitespace_error = 0
let g:go_code_completion_enabled = 1
let g:go_auto_type_info = 0
let g:go_mod_fmt_autosave = 1
let g:go_fmt_autosave = 1

"  键映射
map <C-l> :NERDTreeToggle<CR>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
"map <c-r> :GoReferrers<CR>
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
let g:go_metalinter_autosave_enabled = ["vet", "golint"]
let g:go_metalinter_deadline = "5s"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:go_list_type = 'quickfix'
let g:go_imports_command = 'goimports'
let g:godef_split=0
"let g:go_textobj_include_function_doc = 0
let g:go_decls_includes = "func,type"
let g:go_auto_sameids = 1
"let g:go_info_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_referrers_mode = 'gopls'
let g:go_fmt_command = 'goimports'
let g:go_gopls_enabled = 1


" ----------------------------syntastic-----------------------
"
"  <Ctrl+x><Ctrl+o> : code completion
"  

