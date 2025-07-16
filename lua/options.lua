-- [[ Setting options ]]

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Hide command line & disable status bar
vim.o.cmdheight = 0
vim.opt.laststatus = 0

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- disable nvim intro
vim.opt.shortmess:append 'sI'

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Support folding via treesitter. Simply type za to fold/unfold current block
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 9
vim.o.foldenable = false
vim.o.foldtext = ''
vim.o.fillchars = 'fold: '

-- Remove '~' signs when we reach end of file
vim.api.nvim_create_autocmd("VimEnter",{
  callback = function()
    vim.opt.fillchars = { eob = ' ' }
  end
})

-- If no file or folder is specified, startup by showing list of recent files
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Based on https://github.com/neovim/neovim/issues/25369#issuecomment-1734660214
    if vim.api.nvim_buf_get_offset(0, 0) <= 0 then
      local handle = io.open(vim.api.nvim_buf_get_name(0))
      if handle == nil then
        require('telescope').extensions.recent_files.pick()
      end
    end
  end,
})
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- vim: ts=2 sts=2 sw=2 et
