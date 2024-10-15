return {
    "theprimeagen/harpoon",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local harpoon = require("harpoon.mark")
        local ui = require("harpoon.ui")
        vim.keymap.set('n', '<leader>a', harpoon.add_file, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-t>', function () ui.nav_file(1) end, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-y>', function () ui.nav_file(2) end, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-n>', function () ui.nav_file(3) end, { noremap = true, silent = true })
        vim.keymap.set('n', '<C-s>', function () ui.nav_file(4) end, { noremap = true, silent = true })
    end,
}
