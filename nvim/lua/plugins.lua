local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' } 
    }

    -- essentials
    
    use "neovim/nvim-lspconfig"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    
    -- 'gcc'
    use 'numToStr/Comment.nvim'

    -- nvim-cmp stuff for autocomplete w/ LSP integration
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    -- use "hrsh7th/cmp-nvim-lsp-signature-help" -- doesn't work correctly :c

    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"

    use "onsails/lspkind.nvim"

    -- lisp technology
    use "windwp/nvim-autopairs"
    -- use "eraserhd/parinfer-rust"

    use "nvim-lua/plenary.nvim" -- library

    use "HiPhish/nvim-ts-rainbow2" -- rainbow parens
    use "ray-x/lsp_signature.nvim" -- show signature while typing
    -- use "lukas-reineke/indent-blankline.nvim" -- indent guides

    -- use {
    --     "mrcjkb/haskell-tools.nvim",
    --     requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    --     branch = "1.x.x", -- recommended
    -- }

    -- schmovement
    use "ggandor/leap.nvim"
    use { "echasnovski/mini.animate", branch = "stable" }

    -- pretty colors
    -- use "xiyaowong/nvim-transparent"
    use { "catppuccin/nvim", as = "catppuccin" }
    -- use "navarasu/onedark.nvim"
    -- use { "projekt0n/github-nvim-theme", tag = "v0.0.7" }
    -- use "marko-cerovac/material.nvim"

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

    use { 
        "nvim-telescope/telescope.nvim", 
        tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } } 
    }

    use "elkowar/yuck.vim" -- eww config language
    
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
