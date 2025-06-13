vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
    git = {
        enable = false,
    },
    sort_by = "case_sensitive",
    view = {
        adaptive_size = false,
        width         = 40,
    },
    renderer = {
        group_empty  = false,
        indent_width = 2,
        indent_markers = {
            enable        = false,
            inline_arrows = true,
        },
        icons = {
            show = {
                git = false,
            },
 
        },
    },
    update_focused_file = {
        enable = false,
    },
    filters = {
        dotfiles = false,
    },
})

vim.keymap.set("n", "<leader><tab>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>c", vim.cmd.NvimTreeFindFile)

# vim.api.nvim_create_autocmd("VimEnter", {
#   callback = function()
#     vim.cmd("NvimTreeToggle")
#   end
# })
