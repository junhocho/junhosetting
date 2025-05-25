-- Neovim 설정 - Mason LSP 마이그레이션
-- 기존 vimrc의 설정을 Lua로 변환

-- 기본 설정
vim.g.mapleader = ","
-- vim.opt.nocompatible = true  -- Neovim에서는 필요없음
vim.opt.encoding = "UTF-8"
vim.opt.fileencodings = "UTF-8"
vim.opt.fencs = "utf8,euc-kr,cp949,cp932,euc-jp,shift-jis,big5,latin1,ucs-2le"
vim.opt.visualbell = true
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.history = 15
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.backup = false
vim.opt.foldmethod = "marker"
vim.opt.hlsearch = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.wildmenu = true
vim.opt.laststatus = 3  -- 전역 상태바 (Neovim 0.7+)
vim.opt.showtabline = 2  -- 항상 탭라인 표시
vim.opt.colorcolumn = "129"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 256
vim.cmd("syntax sync minlines=256")

-- Python 호스트 프로그램 설정 (Neovim용)
if vim.fn.has('nvim') == 1 then
  if vim.env.CONDA_PREFIX and vim.env.CONDA_PREFIX ~= "" then
    vim.g.python3_host_prog = vim.env.CONDA_PREFIX .. '/bin/python'
  elseif vim.fn.has('mac') == 1 and vim.fn.isdirectory('/Users/junho/opt/anaconda3') == 1 then
    vim.g.python3_host_prog = '/Users/junho/opt/anaconda3/bin/python'
  end
end

-- 키 매핑
vim.keymap.set('n', 'L', 'i<CR><Esc>')
vim.keymap.set('n', '<C-l>', ':SignifyToggle<CR>:set nonumber!<CR>:IndentLinesToggle<CR>')
vim.keymap.set('n', '<leader>s', ':update<CR>')
vim.keymap.set('n', '<F1>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<F3>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>')
vim.keymap.set('n', '<C-s>', '<Esc>:w<CR>')
vim.keymap.set('i', '<C-d>', '<ESC>:q<CR>')
vim.keymap.set('n', '<C-q>', '<Esc>:q<CR>')
vim.keymap.set('n', '<F4>', ':%s/\\s\\+$//e<CR>')
vim.keymap.set('n', '<F6>', ':vs<CR>')
vim.keymap.set('n', '<F7>', ':sp<CR>')
vim.keymap.set('n', '<F8>', ':SrcExplToggle<CR>')
vim.keymap.set('n', '<F9>', ':TagbarToggle<CR>')

-- 버퍼 관련 키 매핑
vim.keymap.set('n', '<leader>T', ':enew<CR>')
vim.keymap.set('n', '<leader>bq', ':bp <BAR> bd #<CR>')
vim.keymap.set('n', '<leader>bl', ':ls<CR>')

-- 버퍼 관련 키매핑은 bufferline.nvim 설정에서 처리

