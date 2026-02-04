local vim = vim
---------------------------------- lazy start ------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy = false },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    { 'neovim/nvim-lspconfig' },
    { 'preservim/tagbar' },
    { 'f-person/git-blame.nvim' },
    -- { 'voldikss/vim-floaterm' },
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    { 'lewis6991/gitsigns.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'echasnovski/mini.completion', version = '*' },
    { "ggandor/leap.nvim" },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'nanozuki/tabby.nvim',
        -- event = 'VimEnter', -- if you want lazy load, see below
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            -- configs...
        end,
    },
    { "rebelot/kanagawa.nvim" },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 1,
                width = 80,
            }
        }
    },
    -- https://github.com/kawre/leetcode.nvim
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- "ibhagwan/fzf-lua",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            -- configuration goes here
        },
    },
    -- https://github.com/junegunn/fzf.vim
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
        event = "VeryLazy"
    },
    -- https://github.com/kawre/leetcode.nvim
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
        dependencies = {
            -- include a picker of your choice, see picker section for more details
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            -- configuration goes here
        },
    }
})

vim.g.fzf_layout = { down = '60%' } 

vim.api.nvim_set_keymap("n", "<Leader>f", ":Ag<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>F", ":Files<CR>", { noremap = true, silent = true })


---------------------------------- lazy end ------------------------------------

-- https://github.com/ellisonleao/gruvbox.nvim
-- vim.o.background = "dark" -- "dark" or "light" for light mode

vim.cmd('abb idbg fmt.Printf(\"debug: %+v\\n\",')
vim.cmd('abb ierr if err != nil {')
vim.cmd([[inoreabbrev itime <c-r>=strftime("%Y/%m/%d %H:%M:%S")<CR>]])
vim.cmd([[inoreabbrev idate <c-r>=strftime("%Y_%m_%d")<CR>]])

-- https://github.com/banga/git-split-diffs

vim.keymap.set("n", "<leader>w", ':w<CR>')
vim.keymap.set("n", "<leader>q", ':q<CR>')
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')
vim.keymap.set('n', '<leader>n', 'gt')
vim.keymap.set('n', '<leader>N', 'gT')
vim.keymap.set("n", "<leader>e", vim.cmd.TagbarToggle)
-- vim.keymap.set('n', '<C-n>', vim.cmd.FloatermToggle)

vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>')
vim.keymap.set('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>')
vim.keymap.set('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>')
vim.keymap.set('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>')
vim.keymap.set('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>')
vim.keymap.set('n', '<leader>0', ':BufferLineGoToBuffer -1<CR>')

vim.o.winbar               = "%=%f"
vim.opt.guicursor          = ""
vim.opt.expandtab          = true
vim.opt.tabstop            = 4
vim.opt.shiftwidth         = 4
vim.opt.softtabstop        = 4
vim.opt.hlsearch           = true
vim.opt.smartcase          = true
vim.opt.mouse              = "v"
vim.opt.autoindent         = true
vim.opt.spell              = false
vim.opt.spelllang          = "en_us"
vim.opt.spellfile          = vim.fn.expand("~/.config/nvim/spell/custom.utf-8.add")


-- fold
-- vim.opt.foldmethod         = "indent"
vim.opt.foldmethod         = "expr"
vim.opt.foldexpr           = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel          = 10

vim.opt.scrolloff          = 10
vim.opt.lazyredraw         = true
vim.opt.ttyfast            = true
vim.opt.cursorline         = true
vim.opt.sidescroll         = 1
vim.opt.linebreak          = true
-- vim.opt.colorcolumn   = "161"
vim.wo.wrap                = false
vim.opt.rnu                = true
vim.opt.nu                 = true
vim.opt.filetype           = "on"
vim.opt.clipboard          = "unnamedplus"
vim.opt.conceallevel       = 2
vim.opt.termguicolors      = true

-- float_term
vim.g.floaterm_width       = 0.7
vim.g.floaterm_height      = 0.8
vim.g.floaterm_borderchars = '─│─│╭╮╯╰'

-- leap
vim.keymap.set({ 'n', 'x', 'o' }, 'f',  '<Plug>(leap-forward-to)')
vim.keymap.set({ 'n', 'x', 'o' }, 'F',  '<Plug>(leap-backward-to)')
vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>(leap-from-window)')

vim.api.nvim_set_keymap('i', '/', '/<C-x><C-f>', {noremap = true, silent = true})

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

vim.cmd("colorscheme kanagawa")
