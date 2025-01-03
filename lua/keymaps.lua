-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- WARNING!!! It's recommended to keep ALL your keymaps here, in a single file
-- Otherwise it may be tedious to keep track of them

-- Clear higlhight on search by pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Toggle line numbers (they are disabled by default)
vim.keymap.set('n', '<leader>l', '<cmd>let &nu = !&nu<CR>', { desc = 'Toggle [l]ine numbers' })
-- A set of awesome mappings inspired by the @ThePrimeagen config
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move [U]p with centering' })
vim.keymap.set('n', '<PageUp>', '<C-u>zz', { desc = 'Move [U]p with centering' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move [D]own with centering' })
vim.keymap.set('n', '<PageDown>', '<C-d>zz', { desc = 'Move [D]own with centering' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Goto next with centering' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Goto prev with centering' })
vim.keymap.set({'n', 'x', 'o'}, '<leader>r', '"hy:%s/<C-r>h//g<left><left>', { desc = '[R]eplace all occurences of current selection in current buffer' })

-- Some list of other convenient remaps for default keys
-- Disable yanking of deleted text in normal mode
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'x', '"_x')
-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP')

-- Use fast navigation w flash
vim.keymap.set({'n', 'x', 'o'}, 's', function() require('flash').jump() end, {desc = "Flash jump"})
vim.keymap.set({'n', 'x', 'o'}, 'R', function() require('flash').treesitter() end, {desc = "Flash jump treesitter"})

-- File manipulation hotkeys
vim.keymap.set('n', '<leader>i', vim.cmd.write, { desc = 'Wr[i]te current file' })
vim.keymap.set('n', '<leader>ti', function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
end, { desc = 'Toggle autoformatting'})
vim.keymap.set('n', '<leader>q', function() vim.cmd('q!') end, { desc = 'E[x]it current buffer without saving' })
vim.keymap.set('n', '<leader>o', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
  require('mini.files').reveal_cwd()
end, { desc = '[O]pen file tree for current buffer' })
vim.keymap.set('n', 'Q', function() require('mini.files').close() end, { desc = 'Close minifiles buffer' })
vim.keymap.set('n', '<leader>wh', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy absolute path of current file to buffer'})

-- Code folding is supported via treesitter. Simply type za to fold/unfold current region
-- Toggle visual selection comments by typing gc

-- A set of telescope keymaps. See `:help telescope.builtin`
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').find_files() end, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>s', function() require('telescope.builtin').live_grep() end, { desc = '[S]earch by grep' })
vim.keymap.set('n', '<leader>n', function() 
  require('telescope').extensions.recent_files.pick()
end, { desc = 'Search Recent Files' })
vim.keymap.set('n', '<leader><leader>', function() require('telescope.builtin').buffers() end, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.api.nvim_set_keymap('n', '<leader>;', ':Telescope cmdline<CR>', { noremap = true, desc = "Open cmdline in telescope" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<S-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<S-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<S-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<S-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Cycle through quickfix list items
vim.keymap.set('n', ']e', '<Cmd>try | cnext | catch | cfirst | catch | endtry<CR>', { desc = "Goto next quickfix item"})
vim.keymap.set('n', '[e', '<Cmd>try | cprevious | catch | clast | catch | endtry<CR>', {desc = "Goto prev quickfix item"})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>k', vim.diagnostic.setqflist, { desc = 'Open diagnostic [k]uickfix list' })

-- Zettelkasten keymaps
vim.keymap.set('n', '<leader>tn', function()
  note_name = vim.fn.input 'Note name: '
  if note_name ~= '' then
    vim.cmd('ObsidianNew ' .. note_name)
    vim.cmd.write()
  end
end, {desc = 'Create a new Obsidian note and save it'})
vim.keymap.set('n', '<leader>tb', ':ObsidianBacklinks<CR>', {desc = 'Open backlinks of current note'})
vim.keymap.set('v', '<leader>tl', ':ObsidianLink .md<CR>', {desc = 'Link current selection to existing note'})
vim.keymap.set('v', '<leader>te', ':ObsidianExtractNote<CR>', {desc = 'Extract current selection into a new note'})
vim.keymap.set('n', '<leader>to', ':ObsidianOpen<CR>', {desc = 'Open current note in Obsidian app'})

-- Keymaps for git plugins
vim.keymap.set('n', '<leader>g', function() require('neogit'):open() end, { desc = 'Open neo[g]it window'})
vim.keymap.set('v', '<leader>hl', function() require("git-log").check_log() end, { desc = 'Show git log of current selection'})

-- Basic debugging keymaps
vim.keymap.set('n', '<F4>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F5>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>B', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Conditional [B]reakpoint' })

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F8>', function() require('dapui').toggle() end, { desc = 'Debug: See last session result.' })

-- Fix __repr__ attributes for pytorch Tensors to improve stack readability during debugging
vim.keymap.set('n', '<leader>td', function()
  require('dap.repl').execute('import torch; torch.Tensor.__repr__ = lambda self: f"[{self.min().float():.1f}, {self.max().float():.1f}], {self.shape}, {self.dtype}, {self.device}"')
end, { desc = 'Toggle Py[t]orch [d]ebug __repr__'})
vim.keymap.set('n', '<leader>tp', function()
  require('dap.repl').execute('from torchvision.utils import save_image as si')
end, { desc = '[T]oggle [P]ytorch visualization utils'})

vim.keymap.set({'n', 'v'}, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- vim: ts=2 sts=2 sw=2 et
