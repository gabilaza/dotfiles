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

vim.lsp.config("lua_ls", {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "love" },
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
})
vim.lsp.enable("lua_ls")

-- TODO: maybe add lombok from here not from bashrc
vim.lsp.config("jdtls", {})
vim.lsp.enable("jdtls")

vim.lsp.config("bashls", {})
vim.lsp.enable("bashls")

vim.lsp.config("cmake", {})
vim.lsp.enable("cmake")

vim.lsp.config("dockerls", {})
vim.lsp.enable("dockerls")

vim.lsp.config("yamlls", {})
vim.lsp.enable("yamlls")

vim.lsp.config("jedi_language_server", {})
vim.lsp.enable("jedi_language_server")

vim.lsp.config("html", {})
vim.lsp.enable("html")

vim.lsp.config("ts_ls", {})
vim.lsp.enable("ts_ls")

vim.lsp.config("cssls",{})
vim.lsp.enable("cssls")

vim.lsp.config("ltex", {})
vim.lsp.enable("ltex")

vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

vim.lsp.config("csharp_ls", {})
vim.lsp.enable("csharp_ls")

vim.lsp.config("gopls", {})
vim.lsp.enable("gopls")

-- vim.lsp.config("sourcekit", {})
-- vim.lsp.enable("sourcekit")

vim.lsp.config("elixirls", {
    cmd = { "/Users/glaza/.lsp/elixir-language-server/language_server.sh" }
})
vim.lsp.enable("elixirls")

vim.lsp.config("rust_analyzer", {})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("dartls", {})
vim.lsp.enable("dartls")

vim.lsp.config("zls", {})
vim.lsp.enable("zls")

vim.lsp.config("gleam", {})
vim.lsp.enable("gleam")

return M
