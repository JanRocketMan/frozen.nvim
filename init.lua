require 'init'

-- Apply full mode settings
vim.cmd('syntax on')
vim.api.nvim_clear_autocmds({ group = "MinimalMode" })
vim.opt.signcolumn = 'auto'

require 'full'
require 'lazy-bootstrap'
require 'lazy-plugins'

-- vim: ts=2 sts=2 sw=2 et
