" Windows sysinit.vim for neovim-qt
"
" Setup:	1. Install chocolatey
"		2. In an elevated shell, run `choco install nodejs yarn git llvm`
"		3. Copy this sysinit.vim to <NVIM_ROOT_DIR>/share/nvim/
"		4. Download plug.vim from vim-plug's github and put it in <NVIM_ROOT_DIR>/share/nvim/runtime/autoload/
"		5. Start nvim and run :PlugInstall


filetype plugin indent on
filetype plugin on

"****************************************************************
"								*
" vim-plug plugin manager stuff (add to runtimepath)		*
"								*
"****************************************************************
call plug#begin('~/.config/nvim/vim-plug')
" Provides icons for various plugins
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" fuzzy file finder
Plug 'kien/ctrlp.vim'

" automatically pairs () [] ...
Plug 'jiangmiao/auto-pairs'

" linter
Plug 'w0rp/ale'

" nvim tree
Plug 'kyazdani42/nvim-tree.lua'

" snippets
Plug 'sirver/ultisnips'

" modeline
Plug 'nvim-lualine/lualine.nvim'

" status for git projects
Plug 'airblade/vim-gitgutter'

" easy (un)comment
Plug 'scrooloose/nerdcommenter'

" latex stuff ??
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }

" latex live preview
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" csv filetype plugin
Plug 'chrisbra/csv.vim'

" colorschemes
Plug 'Th3Whit3Wolf/one-nvim'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" lsp client & co.
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
call plug#end()


"****************************************************************
"								*
" general nvim config						*
"								*
"****************************************************************
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
set completeopt=menu,menuone,noselect
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
" allow mouse in normal mode
set mouse=n
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

if (has("termguicolors"))
	set termguicolors
endif

syntax on
colorscheme one-nvim
set background=dark


"****************************************************************
"								                                *
" nvim-cmp plugin config				                		*
"								                                *
"****************************************************************
lua << EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })


  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })


  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Python LSP server
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }

  -- C LSP server
    require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
EOF

"****************************************************************
"								        *
" ctrlp plugin config						*
"								*
"****************************************************************
" Disable caching: no need to refresh cache for created files
let g:ctrlp_use_caching = 0
" set root to folder containing .git .svn ...
let g:ctrlp_working_path_mode = 'rc'

"****************************************************************
"								*
" lualine plugin config					*
"								*
"****************************************************************
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'everforest',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END


"****************************************************************
"								*
" nvim tree plugin config					*
"								*
"****************************************************************
let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 35
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 0
let g:nvim_tree_auto_close = 0
let g:nvim_tree_auto_ignore_ft = ['startify', 'dashboard']
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" You can edit keybindings be defining this variable
" You don't have to define all keys.
" NOTE: the 'edit' key will wrap/unwrap a folder and open a file
let g:nvim_tree_bindings = {
    \ 'edit':            ['<CR>', 'o'],
    \ 'edit_vsplit':     '<C-v>',
    \ 'edit_split':      '<C-x>',
    \ 'edit_tab':        '<C-t>',
    \ 'close_node':      ['<S-CR>', '<BS>'],
    \ 'toggle_ignored':  'I',
    \ 'toggle_dotfiles': 'H',
    \ 'refresh':         'R',
    \ 'preview':         '<Tab>',
    \ 'cd':              '<C-]>',
    \ 'create':          'a',
    \ 'remove':          'd',
    \ 'rename':          'r',
    \ 'cut':             'x',
    \ 'copy':            'c',
    \ 'paste':           'p',
    \ 'prev_git_item':   '[c',
    \ 'next_git_item':   ']c',
    \ 'dir_up':          '-',
    \ 'close':           'q',
    \ }

" Disable default mappings by plugin
" Bindings are enable by default, disabled on any non-zero value
" let nvim_tree_disable_keybindings=1

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
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': "",
    \   'symlink': "",
    \   }
    \ }

nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


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
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


"****************************************************************
"								*
" NERDCommenter plugin config					*
"								*
"****************************************************************
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/*', 'right': '*/' } }
autocmd Filetype nerdtree setlocal nolist


"****************************************************************
"								*
" mardown-preview plugin config					*
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
let g:airline#extensions#ale#enabled = 1
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

inoremap jk <esc>
vnoremap jk <esc>
nnoremap jk <esc>

"****************************************************************
"								*
" C filetype config: 4 spaces, no tabs			*
"								*
"****************************************************************
au FileType c set softtabstop=4 shiftwidth=4 expandtab

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
" allow xml beatify using =G					*
"								*
"****************************************************************
au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"


"****************************************************************
"								*
" misc stuff							*
"								*
"****************************************************************
" function to delete trailing white spaces on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()
