vim.g.mapleader = ' '

vim.opt.guifont = { 'JetBrains Mono', ':h10' }
vim.opt.termguicolors = true

-- Hybrid line numbers
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.wrap = false
vim.opt.showmode = false

--vim.opt.mouse = nil

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10

-- Don't ignore case if search contains caps
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autochdir = true

-- Recommended by nvim-cmp
vim.opt.cot = 'menu,menuone,noselect'

-- packer.nvim
require 'plugins'

-- Enable theme transparency before nvim-transparent
require 'tokyonight'.setup {
    style = 'night',
    transparent = true,
    style = {
        sidebars = 'transparent',
        floats = 'transparent'
    }
}
vim.cmd.colorscheme 'tokyonight-night'

-- Make the middle section's background transparent
local lualine_theme = require 'lualine.themes.auto'
lualine_theme.normal.c.bg = nil  -- Also applies to x

require 'lualine'.setup { 
    options = {
        theme = lualine_theme,
        -- Stop from showing on nvim-tree and packer windows
        disabled_filetypes = { 'packer', 'NvimTree' },
        component_separators = '│',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '', right = ' ' } },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'encoding' },
        lualine_x = { 'filesize' },
        lualine_y = { 'diagnostics', 'filetype', 'progress' },
        lualine_z = {
            { 'location', separator = { left = ' ', right = '' } },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
}

-- Make status line span the whole window
vim.opt.laststatus = 3

local telescope_bt = require 'telescope.builtin'

-- TODO : configure this
vim.keymap.set('n', '<leader>ff', telescope_bt.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_bt.live_grep, {})
vim.keymap.set('n', '<leader>bi', telescope_bt.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_bt.help_tags, {})

require 'transparent'.setup {
    enable = true,
    extra_groups = {
        'TelescopeNormal',
        'TelescopeTitle',
        'TelescopeBorder',
    }
}

-- Autocomplete with nvim-cmp
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'vsnip' } }, { { name = 'buffer' } })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})

-- LSP stuff

local lsp = require 'lspconfig'

local cmp_cap = require 'cmp_nvim_lsp'.default_capabilities()
cmp_cap.textDocument.completion.completionItem.snippetSupport = true

lsp.bashls.setup { capabilities = cmp_cap }
lsp.cssls.setup { capabilities = cmp_cap }
lsp.eslint.setup { capabilities = cmp_cap }
lsp.gopls.setup { capabilities = cmp_cap }
lsp.html.setup { capabilities = cmp_cap }
lsp.hls.setup { capabilities = cmp_cap }
lsp.pyright.setup { capabilities = cmp_cap }
lsp.racket_langserver.setup { capabilities = cmp_cap }
lsp.rust_analyzer.setup { capabilities = cmp_cap }
lsp.tsserver.setup { capabilities = cmp_cap }
