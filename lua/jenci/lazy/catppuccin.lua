return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")
		catppuccin.flavour = "mocha"
		catppuccin.transparent_background= true
		catppuccin.show_end_of_buffer = true 
		catppuccin.integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			harpoon = true,
			mason = true,
			neotest = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			telescope = {
				enabled = true,
				-- style = "nvchad"
			},
			lsp_trouble = true

			mini = {
				enabled = true,
				indentscope_color = "",
			},
		}
	end,
}

