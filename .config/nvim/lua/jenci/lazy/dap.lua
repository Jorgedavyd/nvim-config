return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'mfussenegger/nvim-dap-python',
        'julianolf/nvim-dap-lldb',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'rcarriga/nvim-dap-ui',
    },
    config = function ()
        local dap = require('dap')
        local ui = require('dapui')
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)
        vim.keymap.set("n", "<space>?", function()
            ui.eval(nil, { enter = true })
        end)
        vim.keymap.set("n", "<F1>", dap.continue)
        vim.keymap.set("n", "<F2>", dap.step_into)
        vim.keymap.set("n", "<F3>", dap.step_over)
        vim.keymap.set("n", "<F4>", dap.step_out)
        vim.keymap.set("n", "<F5>", dap.step_back)
        vim.keymap.set("n", "<F13>", dap.restart)

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end
}
