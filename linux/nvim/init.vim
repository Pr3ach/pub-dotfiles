call plug#begin('~/.config/nvim/vim-plug')
" fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" automatically pairs () [] ...
Plug 'jiangmiao/auto-pairs'

" general language linter
Plug 'w0rp/ale'

" project file explorer
Plug 'kyazdani42/nvim-tree.lua'

" provide icons for various plugins
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" snippets
Plug 'sirver/ultisnips'

" statusline
Plug 'hoob3rt/lualine.nvim'

" status for git projects
Plug 'airblade/vim-gitgutter'

" easy (un)comment
Plug 'preservim/nerdcommenter'

" csv filetype plugin
Plug 'chrisbra/csv.vim', { 'for' : 'csv' }

" required by colorscheme onebuddy
" colorscheme onebuddy; one dark with tree-sitter support
Plug 'tjdevries/colorbuddy.vim'
Plug 'Th3Whit3Wolf/onebuddy'

" markdown preview in web browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" conquer of completion - LSP client
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

" concrete syntax tree (CST) parser -- provides better hightlighting and more
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

filetype plugin indent on
filetype plugin on

" pure tabs; 8 col inserted when >> or << pressed; a tab displayed as 8 spaces
set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=8

" Always use system clipboard with y and p.
" See :help clipboard
set clipboard+=unnamedplus

set autoindent
set smartindent

" reduce lag
let mapleader = ","
set lazyredraw

" avoid ^M bug
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

set iskeyword=_,@,-,#

" Built-in autocompletion
set complete=.,w,b,u,U,t,i
set omnifunc=syntaxcomplete#Complete
set infercase
set wildmenu
set wildmode=list:longest,full

" Do not wrap text, keep it in a single line
set nowrap
" Display cursor position
set ruler
" shows status line
set laststatus=2
" fix backspace's bug
set backspace=2
" show (partial) command in status line
set showcmd
" show matching brackets
set showmatch
" do case insensitive matching
set ignorecase
" do smart case matching
set smartcase
" incremental search
set incsearch
" auto save before commands like :next and :make
set autowrite
" allow mouse in normal & visual mode
set mouse=nv
" show line number
set number
" hightlight search
set hls
" increase search
set is
" so we can change cursorline colors
set cursorline
" fix slow modes switch with powerline
set timeoutlen=1000 ttimeoutlen=0
" enable regex search
set magic
" keep a backup of modified files
set backup
set backupdir=~/.config/nvim/backup

" give more height to display messages
set cmdheight=2

set updatetime=300
set hidden

" merge both sign & number columns
set signcolumn=number

if (has("termguicolors"))
	set termguicolors
endif

syntax on
colorscheme onebuddy
set background=dark

" paths to python(2|3) interpreters
let g:python2_host_prog="/usr/bin/python2"
let g:python3_host_prog="/usr/bin/python3"

"****************************************************************
"								*
" general keybindings						*
"								*
"****************************************************************
inoremap jk <esc>
vnoremap jk <esc>
nnoremap jk <esc>
nnoremap <space> 11w
nnoremap <backspace> 11b

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map <F11> :syntax list<CR>

nnoremap <Leader>cc 1<Leader>cc

"****************************************************************
"								*
" lualine plugin config						*
"								*
"****************************************************************
lua  <<EOF
require'lualine'.setup {
      options = {theme = 'onedark'},
    }
EOF

"****************************************************************
"								*
" nvim-tree plugin config					*
"								*
"****************************************************************
let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 35 "30 by default
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 0 "0 by default
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 0 "0 by default, will not resize the tree when opening a file
let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 0 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_add_trailing = 0 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 0 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_lsp_diagnostics = 0 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE', 'CHANGELOG', 'NOTES', 'NOTES.md' ] " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }

let nvim_tree_disable_keybindings=0

"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <F2> :NvimTreeToggle<CR>

"****************************************************************
"								*
" gitgutter plugin config					*
"								*
"****************************************************************
let g:gitgutter_max_signs = 4096

