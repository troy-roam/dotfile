vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = false,
        width = {
            max = 200,
        },
        float = {
            enable = false,
            open_win_config = {
                height = 45,
            },
        }
    },
    renderer = {
        group_empty = false,
        indent_width = 2,
        highlight_opened_files = "all",
        indent_markers = {
            enable = false,
            inline_arrows = true,
        },
        icons = {
            show = {
                git = false,
            },
 
        },
    },
    update_focused_file = {
        enable = true,
    },
    filters = {
        dotfiles = false,
    },
})

vim.keymap.set("n", "<leader><tab>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>c", vim.cmd.NvimTreeFindFile)
