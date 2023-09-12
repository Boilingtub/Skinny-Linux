local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'williamboman/mason.nvim' -- lsp package manager
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'honza/vim-snippets'
  use 'nvim-treesitter/nvim-treesitter'
  use 'sainnhe/gruvbox-material'
  use 'Mofiqul/vscode.nvim'
  use 'bluz71/vim-moonfly-colors'
  use { 'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', },
        tag = 'nightly' }
  use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
      }
end)

-- Nvim TreeSitter Setup #Start
require'nvim-treesitter.configs'.setup {
    indent = {
    enable = true,
  },

 highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
-- Nvim TreeSitter Setup #END


-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
       -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Nvim-cmp SEtup #END

require('telescope').setup{}

-- Nvim-tree Setup #Start
require("nvim-tree").setup({
filters = { dotfiles = true, },
})
-- Nvim-tree Setup #END 

-- Lualine Setup #Start
require('lualine').setup {
        options = { theme = 'gruvbox' }
}
-- Lualine Setup #END

local lsp_servers_folder = "C:/Users/jhbri/AppData/Local/nvim-data/lsp_servers"

require('lspconfig').lua_ls.setup
{
   cmd = {lsp_servers_folder .. "/lua-language-server-3.6.23-win32-x64/bin/lua-language-server.exe"}
}

require('lspconfig').clangd.setup{
        cmd = {lsp_servers_folder .. "/clangd_16.0.2/bin/clangd.exe"}
}


require('lspconfig').hls.setup{}

require'lspconfig'.rust_analyzer.setup{}

require'lspconfig'.glslls.setup{
 filetypes= { "frag", "vert"}
}

--require'lspconfig'.bashls.setup{}
--{
--   cmd = {lsp_servers_folder .. ""}
--}
