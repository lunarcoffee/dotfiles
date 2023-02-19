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

    use "neovim/nvim-lspconfig"

   -- use { "ms-jpq/coq_nvim", branch = "coq" }
   -- use { "ms-jpq/coq.thirdparty", branch = "3p" }
    
    use 'numToStr/Comment.nvim'

    -- nvim-cmp stuff for autocomplete w/ LSP integration
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"

    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"

    -- schmovement
    use "ggandor/leap.nvim"

    -- pretty colors
    use "folke/tokyonight.nvim" 
    use "xiyaowong/nvim-transparent"

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

    use { 
        "nvim-telescope/telescope.nvim", 
        tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } } 
    }

    use "elkowar/yuck.vim"
    
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
