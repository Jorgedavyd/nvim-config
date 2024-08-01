return {
    {
        "folke/trouble.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            vim.keymap.set("n", "<leader>t", function()
                require("trouble").toggle({mode = "diagnostics", filter = { buf = 0}})
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").prev({skip_groups = true, jump = true});
            end)

        end
    },
}
