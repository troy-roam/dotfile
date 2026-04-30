local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

configs.setup({
    ensure_installed = { "go" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local has_parser = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
        if not has_parser then
            return
        end

        -- Use Treesitter folding with the new Neovim expression API.
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})
