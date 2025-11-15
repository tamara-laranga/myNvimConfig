-- ===========================
-- LSP-ZERO (v3) CONFIG
-- ===========================
local lsp_zero = require("lsp-zero")

-- Base LSP config
lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- Apply base config
lsp_zero.setup()

-- ===========================
-- MASON (LSPs instalations)
-- ===========================

require("mason").setup()
local mason_lsp_config = require("mason-lspconfig")

mason_lsp_config.setup({
	ensure_installed = {
		"ts_ls",
		"eslint",
		"lua_ls",
		"rust_analyzer",
		"pyright",
		"clangd",
		"fortls",
	},
	handlers = {
		function(server_name)
			local opts = {}

			if server_name == "clangd" then
				opts.cmd = { "clangd", "--background-index", "--clang-tidy", "--std=c++23" }
			end
			require("lspconfig")[server_name].setup({ opts })
		end,
	},
})

-- ===========================
-- NVIM-CMP (autocompletion)
-- ===========================
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
	},
})
