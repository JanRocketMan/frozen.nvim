return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Fast navigation in the current buffer
  {
    'folke/flash.nvim',
    event = "VeryLazy",
    -- Add autojumps if match is single, add support of single-key motions (f/F and t/T)
    -- Also disable background highlighting
    ---@type Flash.Config
    opts = {
      jump = {autojump = false},
      modes = {
        char = {enabled = false}
      },
      label = {uppercase = false},
      highlight = {backdrop = false, matches = false}
    },
    -- stylua: ignore
  },
  -- Show pending keybinds.
  {'folke/which-key.nvim', config = function() require('which-key').setup() end},
  -- Revert changes even without git
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  -- Navigate between class methods more conveniently
  {
  "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {enable = true },
        ui_select = { enable = false },
        colorscheme = { enable = false },
      })
      -- === Suggested Keymaps: ===
      vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
        desc = "Colorscheme Picker",
        silent = true,
      })
    end,
  },
}
