" Windows sysinit.vim for neovim-qt
"
" Setup:	1. Install chocolatey & python3
"		2. In an elevated shell, run `choco install nodejs yarn git llvm mingw fd xsltproc jq`
"		3. Run `pip install pynvim`
"		4. Run `npm install -g neovim`
"		5. Copy this sysinit.vim to <NVIM_ROOT_DIR>/share/nvim/
"		6. Download plug.vim from vim-plug's github and put it in <NVIM_ROOT_DIR>/share/nvim/runtime/autoload/
"		7. Start nvim and run :PlugInstall


"****************************************************************
"								                                *
" vim-plug plugin manager stuff (add to runtimepath)		    *
"								                                *
"****************************************************************
call plug#begin('~/.config/nvim/vim-plug')
" Provides icons for various plugins
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

" fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" automatically pairs () [] ...
Plug 'jiangmiao/auto-pairs'

" linter
Plug 'w0rp/ale'

" nvim tree
Plug 'nvim-tree/nvim-tree.lua'

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
Plug 'navarasu/onedark.nvim'


" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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
"								                                *
" general nvim config						                    *
"								                                *
"****************************************************************
filetype plugin indent on
filetype plugin on

set expandtab       " Always use spaces when tab is hit
set shiftwidth=4    " Use 4 spaces when indenting with >>
set tabstop=4       " Show existing tabs as 4 spaces
set softtabstop=4

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
let g:onedark_config = {
            \ 'style': 'deep',
            \ 'toggle_style_key': '<leader>ts',
            \ 'ending_tildes': v:true,
            \ 'diagnostics': {
            \ 'darker': v:false,
            \ 'background': v:false,
            \ },
            \ }
colorscheme onedark
"set background=dark


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
"								                                *
" FZF plugin config						                        *
"								                                *
"****************************************************************
let $FZF_DEFAULT_COMMAND='fd --type f' " use fd rather than find, much faster
nnoremap <C-p> :Files<CR>


"****************************************************************
"								                                *
" lualine plugin config					                        *
"								                                *
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
"								                                *
" nvim-treesitter plugin config					                *
"								                                *
"****************************************************************
lua << END
require("nvim-treesitter.install").prefer_git = true
require 'nvim-treesitter.install'.compilers = { "clang" } -- compiler that'll be used to compile parsers
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "cpp", "python", "lua", "vim", "help", "php" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "javascript" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files


        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
END


"****************************************************************
"								                                *
" nvim tree plugin config					                    *
"								                                *
"****************************************************************

lua << EOF
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      ignore_buffer_on_setup = false,
      open_on_setup = false,
      open_on_setup_file = false,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "disable",
      remove_keymaps = false,
      select_prompts = false,
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 35,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
          },
        },
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      ignore_ft_on_setup = {},
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    } -- END_DEFAULT_OPTS
EOF

nnoremap <F2> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>


"****************************************************************
"								                                *
" gitgutter plugin config					                    *
"								                                *
"****************************************************************
let g:gitgutter_max_signs = 4096


"****************************************************************
"								                                *
" UltiSnips plugin config					                    *
"								                                *
"****************************************************************
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


"****************************************************************
"								                                *
" NERDCommenter plugin config					                *
"								                                *
"****************************************************************
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/*', 'right': '*/' } }
autocmd Filetype nerdtree setlocal nolist


"****************************************************************
"								                                *
" mardown-preview plugin config					                *
"								                                *
"****************************************************************
let g:mkdp_auto_start = 0
let g:mkdp_browser = 'firefox'
let g:mkdp_port = 1911
let g:mkdp_open_to_the_world = 1


"****************************************************************
"								                                *
" ALE plugin config						                        *
"								                                *
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
"								                                *
" C filetype config: 4 spaces, no tabs			                *
"								                                *
"****************************************************************
au FileType c set softtabstop=4 shiftwidth=4 expandtab


"****************************************************************
"								                                *
" ASM filetype config						                    *
"								                                *
"****************************************************************
autocmd BufRead,BufNewFile *.asm set filetype=nasm
autocmd FileType nasm  set shiftwidth=4 softtabstop=4 expandtab syntax=nasm


"****************************************************************
"								                                *
" python filetype config: 4 spaces, no tabs			            *
"								                                *
"****************************************************************
au FileType python set softtabstop=4 shiftwidth=4 expandtab


"****************************************************************
"								                                *
" html filetype config: 4 spaces, no tabs			            *
"								                                *
"****************************************************************
autocmd FileType html set shiftwidth=4 softtabstop=4 expandtab


"****************************************************************
"								                                *
" php filetype config: 4 spaces, no tabs			            *
"								                                *
"****************************************************************
au FileType php set shiftwidth=4 softtabstop=4 expandtab


"****************************************************************
"								                                *
" java filetype config: 4 spaces, no tabs			            *
"								                                *
"****************************************************************
au FileType java set shiftwidth=4 softtabstop=4 expandtab


"****************************************************************
"								                                *
" CHANGELOG filetype config					                    *
"								                                *
"****************************************************************
autocmd BufRead,BufNewFile CHANGELOG set filetype=changelog syntax=changelog


"****************************************************************
"								                                *
" json filetype config: allow C style comments (//, jsonc)	    *
"								                                *
"****************************************************************
autocmd FileType json syntax match Comment +\/\/.\+$+


"****************************************************************
"								                                *
" allow xml beatify using =G					                *
"								                                *
"****************************************************************
autocmd FileType xml nnoremap <buffer> =G :silent %!xmllint --format --recover - 2>/dev/null<CR>


"****************************************************************
"								                                *
" allow json beatify using =G					                *
"								                                *
"****************************************************************
autocmd FileType json nnoremap <buffer> =G :%!jq<CR>


"****************************************************************
"								                                *
" misc stuff							                        *
"								                                *
"****************************************************************
" function to delete trailing white spaces on save
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()
