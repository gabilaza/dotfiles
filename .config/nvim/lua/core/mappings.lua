-- n -> Normal
-- i -> Insert
-- v -> Visual and Select
-- x -> Visual
-- s -> Select
-- c -> Command-line
-- t -> Terminal

local M = {}

M.general = {
    n = {
        -- Disable leader key
        ["<Space>"] = { "<Nop>" },

        -- Disable arrow keys
        ["<Down>"] = { "<Nop>" },
        ["<Left>"] = { "<Nop>" },
        ["<Right>"] = { "<Nop>" },
        ["<Up>"] = { "<Nop>" },

        -- Buffer
        ["<leader>b"] = { "<cmd> bd <CR>" },
        ["<leader>d"] = { "<cmd> bp <bar> bd # <CR>" },
        ["<leader>n"] = { "<cmd> bn <CR>" },
        ["<leader>N"] = { "<cmd> bp <CR>" },

        -- Window switch
        ["<leader>o"] = { "<cmd> on <CR>" },
        ["<leader>h"] = { "<cmd> wincmd h <CR>" },
        ["<leader>j"] = { "<cmd> wincmd j <CR>" },
        ["<leader>k"] = { "<cmd> wincmd k <CR>" },
        ["<leader>l"] = { "<cmd> wincmd l <CR>" },

        -- Resize window
        ["<C-j>"] = { "<cmd> resize +4 <CR>" },
        ["<C-k>"] = { "<cmd> resize -4 <CR>" },
        ["<C-l>"] = { "<cmd> vertical resize +4 <CR>" },
        ["<C-h>"] = { "<cmd> vertical resize -4 <CR>" },

        -- Clipboard
        ["<leader>p"] = { "\"+p" },
        ["<leader>P"] = { "\"+P" },
        ["<leader>yy"] = { "\"+yy" },

        -- Macro
        ["Q"] = { "@@ <CR>" },

        -- Movement
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["J"] = { "5j" },
        ["K"] = { "5k" },
        ["H"] = { "^" },
        ["L"] = { "g_" },
        ["dH"] = { "d^" },
        ["dL"] = { "dg_" },

        -- File
        ["<leader>w"] = { "<cmd> w! <CR>" },
        ["<leader>q"] = { "<cmd> qa! <CR>" },
        ["da"] = { "gg dG <CR>" },
        ["<leader>Y"] = { "<cmd> %y+ <CR>" },

        -- Search highlighting
        ["<leader>m"] = { "<cmd> noh <CR>", opts = { silent = true } },
        ["<Esc>"] = { "<cmd> noh <CR>" , opts = { silent = true } },

        -- Bufferline
        ["<leader>1"] = { "<cmd> BufferLineGoToBuffer 1<CR>" },
        ["<leader>2"] = { "<cmd> BufferLineGoToBuffer 2<CR>" },
        ["<leader>3"] = { "<cmd> BufferLineGoToBuffer 3<CR>" },
        ["<leader>4"] = { "<cmd> BufferLineGoToBuffer 4<CR>" },
        ["<leader>5"] = { "<cmd> BufferLineGoToBuffer 5<CR>" },
        ["<leader>6"] = { "<cmd> BufferLineGoToBuffer 6<CR>" },
        ["<leader>7"] = { "<cmd> BufferLineGoToBuffer 7<CR>" },
        ["<leader>8"] = { "<cmd> BufferLineGoToBuffer 8<CR>" },
        ["<leader>9"] = { "<cmd> BufferLineGoToBuffer 9<CR>" },
        ["<leader>$"] = { "<cmd> BufferLineGoToBuffer -1<CR>" },

        -- Makefile
        ["<leader>r"] = { "<cmd> make<CR>" },

        -- Ex
        ["<C-n>"] = { "<cmd> Ex<CR>"}
    },

    i = {
        -- Disable arrow keys
        ["<Down>"] = { "<Nop>" },
        ["<Left>"] = { "<Nop>" },
        ["<Right>"] = { "<Nop>" },
        ["<Up>"] = { "<Nop>" },
    },

    v = {
        -- Disable arrow keys
        ["<Down>"] = { "<Nop>", "No arrow keys" },
        ["<Left>"] = { "<Nop>", "No arrow keys" },
        ["<Right>"] = { "<Nop>", "No arrow keys" },
        ["<Up>"] = { "<Nop>", "No arrow keys" },

        -- Clipboard
        ["<leader>y"] = { "\"+y" },

        -- Movement
        ["J"] = { "5j" },
        ["K"] = { "5k" },
        ["H"] = { "^" },
        ["L"] = { "g_" },
    },

    x = {
        -- Movement
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["H"] = { "^" },
        ["L"] = { "g_" },

        -- Don't copy the replaced text after pasting in visual mode
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
    },
}

M.lspconfig = {
    plugin = true,

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
        },

        ["gh"] = {
            function()
                vim.lsp.buf.hover()
            end,
        },

        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
        },

        ["gs"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
        },

        ["gy"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
        },

        ["ga"] = {
            function()
                vim.lsp.buf.code_action()
            end,
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
        },


        ["gm"] = {
            function()
                vim.lsp.buf.format { async = true }
            end,
        },
    },
}

M.nvimtree = {
    plugin = true,

    n = {
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>" },

        ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>" },
    },
}

M.telescope = {
    plugin = true,

    n = {
        ["<leader>ff"] = { "<cmd> Telescope find_files <CR>" },
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>" },
        ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <CR>" },

        ["<leader>fc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>fs"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    },
}

M.undotree = {
    plugin = true,

    n = {
        ["<leader>u"] = { "<cmd> UndotreeToggle <CR>" }
    },
}

M.gitsigns = {
    plugin = true,

    n = {
    },
}

M.blankline = {
    plugin = true,

    n = {
        ["gc"] = {
            function()
                local ok, start = require("indent_blankline.utils").get_current_context(
                    vim.g.indent_blankline_context_patterns,
                    vim.g.indent_blankline_use_treesitter_scope
                )

                if ok then
                    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                    vim.cmd [[normal! _]]
                end
            end,
        },
    },
}

M.fugitive = {
    plugin = true,

    n = {
        ["<M-g>"] = { "<cmd> Git <CR>" }
    },
}

M.hop = {
    plugin = true,

    n = {
        ["<leader>aa"] = { "<cmd> HopAnywhere <CR>", opts = { silent = true } },
        ["<leader>al"] = { "<cmd> HopAnywhereCurrentLine <CR>", opts = { silent = true } },
        ["<leader>aw"] = { "<cmd> HopWord <CR>", opts = { silent = true } },
        ["<leader>ac"] = { "<cmd> HopChar1 <CR>", opts = { silent = true } },
        ["<leader>ap"] = { "<cmd> HopPattern <CR>", opts = { silent = true } },
    },
}

M.comment = {
    plugin = true,

    n = {
        ["<leader>/"] = {
          function()
            require("Comment.api").toggle.linewise.current()
          end,
        },
    },

    v = {
        ["<leader>/"] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" },
    },
}

M.harpoon = {
    plugin = true,

    n = {
        ["<leader>sa"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>" },
        ["<leader>sc"] = { "<cmd>lua require('harpoon.mark').clear_all()<CR>" },
        ["<leader>sm"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>" },
        ["<leader>sn"] = { "<cmd>lua require('harpoon.ui').nav_next()<CR>" },
        ["<leader>sp"] = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>" },

        ["<leader>sh"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>" },
        ["<leader>sj"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>" },
        ["<leader>sk"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>" },
        ["<leader>sl"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>" },
    },
}

return M
