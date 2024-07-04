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
  {
    'folke/flash.nvim',
    event = "VeryLazy",
    ---@type Flash.Config
    opts = { jump = {autojump = true}},
    -- stylua: ignore
  },
  -- Show pending keybinds.
  {'folke/which-key.nvim', config = function() require('which-key').setup() end},
}
