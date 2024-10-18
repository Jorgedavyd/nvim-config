return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "onsails/lspkind.nvim"
    },
    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "cmake",
                "sqlls",
                "pyright",
                "zls",
                "ltex",
                "dockerls",
                "docker_compose_language_service",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,

                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                clangd = function()
                    local lspconfig = require('lspconfig')
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "h", "hpp" },
                        cmd = {
                            "clangd",
                            "--header-insertion=never",
                            "--clang-tidy",
                            "--compile-commands-dir=build",
                        },
                        root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "compile_flags.txt", "CMakeLists.txt"),
                        settings = {
                            clangd = {
                                fallbackFlags = {
                                    "--cuda-path=/opt/cuda",
                                    "--std=c++20",
                                    "--cuda-gpu-arch=sm_89",
                                },
                            },
                        },
                    }
                end,
                rust_analyzer = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        settings = {
                            rust_analyzer = {
                                checkOnSave = {
                                    command = 'clippy'
                                }
                            }
                        }
                    })
                end,

                pyright = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true
                                }
                            }
                        }
                    })
                end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
            },
            mapping = {
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            },
        })
        --- Setup for SQL UI
        cmp.setup.filetype({"sql"}, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" }
            }
        })

        local ls = require("luasnip")
        ls.config.set_config({
            history = false,
            updateevents = "TextChanged,TextChangedI",
        })

        -- Formatting and prettiness
        local lspkind = require("lspkind")
        lspkind.init({})

        -- Custom snippets
        for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/jenci/lazy/snippets/*.lua", true)) do
            loadfile(file)()
        end

        -- Snippet navigation
        vim.keymap.set({"i", "s"}, "<C-k>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, {silent = true})

        vim.keymap.set({"i", "s"}, "<C-j>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, {silent = true})
    end
}
