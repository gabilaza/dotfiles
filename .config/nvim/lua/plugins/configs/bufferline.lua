local M = {}

-- TODO: recheck
M.options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    style_preset = require("bufferline").style_preset.minimal, -- or bufferline.style_preset.minimal,
    themable = false, -- allows highlight groups to be overriden i.e. sets highlights as default
    numbers = "none",
    close_command = false,       -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = false, -- can be a string | function | false, see "Mouse actions"
    left_mouse_command = false,    -- can be a string | function, | false see "Mouse actions"
    middle_mouse_command = false,          -- can be a string | function, | false see "Mouse actions"
    indicator = {
        style = "none"
    },
    modified_icon = '~',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    -- name_formatter = function(buf)  -- buf contains:
    --       -- name                | str        | the basename of the active file
    --       -- path                | str        | the full path of the active file
    --       -- bufnr (buffer only) | int        | the number of the active buffer
    --       -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
    --       -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    -- end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    -- diagnostics = false | "nvim_lsp" | "coc",
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = nil,
    offsets = {
        {
            filetype = "NvimTree",
            -- text = "File Explorer" | function ,
            text = "File Explorer",
            text_align = "center",
            --text_align = "left" | "center" | "right"
            separator = true,
        }
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons =  false,
    show_close_icon = false,
    show_tab_indicators = false,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    -- separator_style = "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    hover = nil,
    --sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    --    -- add custom logic
    --    return buffer_a.modified > buffer_b.modified
    --end
    sort_by = "id",
}

return M
