return {
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'python' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- Rainbow parentheses for convenicency
  'HiPhish/rainbow-delimiters.nvim',
  -- Shows current function definition on top via treesitter
  -- Note that it doesn't add any movements (we have textobjects for this)
  --{
  --  'nvim-treesitter/nvim-treesitter-context',
  --  opts = {
  --    max_lines = 1,
  --    min_window_height = 10,
  --    tree_scope = 'inner',
  --  },
  -- },
  -- Add motions to jump to current function definition
  'nvim-treesitter/nvim-treesitter-textobjects',
}
-- vim: ts=2 sts=2 sw=2 et
