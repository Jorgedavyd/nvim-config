return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        "jbyuki/one-small-step-for-vimkind",
        "mrcjkb/rustaceanvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        require("mason-tool-installer").setup({
            ensure_installed = {"codelldb", "debugpy"}
        })

        require("dap-python").setup("/usr/bin/python3.12")

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
            },
        }

        dap.configurations.rust = dap.configurations.cpp
        dap.configurations.zig = dap.configurations.cpp
        dap.configurations.cuda = dap.configurations.cpp
        dap.configurations.c = dap.configurations.cpp

        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)
        vim.keymap.set("n", "<space>?", function()
            dapui.eval(nil, { enter = true })
        end)
        vim.keymap.set("n", "<F1>", dap.continue)
        vim.keymap.set("n", "<F2>", dap.step_into)
        vim.keymap.set("n", "<F3>", dap.step_over)
        vim.keymap.set("n", "<F4>", dap.step_out)
        vim.keymap.set("n", "<F5>", dap.step_back)
        vim.keymap.set("n", "<F13>", dap.restart)

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
