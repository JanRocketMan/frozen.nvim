-- 3. [[Apply full mode settings]]

vim.cmd('syntax on')
vim.api.nvim_clear_autocmds({ group = "MinimalMode" })
local min_mode_picker = recent_files_picker
function recent_files_picker()
  vim.defer_fn(function() min_mode_picker() end, 0)
end

-- Set default colorscheme
vim.cmd.colorscheme('codedark_yellow')
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function(args)
    vim.schedule(function()
      local ok, rd = pcall(require, 'rainbow-delimiters')
      if ok and rd then
        vim.cmd('doautocmd FileType')  -- trigger highlighting again
      end
    end)
  end,
})

-- Disable autoformatting by default
vim.g.disable_autoformat = true

-- 4. [[Add plugin keymaps]]

-- Use fast navigation w flash
-- We enable `s` keymap both in files and in netrw
vim.keymap.set({'n', 'x', 'o'}, 's', function() require('flash').jump() end, {desc = "Flash jump"})
local function set_flash_keymap()
  if vim.bo.filetype == 'netrw' then
    vim.keymap.set('n', 's', function() require('flash').jump() end, {buffer = true})
  end
end
vim.api.nvim_create_autocmd({"FileType", "BufEnter", "BufWinEnter"},
{
    pattern = '*',
    callback = function()
      vim.schedule(set_flash_keymap)
    end
})
vim.keymap.set({'n', 'x', 'o'}, 'R', function() require('flash').treesitter() end, {desc = "Flash jump treesitter"})

-- Save with autoformatting
vim.keymap.set('n', '<leader>ti', function()
  vim.g.disable_autoformat = false
  vim.cmd('w')
  vim.cmd('echo ""')
  vim.g.disable_autoformat = true
end, { desc = 'Save with autoformatting'})

-- Toggle diagnostic messages in current buffer in quickfix list
vim.keymap.set('n', '<leader>te', function()
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

-- Use telescope to search for files, words and jump between recent files
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').find_files() end, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>s', function() require('telescope.builtin').live_grep() end, { desc = '[S]earch by grep' })

-- Keymaps for git plugins
vim.keymap.set('n', '<leader>g', function() require('neogit'):open() end, { desc = 'Open neo[g]it window'})

-- Basic debugging keymaps
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<F4>', function()
  require('dap').toggle_breakpoint()
  require("debugmaster").mode.toggle({nowait=true})
  vim.cmd('lua vim.opt.signcolumn="yes"')
  require('dap').continue()
end, { desc = 'Start debugging' })
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Continue' })

-- Function to configure PyTorch tensor repr utils in DAP
local function configure_pytorch_debug_repr()
  require('dap.repl').execute('import sys; "torch" in sys.modules and setattr(sys.modules["torch"].Tensor, "__repr__", lambda self: f"{str(self.dtype).replace(\'torch.\', \'\')}{tuple(self.shape)}∈[{self.min().float():.2f}, {self.max().float():.2f}]@{str(self.device)}")')
  require('dap.repl').execute('import sys; si = sys.modules["torchvision.utils"].save_image if "torchvision.utils" in sys.modules else (lambda *a, **k: print("torchvision not available"))')
end

-- Auto-configure PyTorch repr when debugging starts
vim.api.nvim_create_autocmd("User", {
  pattern = {"LazyLoad", "VeryLazy"},
  callback = function()
    vim.defer_fn(function()
      -- Create autocmd for when REPL opens
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function()
          -- Wait for REPL to be ready then configure
          vim.defer_fn(configure_pytorch_debug_repr, 1000)
        end,
      })
    end, 100)
  end,
})
