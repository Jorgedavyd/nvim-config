return {
    "theprimeagen/harpoon",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        -- Keybindings for Harpoon
        vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })
    end,
}
