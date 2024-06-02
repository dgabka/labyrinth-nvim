local p = require "labyrinth.palette"

return {
    normal = {
        a = { bg = p.surface, fg = p.amber, gui = "bold" },
        b = { bg = p.surface, fg = p.text },
        c = { bg = p.surface, fg = p.subtle, gui = "italic" },
    },
    insert = {
        a = { bg = p.surface, fg = p.leaf, gui = "bold" },
    },
    visual = {
        a = { bg = p.surface, fg = p.haze, gui = "bold" },
    },
    replace = {
        a = { bg = p.surface, fg = p.moss, gui = "bold" },
    },
    command = {
        a = { bg = p.surface, fg = p.crimson, gui = "bold" },
    },
    inactive = {
        a = { bg = p.base, fg = p.subtle, gui = "bold" },
        b = { bg = p.base, fg = p.subtle },
        c = { bg = p.base, fg = p.subtle, gui = "italic" },
    },
}
