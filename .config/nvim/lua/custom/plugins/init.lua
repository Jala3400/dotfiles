-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Bufferline keybindings
vim.keymap.set('n', '<A-<>', '<Cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A->>', '<Cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '<Cmd>BufferLinePick<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>P', '<Cmd>BufferLinePickClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader><Tab>', '<Cmd>b#<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader><S-Tab>', '<Cmd>bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>0', '<Cmd>BufferLineGoToBuffer 10<CR>', { noremap = true, silent = true })

return {
  {
    'mbbill/undotree',
    keys = {
      { '<leader>ut', '<cmd>UndotreeToggle<cr>', desc = 'Toggle Undotree' },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_DiffCommand = 'FC'
    end,
  },

  {
    'declancm/cinnamon.nvim',
    version = '*', -- use latest release
    opts = {
      keymaps = {
        basic = true,
        extra = true,
      },
      options = {
        -- The scrolling mode
        -- `cursor`: animate cursor and window scrolling for any movement
        -- `window`: animate window scrolling ONLY when the cursor moves out of view
        mode = 'cursor',

        -- Only animate scrolling if a count is provided
        count_only = false,

        -- Delay between each movement step (in ms)
        delay = 5,
        max_delta = {
          line = false, -- Maximum distance for line movements before scroll animation is skipped
          column = false, -- Maximum distance for column movements before scroll animation is skipped
          time = 200, -- Maximum duration for a movement (in ms)
        },
        step_size = {
          -- Number of cursor/window lines moved per step
          vertical = 1,
          -- Number of cursor/window columns moved per step
          horizontal = 2,
        },
      },
    },
  },

  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git' },
    keys = {
      { '<leader>gs', ':Git<CR>', desc = 'Git status' },
      { '<leader>gc', ':Git commit<CR>', desc = 'Git commit' },
      { '<leader>gp', ':Git push<CR>', desc = 'Git push' },
      { '<leader>gl', ':Git pull<CR>', desc = 'Git pull' },
      { '<leader>gd', ':Gvdiffsplit<CR>', desc = 'Git diff' },
      { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
      { '<leader>glo', ':Glog<CR>', desc = 'Git log' },
      { '<leader>gB', ':GBrowse<CR>', desc = 'Git browse' },
      { '<leader>gS', ':Git add %<CR>', desc = 'Stage current file' },
      { '<leader>gU', ':Git reset -q %<CR>', desc = 'Unstage current file' },
      { '<leader>gX', ':Git reset --hard<CR>', desc = 'Discard changes' },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            file_status = true,
          },
        },
      },
      options = {
        icons_enabled = false,
        theme = 'vscode',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        numbers = 'ordinal',
        custom_filter = function(buf_number, buf_numbers)
          -- Hide the current directory buffer
          local buf_name = vim.fn.bufname(buf_number)
          return vim.fn.isdirectory(buf_name) ~= 1
        end,
      },
    },
  },

  -- nvim v0.8.0
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>do', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
      { '<leader>dc', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
      { '<leader>dt', '<cmd>DiffviewToggleFiles<cr>', desc = 'Toggle Diffview Files' },
      { '<leader>df', '<cmd>DiffviewFocusFiles<cr>', desc = 'Focus Diffview Files' },
      { '<leader>dh', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview History' },
    },
    config = function()
      require('diffview').setup {
        enhanced_diff_hl = true,
        use_icons = false,
      }
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context' },

  { 'rhysd/clever-f.vim' },
}
