local options = {
    ensure_installed = { "bash", "c", "c_sharp", "cmake", "cpp", "css", "dockerfile", "go", "html", "java", "javascript", "json", "latex", "lua" , "markdown", "python", "query", "regex", "rust", "scala", "sql", "typescript", "vim", "vimdoc", "yaml" },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = {
        enable = true,
    },
}

return options