-- lazy.nvim 설치
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 설정
require("lazy").setup({
  -- Treesitter (향상된 syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- 필요한 파서 자동 설치
        ensure_installed = { "python", "lua", "vim", "vimdoc", "bash", "javascript", "typescript", "c", "cpp", "rust", "go", "java" },
        
        -- 파서 동기식으로 설치 (첫 번째 설치에만 권장)
        sync_install = false,
        
        -- 파서 자동 설치
        auto_install = true,
        
        highlight = {
          enable = true,
          -- vim regex highlighting 비활성화 (성능 향상)
          additional_vim_regex_highlighting = false,
        },
        
        -- 추가 기능들
        indent = {
          enable = true,
        },
        
        -- 점진적 선택 (코드 블록 선택)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- LSP 관련
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0", -- v1.x 버전으로 고정
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "pyright",        -- Python LSP
          "lua_ls",         -- Lua LSP
          "bashls",         -- Bash LSP
          "jsonls",         -- JSON LSP
          "yamlls",         -- YAML LSP
        },
        automatic_installation = true,
        -- 각 서버별 자동 설정
        handlers = {
          -- 기본 핸들러
          function(server_name)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          
          -- lua_ls 전용 핸들러
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                  },
                  diagnostics = {
                    globals = {'vim'},
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })
          end,
          
          -- pyright 전용 핸들러
          ["pyright"] = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local util = require('lspconfig.util')
            
            -- 프로젝트 루트 찾기
            local root_pattern = util.root_pattern("pyrightconfig.json", ".git", "setup.py", "requirements.txt")
            
            lspconfig.pyright.setup({
              capabilities = capabilities,
              root_dir = root_pattern,
              on_init = function(client)
                -- pyrightconfig.json이 있으면 그것을 사용
                local workspace_path = client.config.root_dir
                if workspace_path and vim.fn.filereadable(workspace_path .. "/pyrightconfig.json") == 1 then
                  client.config.settings = {}  -- pyrightconfig.json 설정 우선
                else
                  -- 없으면 기본 설정 사용
                  client.config.settings.python = {
                    analysis = {
                      typeCheckingMode = "basic",
                      autoSearchPaths = true,
                      useLibraryCodeForTypes = true,
                    }
                  }
                end
                return true
              end,
            })
          end,
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- LSP 서버 설정
      local servers = require("mason-lspconfig").get_installed_servers()
      
      -- lua_ls는 특별한 설정이 필요하므로 handler에서 처리되지 않은 경우 여기서 설정
      -- (하지만 이미 Mason handler가 처리하므로 실제로는 실행되지 않음)
    end
  },

  -- 자동완성 (completor.vim 대체)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end
  },

  -- 린터와 포매터 (syntastic 대체)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local sources = {}
      
      -- 사용 가능한 포매터/린터만 추가
      if vim.fn.executable("black") == 1 then
        table.insert(sources, null_ls.builtins.formatting.black)
      end
      if vim.fn.executable("isort") == 1 then
        table.insert(sources, null_ls.builtins.formatting.isort)
      end
      if vim.fn.executable("pylint") == 1 then
        table.insert(sources, null_ls.builtins.diagnostics.pylint)
      end
      -- flake8은 제거 (pyright로 충분)
      if vim.fn.executable("stylua") == 1 then
        table.insert(sources, null_ls.builtins.formatting.stylua)
      end
      if vim.fn.executable("prettier") == 1 then
        table.insert(sources, null_ls.builtins.formatting.prettier)
      end
      
      null_ls.setup({
        sources = sources,
        debug = false,
        notify_format = "[null-ls] %s", -- 에러 메시지 형식
        on_attach = function(client, bufnr)
          -- none-ls의 진단 완전 비활성화 (pyright와 중복 방지)
          client.server_capabilities.diagnosticsProvider = false
        end,
      })
    end
  },

  -- 기존 플러그인들 (vim-plug에서 마이그레이션)
  { "mhinz/vim-signify" },
  { "tpope/vim-fugitive" },
  { "scrooloose/nerdtree" },
  { "wesleyche/SrcExpl" },
  { "majutsushi/tagbar" },
  { "ctrlpvim/ctrlp.vim" },
  { "tpope/vim-obsession" },
  { 
    "dhruvasagar/vim-prosession",
    dependencies = { "tpope/vim-obsession" },
  },
  { "gikmx/ctrlp-obsession" },
  { "nathanaelkane/vim-indent-guides" },
  { "jiangmiao/auto-pairs" },
  { "mbbill/undotree" },
  { "tpope/vim-commentary" },
  { "Yggdroot/indentLine" },
  { "jacquesbh/vim-showmarks" },
  { "junegunn/seoul256.vim" },
  
  -- 버퍼라인 추가
  {
    'akinsho/bufferline.nvim',
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          buffer_close_icon = '×',
          modified_icon = '●',
          close_icon = '×',
          left_trunc_marker = '←',
          right_trunc_marker = '→',
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          show_buffer_icons = false,  -- 아이콘 비활성화
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = false,
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          color_icons = false,
        },
        highlights = {
          -- 활성 버퍼 (현재 포커스된 버퍼)
          buffer_selected = {
            fg = '#ffffff',
            bg = '#3a3a3a',
            bold = true,
            italic = false,
          },
          numbers_selected = {
            fg = '#ffaf00',
            bg = '#3a3a3a',
            bold = true,
          },
          -- 비활성 창에 보이는 버퍼
          buffer_visible = {
            fg = '#888888',
            bg = '#262626',
            bold = false,
            italic = false,
          },
          numbers_visible = {
            fg = '#666666',
            bg = '#262626',
          },
          -- 배경 버퍼 (열려있지만 보이지 않는 버퍼)
          background = {
            fg = '#666666',
            bg = '#1c1c1c',
            bold = false,
            italic = false,
          },
          numbers = {
            fg = '#444444',
            bg = '#1c1c1c',
          },
          -- 인디케이터
          indicator_selected = {
            fg = '#ff5f00',  -- 주황색 인디케이터
            bg = '#3a3a3a',
          },
          indicator_visible = {
            fg = '#444444',
            bg = '#262626',
          },
          -- 구분선
          separator = {
            fg = '#1c1c1c',
            bg = '#1c1c1c',
          },
          separator_selected = {
            fg = '#1c1c1c',
            bg = '#3a3a3a',
          },
          separator_visible = {
            fg = '#1c1c1c',
            bg = '#262626',
          },
          -- 수정된 파일 표시
          modified_selected = {
            fg = '#ff5f00',
            bg = '#3a3a3a',
          },
          modified_visible = {
            fg = '#888888',
            bg = '#262626',
          },
          modified = {
            fg = '#666666',
            bg = '#1c1c1c',
          },
        }
      })
      
      -- 버퍼 이동 (표시된 순서대로)
      vim.keymap.set('n', "<leader>'", ':BufferLineCycleNext<CR>', { silent = true })
      vim.keymap.set('n', '<leader>;', ':BufferLineCyclePrev<CR>', { silent = true })
      
      -- 버퍼 순서 변경 키매핑
      vim.keymap.set('n', '<leader><', ':BufferLineMovePrev<CR>', { silent = true })
      vim.keymap.set('n', '<leader>>', ':BufferLineMoveNext<CR>', { silent = true })
      
      -- 버퍼 직접 선택
      vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { silent = true })
      vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { silent = true })
      vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { silent = true })
      vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { silent = true })
      vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { silent = true })
      vim.keymap.set('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { silent = true })
      vim.keymap.set('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', { silent = true })
      vim.keymap.set('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', { silent = true })
      vim.keymap.set('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', { silent = true })
    end
  },
  
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'seoul256',
          icons_enabled = false,  -- 아이콘 비활성화 (네모 박스 제거)
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          always_divide_middle = true,
          globalstatus = true,  -- 전역 상태바 사용 (창 분할 시 하나만 표시)
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {
            {
              'filename',
              file_status = true,  -- 수정 상태 표시
              path = 1,              -- 상대 경로 표시
            }
          },
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
        tabline = {},  -- bufferline.nvim 사용하므로 비활성화
        extensions = {'nerdtree', 'fugitive'}
      })
    end
  },
  -- vim-diminactive 제거 (색상 반전 문제)
  -- { "blueyed/vim-diminactive" },
  { "tmux-plugins/vim-tmux-focus-events" },
  { 
    "hkupty/iron.nvim",
    config = function()
      require("iron.core").setup({
        config = {
          -- 기본 설정
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "python" },
              format = require("iron.fts.common").bracketed_paste_python
            }
          },
          repl_open_cmd = require('iron.view').split.vertical.botright(50),
        },
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
      })
    end
  },
  { "tbastos/vim-lua" },
  -- semshi 제거 (Python 3.12 호환성 문제)
  -- { "numirias/semshi", build = ":UpdateRemotePlugins" },

  -- LSP 진단 UI 개선
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
    end
  },
})

