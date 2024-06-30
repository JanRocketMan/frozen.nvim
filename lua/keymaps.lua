-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- WARNING!!! It's recommended to keep ALL your keymaps here, in a single file
-- Otherwise it may be tedious to keep track of them

-- Clear higlhight on search by pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Toggle line numbers
vim.keymap.set('n', '<leader>l', 
  '<cmd>let [&nu, &rnu] = [!&nu, !&rnu]<CR>',
  { desc = 'Toggle [l]ine numbers' }
)
-- Toggle visiual selection comments by typing gc

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- File manipulation hotkeys
vim.keymap.set('n', '<leader>i', vim.cmd.write, { desc = 'Save current f[I]le' })
vim.keymap.set('n', '<leader>x', vim.cmd.exit, { desc = 'Save file and e[x]it vim' })
vim.keymap.set('n', '<leader>o', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
  require('mini.files').reveal_cwd()
end, { desc = 'Open file [t]ree for current buffer' })
vim.keymap.set('n', '<leader>F', function() 
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = '[F]ormat buffer' })

-- A set of awesome mappings from @ThePrimeagen
vim.keymap.set('n', '<PageUp>', '<C-u>zz', { desc = 'Move [U]p with centering' })
vim.keymap.set('n', '<PageDown>', '<C-d>zz', { desc = 'Move [D]own with centering' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Goto next with centering' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Goto prev with centering' })
vim.keymap.set('n', '<leader>p', '"_dP', { desc = 'Paste while keeping buffer' })
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Multi-replace current word' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<M-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<M-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<M-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<M-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set({'n', 'x', 'o'}, '<leader>T', function() require("flash").toggle() end, {desc = '[T]oggle flash search' })


-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Folding is supported via treesitter. Simply type za to fold/unfold current region

-- Keymaps for git plugins
vim.keymap.set('n', '<leader>g', function() require('neogit'):open() end, { desc = 'Open neo[g]it window'})
vim.keymap.set('n', '<leader>hg', 
  function() local repo = vim.fn.input 'Repository name / URI: '
        if repo ~= '' then
          require('git-dev').open(repo)
        end
  end,
  { desc = 'Open remote repository' }
)

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>hh', function() require('telescope.builtin').help_tags() end, { desc = 'Search [h]elp' })
vim.keymap.set('n', '<leader>hk', function() require('telescope.builtin').keymaps() end, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>f', function() require('telescope.builtin').find_files() end, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>w', function() require('telescope.builtin').grep_string() end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>s', function() require('telescope.builtin').live_grep() end, { desc = 'Search by g[r]ep' })
vim.keymap.set('n', '<leader>.', function() require('telescope.builtin').oldfiles() end, { desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', function() require('telescope.builtin').buffers() end, { desc = 'Find existing buffers' })
vim.keymap.set('n', 's', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.api.nvim_set_keymap('n', ':', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })

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

-- vim: ts=2 sts=2 sw=2 et
