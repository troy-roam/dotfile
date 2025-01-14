local vim = vim
---------------------------------- lazy start ------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "nvim-treesitter/nvim-treesitter" },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- },

    --- Uncomment the two plugins below if you want to manage the language servers from neovim
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'VonHeikemen/lsp-zero.nvim',              branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-path' },
    { 'L3MON4D3/LuaSnip' },
    { 'preservim/tagbar' },
    { 'f-person/git-blame.nvim' },

    -- https://github.com/voldikss/vim-floaterm
    { 'voldikss/vim-floaterm' },
    { 'fatih/vim-go' },

    -- https://github.com/lewis6991/gitsigns.nvim
    { 'lewis6991/gitsigns.nvim' },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    { 'nvim-lualine/lualine.nvim' },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "ggandor/leap.nvim",
        config = function()
            -- require('leap').create_default_mappings()
        end,
    },
    {
        "yorik1984/newpaper.nvim",
        priority = 1000,
        config = true,
    },
})

---------------------------------- lazy end ------------------------------------

-- https://github.com/ellisonleao/gruvbox.nvim
vim.o.background = "dark" -- "dark" or "light" for light mode

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
vim.keymap.set('n', '<C-n>', vim.cmd.FloatermToggle)

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

vim.opt.guicursor          = ""
vim.opt.expandtab          = true
vim.opt.tabstop            = 4
vim.opt.shiftwidth         = 4
vim.opt.softtabstop        = 4
vim.opt.hlsearch           = true
vim.opt.smartcase          = true
vim.opt.mouse              = "v"
vim.opt.autoindent         = true
vim.opt.foldlevel          = 5
vim.opt.scrolloff          = 10
vim.opt.lazyredraw         = true
vim.opt.ttyfast            = true
vim.opt.cursorline         = true
vim.opt.sidescroll         = 1
vim.opt.linebreak          = true
-- vim.opt.colorcolumn   = "161"
vim.wo.wrap                = true
vim.opt.rnu                = false
vim.opt.nu                 = true
vim.opt.filetype           = "on"
vim.opt.clipboard          = "unnamedplus"
vim.opt.conceallevel       = 2
vim.opt.termguicolors      = true

-- float_term
vim.g.floaterm_width       = 0.7
vim.g.floaterm_height      = 0.8
vim.g.floaterm_borderchars = '─│─│╭╮╯╰'

---------------------------------------------------------------------
local function set_theme()
    local hour = tonumber(os.date("%H"))
    if hour >= 7 and hour < 18 then
        -- vim.cmd [[colorscheme tokyonight-day]]
	    vim.g.newpaper_style = "light"
    else
        -- vim.cmd [[colorscheme tokyonight-night]]
	    vim.g.newpaper_style = "dark"
    end
end

set_theme()

local timer = vim.loop.new_timer()
timer:start(0, 60000, vim.schedule_wrap(function()
    set_theme()
end))
---------------------------------------------------------------------

------------------------------ lsp ----------------------------
vim.keymap.set("n", "<leader>d", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end)
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

-- https://stackoverflow.com/questions/77466697/how-to-automatically-format-on-save
vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !black --quiet %")
            vim.cmd("edit")
        end,
    }
)

vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward-to)')
vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(leap-backward-to)')
vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>(leap-from-window)')
