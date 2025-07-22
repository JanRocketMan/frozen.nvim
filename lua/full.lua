-- 3. [[Apply full mode settings]]

vim.cmd('syntax on')
vim.api.nvim_clear_autocmds({ group = "MinimalMode" })
vim.opt.signcolumn = 'no'
function recent_files_picker()
  require('telescope').extensions.recent_files.pick()
end

-- 4. [[Add plugin keymaps]]

-- Use fast navigation w flash
vim.keymap.set({'n', 'x', 'o'}, 's', function() require('flash').jump() end, {desc = "Flash jump"})
vim.keymap.set({'n', 'x', 'o'}, 'R', function() require('flash').treesitter() end, {desc = "Flash jump treesitter"})

-- Manipulate files with mini.files
vim.keymap.set('n', '<leader>o', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
  require('mini.files').reveal_cwd()
end, { desc = '[O]pen file tree for current buffer' })
vim.keymap.set('n', 'Q', function() require('mini.files').close() end, { desc = 'Close minifiles buffer' })

-- Use telescope to search for files, words and jump between recent files
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').find_files() end, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>s', function() require('telescope.builtin').live_grep() end, { desc = '[S]earch by grep' })
vim.keymap.set('n', '<leader>n', function()
  require('telescope').extensions.recent_files.pick()
end, { desc = 'Search Recent Files' })

-- Keymaps for git plugins
vim.keymap.set('n', '<leader>g', function() require('neogit'):open() end, { desc = 'Open neo[g]it window'})
vim.keymap.set('v', '<leader>hl', function() require("git-log").check_log() end, { desc = 'Show git log of current selection'})

-- Basic debugging keymaps
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<F4>', function()
  require('dap').toggle_breakpoint()
  require("debugmaster").mode.toggle({nowait=true})
  require('dap').continue()
end, { desc = 'Start debugging' })
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Continue' })

-- Fix __repr__ attributes for pytorch Tensors to improve stack readability during debugging
vim.keymap.set('n', '<leader>td', function()
  require('dap.repl').execute('import torch; torch.Tensor.__repr__ = lambda self: f"[{self.min().float():.1f}, {self.max().float():.1f}], {self.shape}, {self.dtype}, {self.device}"')
end, { desc = 'Toggle Py[t]orch [d]ebug __repr__'})
vim.keymap.set('n', '<leader>tp', function()
  require('dap.repl').execute('from torchvision.utils import save_image as si')
end, { desc = '[T]oggle [P]ytorch visualization utils'})

-- Keymaps for CodeCompanion
vim.keymap.set({'n', 'v'}, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
vim.cmd([[cab cc CodeCompanion]])
