return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Better Around/Inside textobjects
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - ci'  - [C]hange [I]nside [']quote
  { 'echasnovski/mini.ai', opts = { n_lines = 500 } },
  -- File explorer
  { 'echasnovski/mini.files', opts = {
    mappings = {
      close = '<ESC>',
      go_in_plus = '<Enter>',
      go_out_plus = '<BS>',
      reset = 'rs',
    },}
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end 
  },
  -- Set default colorscheme
  {
    'tomasiser/vim-code-dark',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'codedark'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- Fast navigation in the current buffer
  -- This is a hotfix repo that will exist until
  -- https://github.com/folke/flash.nvim/pull/283 is merged
  {
    'JanRocketMan/flash.nvim',
    event = "VeryLazy",
    -- Add autojumps if match is single, add support of single-key motions (f/F and t/T)
    -- Also disable background highlighting
    ---@type Flash.Config
    opts = {
      jump = {autojump = true},
      modes = {
        char = {
          jump_labels = true,
          multi_line = false,
          jump = {autojump = true}, highlight = {backdrop = false}
        }
      },
      highlight = {backdrop = false}
    },
    -- stylua: ignore
  },
  -- Show spaces as dots in visual mode
  {
   'mcauley-penney/visual-whitespace.nvim',
    opts = {nl_char = '', cr_char = ''},
    config = true
  },
  -- Show pending keybinds.
  {'folke/which-key.nvim', config = function() require('which-key').setup() end},
  -- Create notes with obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy=true,
    ft='markdown',
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/obsidian",
        }
      },
      templates = {
        folder = '~/obsidian/templates',
      },
      new_notes_location="current_dir",
      picker = {
        mappings = {
          new = "<C-o>",
          insert_link = "<C-l>",
        },
      },
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.date('%d-%m-%Y')) .. "-" .. suffix
      end,
      note_path_func = function(spec)
        local path = spec.dir / spec.title
        return path:with_suffix(".md")
      end,
    },
  }
}
