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

-- 클립보드 설정 (SSH/tmux 환경 지원)
vim.opt.clipboard = "unnamedplus"  -- 시스템 클립보드 사용
-- SSH 환경에서 원격 클립보드 지원을 위한 설정
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  -- SSH 환경일 때 tmux 클립보드 통합
  if vim.env.TMUX then
    vim.g.clipboard = {
      name = "tmux",
      copy = {
        ["+"] = {"tmux", "load-buffer", "-"},
        ["*"] = {"tmux", "load-buffer", "-"},
      },
      paste = {
        ["+"] = {"tmux", "save-buffer", "-"},
        ["*"] = {"tmux", "save-buffer", "-"},
      },
      cache_enabled = true,
    }
  end
end

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
vim.keymap.set('n', '<C-l>', function()
  vim.cmd('SignifyToggle')
  vim.cmd('set nonumber!')
  vim.cmd('IndentLinesToggle')
  -- LSP 진단 표시 토글
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end)
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
      
      for _, server_name in ipairs(servers) do
        if server_name == "pyright" then
          lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                }
              }
            }
          })
        elseif server_name == "lua_ls" then
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
        else
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end
      end
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
          -- 진단 비활성화 (pyright와 충돌 방지)
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
    dependencies = 'nvim-tree/nvim-web-devicons',
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
  { "blueyed/vim-diminactive" },
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
  { "numirias/semshi", build = ":UpdateRemotePlugins" },

  -- OSC 52 클립보드 지원 (SSH 원격 세션용)
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0,      -- 길이 제한 없음
        silent = false,      -- 메시지 표시
        trim = false,        -- 공백 제거 안함
      })
      
      -- OSC52 복사를 위한 키매핑
      local function copy()
        if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
          require('osc52').copy_register('+')
        end
      end
      
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = copy
      })
      
      -- Visual 모드에서 선택한 텍스트 복사
      vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
    end
  },

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

-- 테마 설정
vim.g.seoul256_background = 235
vim.cmd.colorscheme('seoul256')