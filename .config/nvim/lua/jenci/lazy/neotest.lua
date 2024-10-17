return {
    "nvim-neotest/neotest",
    dependencies = {
        'mfussenegger/nvim-dap',
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        "rouge8/neotest-rust",
        "marilari88/neotest-vitest",
        "lawrence-laz/neotest-zig",
        "alfaix/neotest-gtest",
        "mrcjkb/neotest-haskell",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-vitest"),
                require("neotest-plenary"),
                require("neotest-python"),
                require("neotest-rust"),
                require("neotest-zig"),
                require("neotest-gtest"),
                require("neotest-haskell"),
            },
            discovery = {
                filter_dir = function(name, rel_path, root)
                    return name ~= "env"
                end,
            }
        })

        local path = vim.fn.expand("%")
        -- General level
        vim.keymap.set("n", "<leader>ns", function()
            neotest.summary.toggle()
        end)

        vim.keymap.set("n", "<leader>rl", function()
            neotest.run.run_last({strategy = 'dap'})
        end)

        vim.keymap.set("n", "<leader>nr", function()
            neotest.run.run({strategy = 'dap'})
        end)

        vim.keymap.set("n", "<leader>no", function()
            neotest.output.open({
                enter = true,
                last_run = true,
                auto_close = true,
            })
        end)

        -- Path level
        vim.keymap.set("n", "<leader>nir", function()
            neotest.run.run({
                path,
                strategy = 'dap'
            })
        end)
    end,
}
