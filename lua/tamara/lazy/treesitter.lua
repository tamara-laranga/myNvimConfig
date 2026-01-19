return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            -- List of parsers to install
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "python",
                "markdown",
                "markdown_inline",
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,

                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
            },

            -- Config for pair parenthesis and context highlight
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        })
    end,
}

