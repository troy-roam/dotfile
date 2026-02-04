local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
    return
end

ts.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Keep your previous default parser choice.
ts.install({ "go" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local has_parser = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
        if not has_parser then
            return
        end

        -- Start Treesitter highlighting/injections for current buffer if parser exists.
        pcall(vim.treesitter.start, args.buf)

        -- Use Treesitter folding with the new Neovim expression API.
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

        -- Keep Treesitter indentation enabled where supported.
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
