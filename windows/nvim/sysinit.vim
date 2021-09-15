" Windows sysinit.vim for neovim-qt
"
" Setup:	1. Install chocolatey
"		2. In an elevated shell, run `choco install nodejs yarn git llvm`
"		3. Copy this sysinit.vim to <NVIM_ROOT_DIR>/share/nvim/
"		4. Download plug.vim from vim-plug's github and put it in <NVIM_ROOT_DIR>/share/nvim/runtime/autoload/
"		5. Start nvim and run :PlugInstall

call plug#begin()
" required by colorscheme onebuddy. 
" color scheme onebuddy <=> one-dark with tree-sitter support
Plug 'tjdevries/colorbuddy.vim'
Plug 'Th3Whit3Wolf/onebuddy'

" fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'chrisbra/csv.vim', {'for' : 'csv'}

" general language linter
Plug 'w0rp/ale'

" project/file explorer
Plug 'kyazdani42/nvim-tree.lua'

" status line
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'

" markdown preview in web browser
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install --frozen-lockfile'}

" completion using LSP
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" provides icons for various plugins
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" provides better highlighting and more based on concrete syntax tree (CST) parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}	
call plug#end()

syntax on
set nocompatible
filetype plugin indent on
filetype plugin on

set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=8

set autoindent
set smartindent

let mapleader = ","

set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

set iskeyword=_,@,-,#

set nowrap
set ruler
set showmatch
set showcmd
set ignorecase
set smartcase
set incsearch
set autowrite
set laststatus=2
set mouse=nv
set number
set hls
set cursorline
set lazyredraw
set nobackup
set nowritebackup
" give more space to display messages
set cmdheight=2
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" merge both sign & number columns
set signcolumn=number
set hidden

set termguicolors
colorscheme onebuddy
set background=dark

" general keybindings
vnoremap jk <esc>
nnoremap jk <esc>
inoremap jk <esc>

" ***************************************************************
"								*
" csv plugin config						*
"								*
" ***************************************************************
noremap <F3> :%ArrangeCol<CR>

" ***************************************************************
"								*
" markdown-preview config					*
"								*
" ***************************************************************
let g:mkdp_auto_start = 0
let g:mkdp_browser = 'Firefox'
let g:mkdp_open_to_the_world = 1
let g:mkdp_port = '1337'

" ***************************************************************
"								*
" vim airline config						*
"								*
" ***************************************************************
let g:airline_theme='deus'

" ***************************************************************
"								*
" CoC config							*
"								*
" ***************************************************************
nn <F5> :call CocActionAsync('doHover')<cr>
autocmd BufEnter * silent! lcd %:p:h

" ***************************************************************
"								*
" XML filetype config						*
"								*
" ***************************************************************
" Enable beautifier/prettifier on xml files simply using cmd 'gg=G'
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"****************************************************************
"								*
" FZF plugin config						*
"								*
"****************************************************************
let $FZF_DEFAULT_COMMAND='fd --type f' " use fd rather than find, much faster
nnoremap <C-p> :Files<CR>

" ***************************************************************
"								*
" NvimTree config						*
"								*
" ***************************************************************
nnoremap <F2> :NvimTreeToggle<CR>
let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 35 "30 by default
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
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
let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }

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

" ***************************************************************
"								*
" tree-sitter config						*
"								*
" ***************************************************************
lua <<EOF
require 'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "r" },		-- list of language that will be disabled
  },
}
EOF
