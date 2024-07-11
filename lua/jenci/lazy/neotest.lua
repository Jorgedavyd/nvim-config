return {
        "nvim-neotest/neotest",
        dependencies = {
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

            vim.keymap.set("n", "<leader>rt", function()
                neotest.run.run()
            end)
        end,
}
