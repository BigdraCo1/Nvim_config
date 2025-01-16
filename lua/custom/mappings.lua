local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    },
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    },
  }
}

M.dap_csharp = {
  plugin = true,
  n = {
    ["<leader>dcr"] = {
      function()
        -- Customize this function if needed for specific C# project actions.
        require('dap').continue()
      end,
      "Run C# debugger"
    },
    ["<leader>dcb"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dcv"] = {
      function()
        local widgets = require('dap.ui.widgets')
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "View C# debugging scopes"
    },
    ["<leader>dcc"] = {
      function()
        require('dap').terminate()
      end,
      "Stop debugging"
    },
  }
}


M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

M.dotnet = {
  plugin = true,
  n = {
    ["<leader>dbuild"] = {
      function()
        vim.cmd("w") -- Save the current file
        vim.fn.jobstart("dotnet build", { stdout_buffered = true, on_stdout = function(_, data)
          if data then print(table.concat(data, "\n")) end
        end })
      end,
      "Build .NET project"
    },
    ["<leader>drun"] = {
      function()
        vim.cmd("w") -- Save the current file
        vim.fn.jobstart("dotnet run", { stdout_buffered = true, on_stdout = function(_, data)
          if data then print(table.concat(data, "\n")) end
        end })
      end,
      "Run .NET project"
    },
  }
}

return M
