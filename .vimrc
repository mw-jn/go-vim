
" This must be first, because it changes other options as a side effect.
set nocompatible             " 关闭兼容模式

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" This makes Vim use the indent of the previous line for a newly created line
set autoindent		" 继承前一行的缩进
set nobackup
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set nu              " display line number before every line
set relativenumber  " 设置相对行号
set cursorline          " 突出显示当前行
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
set showmatch           " 显示括号匹配
set copyindent
set tags+=./tags;../tags;
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

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

 else
endif " has("autocmd")


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin("~/.vim/plugged")
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }     " golang
Plug 'AndrewRadev/splitjoin.vim'                       " 拆分语句合并语句
" Plug 'honza/vim-snippets'                            " vim-go 已经集成 #快速生成代码
" Plug 'SirVer/ultisnips'                              " vim-go 已经集成
Plug 'fatih/molokai'                                   " 配色
" Plug 'ctrlpvim/ctrlp.vim'                            " 文件搜索
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'scrooloose/nerdtree'                             " 目录文件导航
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'                         " vim 编辑文件状态
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'                          " git 相关
Plug 'vim-syntastic/syntastic'                         " 语法检查
Plug 'jreybert/vimagit'
Plug 'majutsushi/tagbar'
" Plug 'Shougo/deoplete.nvim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
call plug#end()


"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配色方案
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:molokai_original = 1
colorscheme molokai

"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-go setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:go_version_warning = 1            " vim 版本检查，默认开启
" let g:go_code_completion_enabled = 1    " 代码补全,默认开启
let g:go_code_completion_icase = 1        " 代码补全忽略大小写，默认关闭
" let g:go_test_show_name = 0             " 显示失败测试用例名，默认禁止
" let g:go_test_timeout= '10s'            " 设置测试超时时间，默认10s
let g:go_auto_type_info = 1               " 自动显示光标位置类型信息，默认关闭
" let g:go_info_mode = 'gopls'            " 默认使用 gopls，可以使用 guru
" let g:go_updatetime = 800               " 自动显示的更新延迟时间，默认 800ms
" let g:go_jump_to_error = 1              " 在某些命令中不需要加!,默认开启
" let g:go_fmt_autosave = 1               " 代码保存自动格式化，默认开启
" let g:go_fmt_command = 'gopls'          " 格式化代码使用的命令，默认使用 gopls,还可以使用 gofmt 以及 goimports
" let g:go_fmt_options = {                " 可以单独指定格式化使用的工具，并增加参数
"   \ 'gofmt': '-s',
"   \ 'goimports': '-local mycompany.com',
"   \ }
" let g:go_fmt_fail_silently = 0          " 显示格式化错误，默认显示
" let g:go_imports_autosave = 1           " 代码保存自动 import 包，默认开启
" let g:go_imports_mode = 'gopls'         " import 包命令,默认使用  gopls,也可以使用 goimports
" let g:go_mod_fmt_autosave = 1           " mod 保存自动格式化，默认开启
" let g:go_doc_keywordprg_enabled = 1     " godoc 光标下的字符串，默认开启
" let g:go_doc_max_height = 20            " godoc 最大高度，默认 20 行
let g:go_doc_balloon = 1                  " godoc 气泡显示，默认关闭
" let g:go_doc_url = 'https://pkg.go.dev' " 设置默认的 godoc 服务器
" let g:go_doc_popup_window = 0           " 使用 popup 窗口显示，还是 preview 窗口显示
" let g:go_def_mode = 'gopls'             " 默认使用 gopls,也可以使用 guru 或者 godef
" let g:go_fillstruct_mode = 'fillstruct' " 填充结构体使用 fillstruct,也可以使用 gopls
" let g:go_referrers_mode = 'gopls'       " 查找引用使用 gopls,也可以使用 guru
" let g:go_implements_mode = 'gopls'      " 查找接口实现，默认使用 gopls,也可以使用 guru 
" let g:go_def_mapping_enabled = 1        " 映射了一些默认键,默认开启
" let g:go_def_reuse_buffer = 0           " go def 重用缓冲区,默认禁止
" let g:go_snippet_engine = "automatic"   " 集成了一些代码片段工具，使用默认值
" let g:go_build_tags = ''                " 使用编译增加 tag
" let g:go_textobj_include_function_doc = 1 " 函数 textobj 包括文本注释
" let g:go_textobj_include_variable = 1     " 闭包函数包含变量
" let g:go_metalinter_autosave = 0          " 保存时使用 linter 进行代码静态检查，默认使用 golangci-lint, 默认禁止
let g:go_metalinter_command = "golangci-lint"  " linter 工具设置,也可以设置为 staticcheck 或者 gopls
let g:go_metalinter_deadline = "5s"            " 当 metalinter 设置为 golangci-lint, 此参数才有意义
" let g:go_metalinter_autosave_enabled = ['vet', 'revive'] " 当 metalinter 设置为 staticcheck 是该列表为空；当设置为 golangci-lint 时使用列表参数
" let g:go_metalinter_enabled = ['vet', 'revive', 'errcheck'] " 当 metalinter 设置为 staticcheck 是该列表为空；当设置为 golangci-lint 时使用列表参数
" let g:go_list_height = 0                " 指定 quickfix 和 locationlist 窗口的高度，默认 10
let g:go_list_type = 'quickfix'           " 各种命令的输出窗口，也可以设置为 locationlist
let g:go_list_type_commands = {"GoBuild": "quickfix"}   " 可以指定特定命令使用的窗口
" let g:go_list_autoclose = 1                           " 没有错误时自动关闭，默认开启
" let g:go_asmfmt_autosave = 0                          " 格式化汇编代码，默认关闭
if has("nvim")
  " let g:go_term_mode = "vsplit"                         " 使用新的窗口执行命令
  " let g:go_term_reuse =0                              " 重用终端，默认禁止
