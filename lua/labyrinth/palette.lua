local options = require("labyrinth.config").options
local variants = {
    dusk = {
        _nc = "#0a0e14",
        base = "#10141b",
        surface = "#161b24",
        overlay = "#1d2230",
        muted = "#4c5765",
        subtle = "#6e7b8b",
        text = "#d3d8e2",
        crimson = "#c94f6d",
        sun = "#d99a5c",
        amber = "#da877f",
        moss = "#3b7968",
        leaf = "#8fa8a0",
        haze = "#8e7aa8",
        highlight_low = "#202738",
        highlight_med = "#3a4258",
        highlight_high = "#505b72",
        none = "NONE",
    },
    shade = {
        _nc = "#121620",
        base = "#181b24",
        surface = "#1e222d",
        overlay = "#242834",
        muted = "#575e72",
        subtle = "#7a8194",
        text = "#dee1eb",
        crimson = "#d7617b",
        sun = "#e0a469",
        amber = "#e2968b",
        moss = "#458976",
        leaf = "#99b2a8",
        haze = "#9884b2",
        highlight_low = "#282d3c",
        highlight_med = "#434a62",
        highlight_high = "#596579",
        none = "NONE",
    },
}

if variants[options.variant] ~= nil then
    return variants[options.variant]
end

return variants.dusk
