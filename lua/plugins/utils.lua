return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Better Around/Inside textobjects
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - ci'  - [C]hange [I]nside [']quote
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
  -- File explorer
  { 'echasnovski/mini.files', opts = {
    mappings = {
      close = '<ESC>',
      go_in = 'n',
      go_in_plus = '<Enter>',
      go_out = 't',
      go_out_plus = '<BS>',
      reset = 'q',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = '=',
      trim_left = '<',
      trim_right = '>',
    },}
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end 
  },
  -- Set default colorscheme
  {
    'tomasiser/vim-code-dark',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'codedark'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- Fast navigation in the current buffer
  -- This is a hotfix repo that will exist until
  -- https://github.com/folke/flash.nvim/pull/283 is merged
  {
    'JanRocketMan/flash.nvim',
    event = "VeryLazy",
    -- Add autojumps if match is single, add support of single-key motions (f/F and t/T)
    ---@type Flash.Config
    opts = {
      jump = {autojump = true},
      modes = {char = {jump_labels = true, multi_line = false, jump = {autojump = true}}}
    },
    -- stylua: ignore
  },
  -- Add support for multiple cursors
  {
    "brenton-leighton/multiple-cursors.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Show spaces as dots in visual mode
  {
   'mcauley-penney/visual-whitespace.nvim',
    opts = {nl_char = '', cr_char = ''},
    config = true
  },
  -- change current directory within neovim
  {
    'LintaoAmons/cd-project.nvim',
    event = "VeryLazy",
    opts = {},
  },
  -- Show pending keybinds.
  {'folke/which-key.nvim', config = function() require('which-key').setup() end},
}
