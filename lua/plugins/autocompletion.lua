return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      -- Display signature of function as you type it
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      cmp.setup {
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          -- Scroll the documentation window [b]ack / [f]orward
          ['<PageDown>'] = cmp.mapping.scroll_docs(-4),
          ['<PageUp>'] = cmp.mapping.scroll_docs(4),
          -- Accept and scroll through options
          ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