endif
" let g:go_term_height = 30
" let g:go_term_width = 30
" let g:go_term_enabled = 0
" let g:go_term_close_on_exit = 1
" let g:go_alternate_mode = "edit"
" let g:go_rename_command = 'gopls'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码补全
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:go_gopls_enabled = 1                  " 默认开启 gopls 自动补全代码
" let g:go_gopls_options = ['-remote=auto']   " 指定 gopls 服务器
" let g:go_gopls_analyses = v:null
" let g:go_gopls_complete_unimported = v:null " 代码补全能显示未导入的包,此处设为空
" let g:go_gopls_matcher = v:null               " 补全匹配，值可以为 v:null, fuzzy, caseSensitive
" let g:go_gopls_staticcheck = v:null        " 是否使用 gopls 做静态检查，默认使用 gopls
" let g:go_gopls_use_placeholders = v:null
" let g:go_gopls_local = v:null              " 指定导入包分组规则
let g:go_diagnostics_level = 2               " 0 忽略诊断，1 显示 warn, 2显示 warn 和 error
let g:go_template_autocreate = 1             " 自动创建模板文件
" let g:go_template_file = "hello_world.go"  " 指定模板文件
" let g:go_template_use_pkg = 0              " 使用默认值
" let g:go_decls_includes = 'func,type'      " 使用默认值
" let g:go_decls_mode = ''                   " 使用默认值
" let g:go_echo_command_info = 1             " 执行 go 命令时显示 go 命令
" let g:go_echo_go_info = 1                  " 代码补全完成，显示信息
" let g:go_statusline_duration = 60000       " 状态栏显示时间 60s,单位毫秒
" let g:go_addtags_transform = 'snakecase'   " 执行 AddTags 值标识，可以选择的有 snakecase, camelcase, lispcase, pascalcase, keep
" let g:go_addtags_skip_unexported = 0       " 跳过未导出变量，默认禁止
" let g:go_debug = []
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
" let g:deoplete#enable_at_startup = 1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 语法高亮设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:go_auto_sameids = 1                           " 自动高亮相同符号,默认关闭
" let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']  " 折叠，除了 comment 以外都可以折叠
" let g:go_highlight_array_whitespace_error = 1       " 数组切片类型后面有空格报错如"[] int"
" let g:go_highlight_chan_whitespace_error = 1        " chan 类型不对报错
" let g:go_highlight_extra_types = 0                " 高亮标准库类型
" let g:go_highlight_space_tab_error = 0            " tab 后有空格
let g:go_highlight_operators = 1                    " 运算符高亮
let g:go_highlight_functions = 1                    " 函数名高亮
let g:go_highlight_function_parameters = 1          " 函数参数高亮
let g:go_highlight_function_calls = 1               " 函数调用
let g:go_highlight_types = 1                        " 类型高亮
let g:go_highlight_fields = 1                       " 对象域高亮
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
" let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1          " 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 键映射
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ";"
" map <C-p> :NERDTreeToggle<CR>          " 默认 Ctrl-p 被映射到目录树上了
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
"
" normal map
" nnoremap gd :GoDef<CR>
" nnoremap gS _                    " gS 被 splitjoin 插件映射掉了
" nnoremap gJ _                    " gJ 被 splitjoin 插件映射掉了
" nnoremap gt _                    " gt vim tab 切换
" nnoremap gT _                    " gT vim tab 切换
nnoremap gr :GoReferrers<CR>
nnoremap gi :GoImplements<CR>
nnoremap gc :GoCallees<CR>
nnoremap ga :GoAlternate
nnoremap gm :GoMetaLinter
nnoremap gv :GoVet
nnoremap gp :GoChannelPeers
nnoremap fs :GoFillStruct<CR>
nnoremap fk :GoKeyify<CR>
nnoremap <leader>gd :GoDescribe<CR>
nnoremap <leader>ce :GoCallees<CR>
nnoremap <leader>cr :GoCallers<CR>
nnoremap <leader>si :GoSameIdsToggle<CR>
nnoremap <leader>ds :GoDefStack<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" golang autocmd group
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup golang
  au!

  au Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
  au BufWritePre *.go :GoFmt
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1    " 扩展 tab 标签
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap tt :TagbarToggle<CR>
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" telescope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
