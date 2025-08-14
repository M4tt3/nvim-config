sessions = require('sessions')

local DEFAULT_FILEPATH = ".nvim/session"

sessions.setup{
    session_filepath = DEFAULT_FILEPATH,
}

local function session_exists()
    local f = io.open(DEFAULT_FILEPATH, "r")
    if f ~= nil then
        io.close(f)
        return true
    end
    return false
end

local function session_save()
    if session_exists() then
        print("Session saved")
        sessions.save(DEFAULT_FILEPATH, { silent = true })
    end
end

vim.keymap.set("n", "<leader>ss", session_save)
