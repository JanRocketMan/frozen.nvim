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
  -- Display function signature as you type it
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {hint_enable = false, handler_opts = {border = 'none'}},
    config = function(_, opts)
      require'lsp_signature'.setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
            return
          end
          require("lsp_signature").on_attach(opts, bufnr)
      end,
      })
    end
  }
}
-- vim: ts=2 sts=2 sw=2 et
