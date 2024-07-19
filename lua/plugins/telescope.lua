-- Fuzzy Finder (files, lsp, etc)
return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Run terminal commands in telescope
      {'jonarrien/telescope-cmdline.nvim'},
      -- More convenient recent files display
      {"smartpde/telescope-recent-files"},
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function(_, opts)
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['recent_files'] = {
            include_current_file = false,
            only_cwd = true,
          },
          -- Reduce height of history window in telescope cmdline
          ['cmdline'] = {
            picker = {layout_config = {height = 10}}
          },
        },
        defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
          -- Exit telescope with single <Esc> since I don't need normal mode
          mappings = {
             i = { ["<Esc>"] = "close" },
          },
        })
      }

     -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'cmdline')
      pcall(require('telescope').load_extension, 'recent_files')

    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
