local M = {}

local state = {
    enabled = false,
    frame_index = 1,
    keystroke_count = 0,
}

local frames = {
    "🐱",
    "🙀🥁",
    "🥁🙀",
}

local augroup_name = "BongoCat"

function M.component()
    if not state.enabled then
        return ""
    end

    local get_mode_ok, mode = pcall(vim.api.nvim_get_mode)
    if not get_mode_ok or not mode or not mode.mode then
        return frames[1]
    end

    if not mode.mode:match("^[iIcR]") then
        state.frame_index = 1
        return frames[state.frame_index]
    end

    return frames[state.frame_index]
end

local function on_keystroke()
    if not state.enabled then
        return
    end

    local mode_ok, mode = pcall(vim.api.nvim_get_mode)
    if not mode_ok or not mode or not mode.mode then
        return
    end

    if not mode.mode:match("^[iIcR]") then
        return
    end

    state.keystroke_count = state.keystroke_count + 1

    if state.keystroke_count % 3 == 0 then
        state.keystroke_count = 0

        state.frame_index = state.frame_index + 1
        if state.frame_index > #frames then
            state.frame_index = 2
        end
    end
end

local function on_insert_leave()
    if not state.enabled then
        return
    end

    state.frame_index = 1
    state.keystroke_count = 0
end

function M.enable(silent)
    local ok = pcall(require, 'lualine')
    if not ok then
        vim.notify("BongoCat: lualine not found", vim.log.levels.ERROR)
        return
    end

    if state.enabled then
        if not silent then
            vim.notify("BongoCat Already Enabled", vim.log.levels.INFO)
        end
        return
    end

    if pcall(vim.api.nvim_get_autocmds, { group = augroup_name}) then
        local delete_augroup_ok = pcall(vim.api.nvim_del_augroup_by_name, augroup_name)
        if not delete_augroup_ok then
            vim.notify("BongoCat: Error to delete augroup " .. tostring(augroup_name), vim.log.levels.ERROR)
            return
        end
    end

    local create_augroup_ok, augroup = pcall(vim.api.nvim_create_augroup, augroup_name, { clear = true })
    if not create_augroup_ok then
        vim.notify("BongoCat: Error to create augroup " .. tostring(augroup), vim.log.levels.ERROR)
        return
    end

    local insert_char_ok = pcall(vim.api.nvim_create_autocmd, { "InsertCharPre" }, {
        group = augroup,
        callback = on_keystroke,
    })

    if not insert_char_ok then
        vim.notify("BongoCat: Error to create on_keystroke for InsertCharPre", vim.log.levels.ERROR)
        return
    end

    local insert_leave_ok = pcall(vim.api.nvim_create_autocmd, { "InsertLeave" }, {
        group = augroup,
        callback = on_insert_leave,
    })

    if not insert_leave_ok then
        vim.notify("BongoCat: Error to create on_insert_leave InsertLeave", vim.log.levels.ERROR)
        return
    end

    state.frame_index = 1
    state.keystroke_count = 0

    state.enabled = true
    if not silent then
        vim.notify("Bongo Cat Enabled", vim.log.levels.INFO)
    end
end

function M.disable()
    if not state.enabled then
        vim.notify("BongoCat Already Disabled", vim.log.levels.INFO)
        return
    end

    local delete_augroup_ok = pcall(vim.api.nvim_del_augroup_by_name, augroup_name)
    if not delete_augroup_ok then
        vim.notify("BongoCat: Error to delete augroup " .. tostring(augroup_name), vim.log.levels.ERROR)
        return
    end

    state.enabled = false
    vim.notify("BongoCat Disabled", vim.log.levels.INFO)
end

function M.status()
    return {
        enabled = state.enabled,
    }
end

vim.api.nvim_create_user_command("BongoCatEnable", function()
    M.enable()
end, {
    desc = "Enable BongoCat",
})

vim.api.nvim_create_user_command("BongoCatDisable", function()
    M.disable()
end, {
    desc = "Disable BongoCat",
})

vim.api.nvim_create_user_command("BongoCatStatus", function()
    local status = M.status()
    local status_text = status.enabled and "Enabled" or "Disabled"
    print("BongoCat: " .. status_text)
end, {
    desc = "Show BongoCat Status",
})

M.enable(true)

return M
