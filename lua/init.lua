-- Configuration for minimal version of frozen.nvim that doesn't use lazy or any plugins
-- You can use it as a drop-in replacement for large files with `nvim -u`
-- 1. [[ Setting options ]]

-- Set leader keys, enable nerd font, disable highlight of current line
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.cursorline = false

-- Enable mouse, hide status and minimize cmd bar, hide any bar stats
vim.opt.mouse = 'a'
vim.o.cmdheight = 1
vim.o.ruler = false
vim.o.showcmd = false
vim.opt.showmode = false
vim.o.laststatus = 0
vim.o.cmdwinheight = 1

-- Support indents in multi-line strings, keep the undo history for buffer with file if we close it
vim.opt.breakindent = true
vim.o.undofile = true

-- Use OS clipboard and fix pasting errors when copying over ssh/tmux sessions. See https://github.com/neovim/neovim/discussions/28010#discussioncomment-987749
vim.o.clipboard = 'unnamedplus'
local osc52 = require('vim.ui.clipboard.osc52')
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end
if (os.getenv('SSH_TTY') ~= nil)
then
  vim.g.clipboard = {
     name = 'OSC 52',
     copy = {
       ['+'] = osc52.copy('+'),
       ['*'] = osc52.copy('*'),
     },
     paste = {
       ['+'] = paste,
       ['*'] = paste,
     },
  }
end

-- Improve search, reduce update time
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.cursorhold = 50
vim.opt.path:append("**")

-- Improve symbols repr
vim.opt.list = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.opt.signcolumn = 'no'
vim.opt.splitbelow = true

-- Replace tabs with four spaces when you write them in insert mode or for indentations
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

-- Remove startup message, enable live substitutions, highlight on yank
vim.opt.shortmess:append 'sI'
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- disable global shada; create separate shadafile for each workspace
local workspace_path = vim.fn.getcwd()
local cache_dir = vim.fn.stdpath("data")
local unique_id = vim.fn.fnamemodify(workspace_path, ":t") ..
    "_" .. vim.fn.sha256(workspace_path):sub(1, 8) ---@type string
local file = cache_dir .. "/shadas/" .. unique_id .. ".shada"
vim.opt.shadafile = file

-- Show recent files within current dir when we open neovim without any files
-- Note this requires us to set `recent_files_picker` function which we do below
vim.api.nvim_create_autocmd("VimEnter", {
  group = minimal_group,
  callback = function()
    if vim.api.nvim_buf_get_offset(0, 0) <= 0 then
      local handle = io.open(vim.api.nvim_buf_get_name(0))
      if handle == nil then
        recent_files_picker()
      end
    end
  end,
})

-- 2. [[ Basic Keymaps ]]

-- Disable copy when we delete/change symbols from normal mode, keep last yanked when pasting
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('v', 'p', '"_dP')

-- Clear cmd messages and highlight on Esc
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>:echo ""<CR>')

-- Add nice half-page jumps inspired by the @ThePrimeagen config
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move [U]p with centering' })
vim.keymap.set('n', '<PageUp>', '<C-u>zz', { desc = 'Move [U]p with centering' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move [D]own with centering' })
vim.keymap.set('n', '<PageDown>', '<C-d>zz', { desc = 'Move [D]own with centering' })

-- Save file wo messages, close buffer/window/tab
vim.keymap.set('n', '<leader>i', ':w<CR>:echo ""<CR>', { desc = 'Wr[i]te current file' })
vim.keymap.set('n', '<leader>d', ':bd<CR>:echo ""<CR>', { desc = '[D]elete current buffer' })
vim.keymap.set('n', '<leader>q', ':q!<CR>', { desc = '[Q]uit current window' })
vim.keymap.set('n', '<leader>x', ':tabclose<CR>', { desc = 'E[x]it current tab' })

-- Search files
vim.keymap.set('n', '<leader>f', ':find ', { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>o', function()
  vim.cmd('Ex | sil! /' .. vim.fn.expand('%:t'))
  vim.cmd('nohlsearch')
end, { desc = '[O]pen file tree for current buffer' })

-- Replace in current buffer
vim.keymap.set({'n', 'x', 'o'}, '<leader>r', '"hy:%s/<C-r>h//g<left><left>', { desc = '[R]eplace all occurences of current selection in current buffer' })

-- Buffer navigation
vim.keymap.set('n', '<leader>n', ':bn<CR>:echo ""<CR>', { desc = 'Goto [n]ext buffer' })
vim.keymap.set('n', '<leader>p', ':bp<CR>:echo ""<CR>', { desc = 'Goto [p]revious buffer' })

-- Load current file path to clipboard, execute terminal command with scratch buffer
vim.keymap.set('n', '<leader>y', function() vim.fn.setreg('+', vim.fn.expand('%:p')) vim.fn.setreg('"', vim.fn.expand('%:p')) end, { desc = 'Cop[y] to clipboard current path' })
vim.keymap.set('n', '<leader>c', function()
  vim.ui.input({}, function(c)
    if c and c ~= "" then
      c = 'bash -i -c "source ~/.bashrc && ' .. c .. '"'
      vim.cmd('nos ene | setl bt=nofile bh=wipe')
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
    end
  end)
end, { desc = 'Execute terminal [c]ommand and drop result to scratch buffer' })

-- Toggle diagnostic messages in current buffer in quickfix list
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.setloclist({ open = false }) -- don't open and focus
  local window = vim.api.nvim_get_current_win()
  local qf_winid = vim.fn.getloclist(window, { winid = 0 }).winid
  if qf_winid > 0 then
    vim.cmd('lclose')
  else
    vim.diagnostic.setloclist()
  end
  vim.api.nvim_set_current_win(window) -- restore focus to current window
end, { desc = 'Toggle diagnostic [e]rror list' })
-- Jump between error messages if opened in quickfix list
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous [e]rror message' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next [e]rror message' })

-- Toggle autoformatting (disabled by default)
vim.g.disable_autoformat = true
vim.keymap.set('n', '<leader>ti', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
end, { desc = 'Toggle autoformatting'})

-- Toggle lsp messages (disabled by default)
vim.diagnostic.enable(false)
vim.keymap.set('n', '<leader>to', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {desc = "[To]ggle diagnostic messages and signs"})

-- Apply minimal mode settings
vim.cmd('syntax off | highlight Normal guibg=#2a2a2a guifg=#b8a583')
local minimal_group = vim.api.nvim_create_augroup("MinimalMode", { clear = true })
function recent_files_picker()
  vim.cmd("normal! '0")
  vim.cmd("1b")
  vim.cmd("bd")
end
vim.api.nvim_create_autocmd("BufEnter", {group = minimal_group, callback = function() vim.treesitter.stop() end})

-- vim: ts=2 sts=2 sw=2 et
