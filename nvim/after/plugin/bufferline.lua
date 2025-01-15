require("bufferline").setup{
    options = {
        show_buffer_icons = false,
        themable = false,
        mode = "tabs",
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "thin",
        name_formatter = function(buf)
            return buf.tabnr .. ". " .. buf.name
        end,
        custom_areas = {
            right = function()
                local result = {}
                local current_file = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
                table.insert(result, {text = current_file})
                return result
            end,
        },
    }
}
