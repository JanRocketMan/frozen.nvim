return {{
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = {
            source_filetype = 'python',
          },
        })
      end
    end
    -- A simple config to debug via attach
    -- Simply run `python -m debugpy --listen 5678 --wait-for-client`
    -- To start it
    dap.configurations.python = {
      {
        type = 'python',
        request = 'attach',
        name = 'Attach remote',
        justMyCode = false,
        connect = function()
          return {
            host = '127.0.0.1',
            port = 5678,
            justMyCode = false,
          }
        end,
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      controls = {enabled = false},
      layouts = { {
        elements = {{
          id = "scopes",
          size = 1.0
        }},
        position = "left",
        size = 40
      }, {
        elements = {{
          id = "repl",
          size = 1.0
        }},
        position = "bottom",
        size = 20
      } },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
},
}
