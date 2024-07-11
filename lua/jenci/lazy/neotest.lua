return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-plenary",
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
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
    },
}