"****************************************************************
"								*
" UltiSnips plugin config					*
"								*
"****************************************************************
set runtimepath+=~/.config/nvim/snippets " add search path for snippets (ultisnips, snipmate ...)
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"****************************************************************
"								*
" CoC plugin config						*
"								*
"****************************************************************
" plug coc: send doHover to language server
noremap <F4> :call CocActionAsync('doHover')<CR>
" plug coc: send showSignatureHelp to language server
noremap <F5> :call CocActionAsync('showSignatureHelp')<CR>

"****************************************************************
"								*
" NERDCommenter plugin config					*
"								*
"****************************************************************
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/*', 'right': '*/' }, 'cpp': { 'left': '/*', 'right': '*/' } }
" remap <leader>cc (ie toggle comment current line) to CTRL+C and also move cursor to
" the next line to allow for batch commenting/uncommenting
nmap <C-c> <leader>cij

"****************************************************************
"								*
" markdown-preview plugin config				*
"								*
"****************************************************************
let g:mkdp_auto_start = 0
let g:mkdp_browser = 'firefox'
let g:mkdp_port = 1911
let g:mkdp_open_to_the_world = 1

"****************************************************************
"								*
" ALE plugin config						*
"								*
"****************************************************************
" disable ALE's completion & LSP support
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1
let g:airline#extensions#ale#enabled = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
" Only use specified linters
let g:ale_linters_explicit = 1
" Use only gcc not clang etc. for linting C
let g:ale_linters = {
\   'c': ['gcc', 'clang'],
\   'go': ['gofmt', 'gopls'],
\   'cpp': ['g++', 'clang++'],
\   'python': ['pylint']
\}
" pylint linter options: only show errors, ignore warnings
let g:ale_python_pylint_options = '-E'

"****************************************************************
"								*
" FZF plugin config						*
"								*
"****************************************************************
let $FZF_DEFAULT_COMMAND='fd --type f' " use fd rather than find, much faster
nnoremap <C-p> :Files<CR>

"****************************************************************
"								*
" tree-sitter plugin config					*
"								*
"****************************************************************
lua <<EOF
require 'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "erlang" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "julia" },  -- list of language that will be disabled
  },
}
EOF

"****************************************************************
"								*
" csv plugin config						*
"								*
"****************************************************************
" plugin csv.vim: align columns in csv files
noremap <F3> :%ArrangeCol<CR>

"****************************************************************
"								*
" ASM filetype config						*
"								*
"****************************************************************
autocmd BufRead,BufNewFile *.asm set filetype=nasm
autocmd FileType nasm  set shiftwidth=8 tabstop=8 noexpandtab syntax=nasm

"****************************************************************
"								*
" python filetype config: 4 spaces, no tabs			*
"								*
"****************************************************************
au FileType python set softtabstop=4 shiftwidth=4 expandtab

"****************************************************************
"								*
" html filetype config: 4 spaces, no tabs			*
"								*
"****************************************************************
autocmd FileType html set shiftwidth=4 softtabstop=4 expandtab

"****************************************************************
"								*
" php filetype config: 4 spaces, no tabs			*
"								*
"****************************************************************
au FileType php set shiftwidth=4 softtabstop=4 expandtab

"****************************************************************
"								*
" java filetype config: 4 spaces, no tabs			*
"								*
"****************************************************************
au FileType java set shiftwidth=4 softtabstop=4 expandtab

"****************************************************************
"								*
" CHANGELOG filetype config					*
"								*
"****************************************************************
autocmd BufRead,BufNewFile CHANGELOG set filetype=changelog syntax=changelog

"****************************************************************
"								*
" json filetype config: allow C style comments (//, jsonc)	*
"								*
"****************************************************************
autocmd FileType json syntax match Comment +\/\/.\+$+

"****************************************************************
"								*
" xml filetype config						*
"								*
"****************************************************************
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null " enable pretty xml with simple cmd `gg=G` by using the xmllint utility
