local M = {}
local utils = require "core.utils"

M.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    utils.load_mappings("lspconfig", { buffer = bufnr })

    client.server_capabilities.semanticTokensProvider = nil
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}

-- TODO: maybe add lombok from here not from bashrc
require("lspconfig").jdtls.setup {}

require("lspconfig").bashls.setup {}

require("lspconfig").cmake.setup {}

require("lspconfig").dockerls.setup {}

require("lspconfig").yamlls.setup {}

require("lspconfig").jedi_language_server.setup {}

require("lspconfig").html.setup {}

require("lspconfig").tsserver.setup {}

require("lspconfig").cssls.setup {}

require("lspconfig").ltex.setup {}

require("lspconfig").clangd.setup {}

require('lspconfig').csharp_ls.setup {}

require("lspconfig").gopls.setup {}

require("lspconfig").sourcekit.setup {}

require("lspconfig").elixirls.setup {
    cmd = { "/Users/glaza/.lsp/elixir-language-server/language_server.sh" }
}

require("lspconfig").rust_analyzer.setup {}

require("lspconfig").dartls.setup {}

return M
