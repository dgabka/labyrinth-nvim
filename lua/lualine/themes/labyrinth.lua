local p = require "labyrinth.palette"
local config = require "labyrinth.config"

local bg_base = p.base
if config.options.styles.transparency then
    bg_base = "NONE"
end

return {
    normal = {
        a = { bg = p.amber, fg = p.base, gui = "bold" },
        b = { bg = p.overlay, fg = p.amber },
        c = { bg = bg_base, fg = p.text },
    },
    insert = {
        a = { bg = p.leaf, fg = p.base, gui = "bold" },
        b = { bg = p.overlay, fg = p.leaf },
        c = { bg = bg_base, fg = p.text },
    },
    visual = {
        a = { bg = p.haze, fg = p.base, gui = "bold" },
        b = { bg = p.overlay, fg = p.haze },
        c = { bg = bg_base, fg = p.text },
    },
    replace = {
        a = { bg = p.moss, fg = p.base, gui = "bold" },
        b = { bg = p.overlay, fg = p.moss },
        c = { bg = bg_base, fg = p.text },
    },
    command = {
        a = { bg = p.crimson, fg = p.base, gui = "bold" },
        b = { bg = p.overlay, fg = p.crimson },
        c = { bg = bg_base, fg = p.text },
    },
    inactive = {
        a = { bg = bg_base, fg = p.muted, gui = "bold" },
        b = { bg = bg_base, fg = p.muted },
        c = { bg = bg_base, fg = p.muted },
    },
}
