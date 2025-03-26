return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.config
    opts = {
      keymap = { preset = 'super-tab' },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'nerd font mono' or 'normal' for 'nerd font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
      -- Fix preselect following blink documentation when keymap preset is 'super-tab'
      completion = {
        list = {
          selection = {
            preselect = function(ctx) return not require('blink.cmp').snippet_active({ direction = 1 }) end,
            auto_insert = true
          }
        }
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama" },
          agent = { adapter = "ollama" },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = "qwq:32b",
                },
              },
            })
          end,
        },
      })
    end,
  }
}
-- vim: ts=2 sts=2 sw=2 et