-- LSP 키 매핑
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- 기타 설정들
-- CtrlP 설정
vim.g.ctrlp_show_hidden = 0
vim.g.ctrlp_map = '<c-p>'
vim.g.ctrlp_custom_ignore = {
  dir = '\\.git$\\|public$\\|log$\\|tmp$\\|vendor$',
  file = '\\v\\.(exe|so|dll|png|jpg)$'
}
vim.g.ctrlp_working_path_mode = 'r'
vim.g.ctrlp_cache_dir = vim.env.HOME .. '/.cache/ctrlp'
if vim.fn.executable('ag') == 1 then
  vim.g.ctrlp_user_command = 'ag %s -l --nocolor -g ""'
end
vim.g.ctrlp_clear_cache_on_exit = 0

-- Undotree 설정
if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undodir = vim.env.HOME .. '/.vim/.undodir/'
  vim.opt.undofile = true
end
vim.keymap.set('n', '<leader>ut', ':UndotreeToggle<CR>:UndotreeFocus<CR>')

-- ShowMarks 설정
vim.keymap.set('n', '<leader>m', ':DoShowMarks<CR>')
vim.keymap.set('n', 'dm', ':execute "delmarks ".nr2char(getchar())<CR>')

-- ctrlp-obsession 설정
vim.keymap.set('n', '<leader>ss', ':CtrlPObsession<CR>')

