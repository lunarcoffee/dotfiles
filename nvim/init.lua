vim.g.mapleader = ' '

-- vim.opt.guifont = { 'JetBrainsMono NF', ':h10:#h-none' }
vim.opt.guifont = { 'Iosevka Extended', ':h10:#h-none' }

vim.opt.termguicolors = true

-- vim.g.neovide_transparency = 0.6
vim.g.neovide_padding_top = 11
vim.g.neovide_padding_right = 8
vim.g.neovide_padding_bottom = 7
vim.g.neovide_padding_left = 12
vim.g.neovide_refresh_rate = 144

-- hybrid line numbers
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.fillchars = "vert: ,eob: "

vim.opt.wrap = false
vim.opt.showmode = false

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Don't ignore case if search contains caps
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autochdir = true

-- recommended by nvim-cmp
vim.opt.cot = 'menu,menuone,noselect'

-- packer.nvim
require 'plugins'

require 'leap'.add_default_mappings()  -- s S, x X (visual)

require 'Comment'.setup()

if vim.g.vscode then
    
    require 'catppuccin'.setup {
        show_end_of_buffer = false,
        integrations = {
            leap = true,
        }
    }
    
    vim.cmd.colorscheme 'catppuccin-mocha'
 
else
    require 'alpha'.setup(require 'alpha.themes.startify'.config)
    
    require 'nvim-autopairs'.setup {
        enable_check_bracket_line = false  -- essentially allow matching parens to span multiple lines
    }
    
    require 'catppuccin'.setup {
        transparent_background = true,
        show_end_of_buffer = false,
        integrations = {
            cmp = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = { 'undercurl' },
                    hints = { 'undercurl' },
                    warnings = { 'undercurl' },
                    information = { 'undercurl' },
                },
            },
            telescope = true,
            leap = true,
            treesitter = true,
            ts_rainbow2 = true,
        }
    }
    
    vim.cmd.colorscheme 'catppuccin-mocha'
    
    -- vim.api.nvim_set_hl(0, 'TSRainbowRed', { fg = '#ff6663' })
    -- vim.api.nvim_set_hl(0, 'TSRainbowYellow', { fg = '#f4ed77' })
    -- vim.api.nvim_set_hl(0, 'TSRainbowBlue', { fg = '#9ec1cf' })
    -- vim.api.nvim_set_hl(0, 'TSRainbowOrange', { fg = '#feb144' })
    -- vim.api.nvim_set_hl(0, 'TSRainbowGreen', { fg = '#9ee09e' })
    -- vim.api.nvim_set_hl(0, 'TSRainbowViolet', { fg = '#cc99c9' })
    -- vim.api.nvim_set_hl(0, 'TSRainbowCyan', { fg = '#9bf6ff' })
    
    require 'nvim-treesitter.configs'.setup {
        highlight = { enable = true },
        additional_vim_regex_highlighting = false,
        rainbow = {
            -- enable = false,
            enable = true,
            query = {
                'rainbow-parens',
                html = 'rainbow-tags',
                latex = 'rainbow-blocks',
            },
            strategy = require 'ts-rainbow'.strategy.global,
            hlgroups = {
                'TSRainbowBlue',
                'TSRainbowGreen',
                'TSRainbowRed',
                'TSRainbowYellow',
                'TSRainbowViolet',
                'TSRainbowCyan',
                'TSRainbowOrange',
            },
        }
    }
    
    vim.filetype.add { extension = { rkt = 'racket' } }
    
    -- Animated scrolling
    -- local animate = require 'mini.animate';
    -- animate.setup {
    --     cursor = { enable = false },
    --     scroll = { enable = true, timing = animate.gen_timing.linear { easing = 'in-out', duration = 3 } },
    --     resize = { enable = true },
    --     open = { enable = true },
    --     close = { enable = true }
    -- }
    
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
    vim.keymap.set('n', '<leader>fh', telescope_bt.help_tags, {})
    vim.keymap.set('n', '<leader>bi', telescope_bt.buffers, {})
    
    -- Autocomplete with nvim-cmp
    local cmp = require 'cmp'
    
    local lspkind = require 'lspkind'
    
    local completion_style = cmp.config.window.bordered()
    completion_style.winhighlight = completion_style.winhighlight .. ',NormalFloat:NormalFloat,FloatBorder:FloatBorder'
    
    local doc_style = cmp.config.window.bordered()
    doc_style.winhighlight = doc_style.winhighlight .. ',NormalFloat:NormalFloat,FloatBorder:FloatBorder'
    -- doc_style.side_padding = 2 -- doesn't work
    
    cmp.setup {
        snippet = {
            expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
        },
        window = {
            completion = completion_style,
            documentation = doc_style,
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({ 
            { name = 'nvim_lsp' },
            { name = 'vsnip' }
        },
        { { name = 'buffer' } }),
        formatting = {
            format = lspkind.cmp_format {
                mode = 'symbol_text',
            }
        }
    }
    
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
    })
    
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
    })
    
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded'
    })
    
    -- LSP UI stuff
    
    vim.diagnostic.config {
        virtual_text = false,
        signs = false,
        underline = true,
        -- update_in_insert = true, -- annoying when typing things and the highlight overrides everything
    }
    
    require 'lsp_signature'.setup {}
    
    vim.o.updatetime = 250
    
    -- LSP stuff
    
    local lsp = require 'lspconfig'
    
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    
        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function()
                local opts = {
                    focusable = false,
                    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                    border = 'rounded',
                    scope = 'cursor',
                    header = ' Diagnostics:',
                    format = function(diag) -- add a space of padding on the left and right
                        local msg = diag.message
                        lines = {}
                        for l in msg:gmatch("[^\n]+") do table.insert(lines, " " .. l .. " ") end
                        
                        res = ""
                        for k,l in ipairs(lines) do res = res .. l .. "\n" end
                        return res
                    end,
                    prefix = function(diag, i, total)
                        if total == 1 then
                            return '', ''
                        end
                        return ' ' .. tostring(i) .. '.', ''
                    end,
                }
                vim.diagnostic.open_float(nil, opts)
            end
        })
    end
    
    local cmp_cap = require 'cmp_nvim_lsp'.default_capabilities()
    cmp_cap.textDocument.completion.completionItem.snippetSupport = true
    
    lsp.bashls.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.clangd.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.cssls.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.eslint.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.gopls.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.html.setup { on_attach = on_attach, capabilities = cmp_cap }
    -- lsp.hls.setup { on_attach = on_attach, capabilities = cmp_cap } -- overridden by haskell-tools
    lsp.pyright.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.racket_langserver.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.rust_analyzer.setup { on_attach = on_attach, capabilities = cmp_cap }
    lsp.tsserver.setup { on_attach = on_attach, capabilities = cmp_cap }
end
