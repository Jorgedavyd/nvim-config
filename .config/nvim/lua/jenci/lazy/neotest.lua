return {
        "nvim-neotest/neotest",
        dependencies = {
            'mfussenegger/nvim-dap',
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
            "marilari88/neotest-vitest",
            "lawrence-laz/neotest-zig",
            "alfaix/neotest-gtest",
            "rouge8/neotest-rust",
            "mrcjkb/neotest-haskell",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-plenary"),
                    require("neotest-vitest"),
                    require("neotest-python"),
                    require("neotest-zig"),
                    require("neotest-gtest"),
                    require("neotest-rust"),
                    require("neotest-haskell"),
                }
            })

            vim.keymap.set("n", "<leader>cr", function()
                neotest.run.run()
            end)
            vim.keymap.set("n", "<leader>co", function()
                    neotest.output.open({ enter = true})
                end)
            vim.keymap.set("n", "<leader>cw", function()
                    neotest.output.watch.watch()
                end)
            vim.keymap.set("n", "<leader>cs", function()
                    neotest.summary.toggle()
                end)
            vim.keymap.set("n", "<leader>cd", function()
                    neotest.run.run({vim.fn.expand("%"), strategy = "dap"})
                end)
        end,
}
