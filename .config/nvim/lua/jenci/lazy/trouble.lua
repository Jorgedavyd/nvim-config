return {
    {
        "folke/trouble.nvim",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local trouble = require('trouble')
            vim.keymap.set("n", "<leader>t", function()
                trouble.toggle({mode = "diagnostics", filter = { buf = 0}})
            end)

            vim.keymap.set("n", "[t", function()
                trouble.next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                trouble.prev({skip_groups = true, jump = true});
            end)

        end
    },
}
