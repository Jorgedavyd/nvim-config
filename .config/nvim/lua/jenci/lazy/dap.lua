return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "jbyuki/one-small-step-for-vimkind",
        "mrcjkb/rustaceanvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup({dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}})
        require("mason-tool-installer").setup({ ensure_installed = {"codelldb", "debugpy", "delve"}})
        require("dap-python").setup("/usr/bin/python3.12")
        require("nvim-dap-virtual-text").setup({})
        dap.configurations.lua = {
            {
                type = "nlua",
                request = "attach",
                name = "Attach to running Neovim instance",
            },
        }
        dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
        end
        -- C, C++, Rust, Zig, CUDA setup
        dap.adapters.lldb = {
          type = 'executable',
          command = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/bin/codelldb"),
          name = 'lldb'
        }
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
        dap.configurations.zig = dap.configurations.cpp
        dap.configurations.cuda = dap.configurations.cpp
        require('dap-go').setup()
        -- Keymaps
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>cB', dap.clear_breakpoints)
        vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)
        vim.keymap.set('n', '<leader>cb', function ()
            vim.ui.input({prompt = "Condition: "}, function (condition)
                dap.toggle_breakpoint(condition)
            end)
        end)
        vim.keymap.set("n", "<space>?", function()
            dapui.eval(nil, { enter = true })
        end)
        vim.keymap.set("n", "<F1>", dap.continue)
        vim.keymap.set("n", "<F2>", dap.step_into)
        vim.keymap.set("n", "<F3>", dap.step_over)
        vim.keymap.set("n", "<F4>", dap.step_out)
        vim.keymap.set("n", "<F5>", dap.step_back)
        vim.keymap.set("n", "<F6>", dap.restart)
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
}
