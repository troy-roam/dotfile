-- ==============================
--  Global LSP UI Setup
-- ==============================
local border = "double" -- "rounded", "single", "double", "shadow", "none"

-- Use bordered floating windows for hover/signature help no matter who calls them.
local function wrap_with_border(fn)
  return function(opts)
    opts = opts or {}
    opts.border = opts.border or border
    return fn(opts)
  end
end

vim.lsp.buf.hover = wrap_with_border(vim.lsp.buf.hover)
vim.lsp.buf.signature_help = wrap_with_border(vim.lsp.buf.signature_help)

-- Diagnostic window style
vim.diagnostic.config({
  float = { border = border },
})


-- ==============================
--  Global LSP Keymaps
-- ==============================
local function setup_global_lsp_keymaps()
  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({ border = border })
  end, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ff", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = setup_global_lsp_keymaps,
})

-- Diagnostics navigation
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })


-- ==============================
--  LSP Server Configurations
-- ==============================

-- Rust
vim.lsp.config.rust_analyzer = {}

-- TypeScript / JavaScript
vim.lsp.config.ts_ls = {}

-- Python (pyright)
vim.lsp.config.pyright = {}

-- Python (pylsp)
vim.lsp.config.pylsp = {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391" },
          maxLineLength = 100,
        },
      },
    },
  },
}

-- Go (gopls)
vim.lsp.config.gopls = {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      diagnosticsDelay = "3s",
      completionBudget = "1s",
      analyses = {
        unusedparams = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Autoformat and organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- organize imports
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for cid, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end

        -- format
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}


-- ==============================
--  Enable All Servers
-- ==============================
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("pylsp")
vim.lsp.enable("gopls")
