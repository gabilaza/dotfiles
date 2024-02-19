local opt = vim.opt
local g = vim.g
local o = vim.o

-- Options
opt.list = true
opt.autoindent = true
opt.smarttab = true
opt.hlsearch = true
opt.splitright = true
opt.splitbelow = true
opt.showcmd = false
opt.incsearch = true
opt.ignorecase = true
opt.hidden = true
opt.autoread = true
opt.errorbells = false
opt.visualbell = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.nu = true
opt.wrap = false
opt.smartcase = true
opt.cursorline = true
opt.relativenumber = true
opt.timeoutlen = 1000
opt.ttimeoutlen = 0
opt.shell = "/bin/bash"
opt.mouse = ""

opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.whichwrap:append "<>[]hl"
opt.updatetime = 250
opt.ruler = false
opt.showmode = false


-- gruvbox
o.background = "dark"
vim.cmd([[colorscheme rose-pine]])

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

---------------------------------------------------------

-- disable nvim intro
opt.shortmess:append "sI"

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