-- 트루컬러 지원 설정 (tmux 내에서도 색상이 제대로 나오도록)
if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

-- tmux 내에서 실행 중인지 확인하고 추가 설정
if vim.env.TMUX then
  -- tmux에서 트루컬러를 위한 추가 설정
  vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  ]])
end

-- 테마 설정
vim.g.seoul256_background = 235
vim.cmd.colorscheme('seoul256')

-- 비활성 창을 더 어둡게 (seoul256 테마 이후에 적용)
vim.cmd([[
  highlight NormalNC guibg=#121212 ctermbg=233
  highlight EndOfBuffer guibg=#121212 ctermbg=233
  highlight WinSeparator guifg=#585858 guibg=#121212 ctermfg=240 ctermbg=233
  highlight VertSplit guifg=#585858 guibg=#121212 ctermfg=240 ctermbg=233
]])

-- Bufferline 하이라이트 수동 설정 (테마가 덮어쓰는 것 방지)
vim.cmd([[
  " 활성 버퍼
  highlight BufferLineBufferSelected guifg=#ffffff guibg=#3a3a3a gui=bold
  highlight BufferLineNumbersSelected guifg=#ffaf00 guibg=#3a3a3a gui=bold
  highlight BufferLineIndicatorSelected guifg=#ff5f00 guibg=#3a3a3a
  
  " 비활성 창의 버퍼
  highlight BufferLineBufferVisible guifg=#888888 guibg=#262626
  highlight BufferLineNumbersVisible guifg=#666666 guibg=#262626
  highlight BufferLineIndicatorVisible guifg=#444444 guibg=#262626
  
  " 배경 버퍼
  highlight BufferLineBackground guifg=#666666 guibg=#1c1c1c
  highlight BufferLineNumbers guifg=#444444 guibg=#1c1c1c
  
  " 탭라인 배경
  highlight BufferLineFill guibg=#1a1a1a
  highlight BufferLineTab guifg=#666666 guibg=#1c1c1c
  highlight BufferLineTabSelected guifg=#ffffff guibg=#3a3a3a gui=bold
]])

-- 활성 창 표시를 위한 설정
vim.opt.cursorline = true
vim.cmd([[
  highlight CursorLine guibg=#303030 ctermbg=236
  highlight CursorLineNr guifg=#ffaf00 ctermfg=214 gui=bold cterm=bold
]])

-- 창 이동 시 커서라인 토글
vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
  callback = function()
    vim.opt_local.cursorline = true
    vim.opt_local.relativenumber = true
  end
})

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.relativenumber = false
  end
})

-- 진단 설정
vim.diagnostic.config({
  virtual_text = false,  -- 기본 가상 텍스트는 끄고
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  -- 중복 진단 필터링
  float = {
    source = "always",  -- 진단 소스 표시
    format = function(diagnostic)
      -- 이미 소스가 메시지에 포함되어 있으면 그대로 사용
      if diagnostic.message:match("^" .. diagnostic.source .. ":") then
        return diagnostic.message
      else
        return string.format("%s: %s", diagnostic.source, diagnostic.message)
      end
    end,
  },
})

-- 커서가 멈췄을 때 자동으로 진단 메시지 표시
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- 커서 대기 시간 설정 (300ms)
vim.o.updatetime = 300

-- 진단 관련 편리한 키매핑
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "진단 메시지 보기" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "이전 진단으로" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "다음 진단으로" })