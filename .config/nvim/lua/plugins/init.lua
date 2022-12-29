local plugins = {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = function()
            return require "plugins.configs.gruvbox"
        end,
        config = function(_, opts)
            require("gruvbox").setup(opts)
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        init = function()
            require("core.utils").load_mappings "nvimtree"
        end,
        opts = function()
            return require "plugins.configs.nvimtree"
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },

        cmd = "Telescope",
        init = function()
            require("core.utils").load_mappings "telescope"
        end,
        opts = function()
            return require "plugins.configs.telescope"
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
        end,
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        init = function()
            require("core.utils").load_mappings "undotree"
        end,
    },

    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = function()
          return require "plugins.configs.gitsigns"
        end,
        config = function(_, opts)
          require("gitsigns").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        init = function()
            require("core.utils").lazy_load "nvim-treesitter"
        end,
        opts = function()
            return require "plugins.configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            return require "plugins.configs.nvim_web_devicons"
        end,
        config = function(_, opts)
            require("nvim-web-devicons").setup(opts)
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        init = function()
            require("core.utils").lazy_load "indent-blankline.nvim"
        end,
        opts = function()
            return require "plugins.configs.blankline"
        end,
        config = function(_, opts)
            require("core.utils").load_mappings "blankline"
            require("ibl").setup(opts)
        end,
    },

    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = function()
            return require "plugins.configs.mason"
        end,
        config = function(_, opts)
            require("mason").setup(opts)

            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})

            vim.g.mason_binaries_list = opts.ensure_installed
        end,
    },

    {
        "neovim/nvim-lspconfig",
        init = function()
            require("core.utils").load_mappings "lspconfig"
            require("core.utils").lazy_load "nvim-lspconfig"
        end,
        config = function()
            require "plugins.configs.lspconfig"
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("plugins.configs.luasnip").luasnip(opts)
                end,
            },

            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        -- TODO: check if you can do that
        -- init = function()
        --     require("core.utils").load_mappings "cmp"
        -- end,
        opts = function()
            return require "plugins.configs.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    {
        "akinsho/bufferline.nvim",
        lazy = false,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = function()
            return require "plugins.configs.bufferline"
        end,
        config = function(_, opts)
            require("bufferline").setup(opts)
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = function()
            return require "plugins.configs.lualine"
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end,
    },

    {
        "tpope/vim-fugitive",
        cmd = "Git",
        init = function()
            require("core.utils").load_mappings "fugitive"
        end,
    },

    {
        "phaazon/hop.nvim",
        branch = "v2",
        init = function()
            require("core.utils").lazy_load "hop.nvim"
        end,
        opts = function()
            return require "plugins.configs.hop"
        end,
        config = function(_, opts)
            require("core.utils").load_mappings "hop"
            require("hop").setup(opts)
        end,
    },

    {
        "numToStr/Comment.nvim",
        keys = { "gcc", "gbc" },
        init = function()
            require("core.utils").load_mappings "comment"
        end,
        config = function(_, opts)
            require("Comment").setup(opts)
        end,
    },
}


require("lazy").setup(plugins, require "plugins.configs.lazy_nvim")
