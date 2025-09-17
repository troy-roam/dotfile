vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
    -- on_attach = function(bufnr)
    --     local api = require("nvim-tree.api")
    --     local function opts(desc)
    --         return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    --     end

    --     vim.keymap.set('n', 's', '', { buffer = bufnr })
    --     vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
    --     -- vim.keymap.set('n', 's', api.node.open.edit, opts('Open'))
    -- end,
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
            glyphs = {
                default = "-",         -- 普通文件
                symlink = "@",         -- 符号链接
                folder = {
                    arrow_closed = ">", -- 折叠箭头
                    arrow_open   = "v", -- 展开箭头
                    default      = "+", -- 普通文件夹
                    open         = "-", -- 打开的文件夹
                    empty        = "+", -- 空文件夹
                    empty_open   = "-", -- 打开的空文件夹
                    symlink = "@",      -- 符号链接文件夹
                },
            },
            show = {
                file = true,
                folder = true,
                folder_arrow = false,
                git = false,
                diagnostics = false,
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

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("NvimTreeToggle")
--   end
-- })
