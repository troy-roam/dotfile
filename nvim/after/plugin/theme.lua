local function set_theme()
    local hour = tonumber(os.date("%H"))
    if hour >= 7 and hour < 18 then
        -- vim.cmd [[colorscheme tokyonight-day]]
        require("newpaper").setup({
            style = "dark"
        })
    else
        -- vim.cmd [[colorscheme tokyonight-night]]
        require("newpaper").setup({
            style = "dark"
        })
    end
end

set_theme()

local timer = vim.loop.new_timer()
timer:start(0, 60000, vim.schedule_wrap(function()
    set_theme()
end))
