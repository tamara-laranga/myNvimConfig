return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "clang-format",
                    "black",
                    "isort",
                    "prettier",
                    "stylua",
                },
                run_on_start = true,
            })
        end,
    },

    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    svelte = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    graphql = { "prettier" },
                },

                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>mp", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "Format file or range (in visual mode)" })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    local bufnr = args.buf
                    local last_line = vim.api.nvim_buf_line_count(bufnr)
                    local content = vim.api.nvim_buf_get_lines(bufnr, last_line - 1, last_line, false)[1] or ""
                    if content ~= "" then
                        vim.api.nvim_buf_set_lines(bufnr, last_line, last_line, false, { "" })
                    end
                end,
            })
        end,
    },
}

