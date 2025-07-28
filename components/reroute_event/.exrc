let s:cpo_save=&cpo
set cpo&vim
inoremap <C-K> <Up>
inoremap <C-J> <Down>
inoremap <C-L> <Right>
inoremap <C-H> <Left>
inoremap <C-B> ^i
inoremap <C-W> u
inoremap <C-U> u
nnoremap  <Cmd>%y+
nnoremap  h
nnoremap <NL> j
nnoremap  k
nnoremap  l
nnoremap  <Cmd>NvimTreeToggle
nnoremap  <Cmd>w
nmap  d
tnoremap  
nnoremap  <Cmd>noh
nnoremap  dt <Cmd>lua vim.cmd('RustLsp testables')
nnoremap  dr <Cmd>lua require'dap'.run_last()
nnoremap  de <Cmd>lua require'dap'.terminate()
nnoremap  dd <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
nnoremap  db <Cmd>lua require'dap'.toggle_breakpoint()
nnoremap  dc <Cmd>lua require'dap'.continue()
nnoremap  dk <Cmd>lua require'dap'.step_out()
nnoremap  dj <Cmd>lua require'dap'.step_over()
nnoremap  dl <Cmd>lua require'dap'.step_into()
nnoremap  wK <Cmd>WhichKey 
nnoremap  fa <Cmd>Telescope find_files follow=true no_ignore=true hidden=true
nnoremap  ff <Cmd>Telescope find_files
nnoremap  pt <Cmd>Telescope terms
nnoremap  gt <Cmd>Telescope git_status
nnoremap  cm <Cmd>Telescope git_commits
nnoremap  fz <Cmd>Telescope current_buffer_fuzzy_find
nnoremap  fo <Cmd>Telescope oldfiles
nnoremap  ma <Cmd>Telescope marks
nnoremap  fh <Cmd>Telescope help_tags
nnoremap  fb <Cmd>Telescope buffers
nnoremap  fw <Cmd>Telescope live_grep
nnoremap  e <Cmd>NvimTreeFocus
vmap  / gc
nmap  / gcc
nnoremap  b <Cmd>enew
nnoremap  ch <Cmd>NvCheatsheet
nnoremap  rn <Cmd>set rnu!
nnoremap  n <Cmd>set nu!
nnoremap & :&&
nnoremap ; :
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
nnoremap Y y$
tnoremap <C-X> 
nnoremap <C-N> <Cmd>NvimTreeToggle
nnoremap <C-C> <Cmd>%y+
nnoremap <C-S> <Cmd>w
nnoremap <C-K> k
nnoremap <C-J> j
nnoremap <C-H> h
nmap <C-W><C-D> d
nnoremap <C-L> l
inoremap  ^i
inoremap  <Left>
inoremap <NL> <Down>
inoremap  <Up>
inoremap  <Right>
inoremap  u
inoremap  u
inoremap jk 
let &cpo=s:cpo_save
unlet s:cpo_save
set clipboard=unnamedplus
set expandtab
set fillchars=eob:\ 
set helplang=en
set ignorecase
set laststatus=3
set noloadplugins
set mouse=a
set packpath=/usr/share/nvim/runtime
set noruler
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/cmp-path,~/.local/share/nvim/lazy/cmp-buffer,~/.local/share/nvim/lazy/cmp-nvim-lsp,~/.local/share/nvim/lazy/cmp-nvim-lua,~/.local/share/nvim/lazy/cmp_luasnip,~/.local/share/nvim/lazy/nvim-autopairs,~/.local/share/nvim/lazy/friendly-snippets,~/.local/share/nvim/lazy/LuaSnip,~/.local/share/nvim/lazy/nvim-cmp,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/indent-blankline.nvim,~/.local/share/nvim/lazy/gitsigns.nvim,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/NvChad,~/.local/share/nvim/lazy/mason.nvim,~/.local/share/nvim/lazy/rustaceanvim,~/.local/share/nvim/lazy/ui,/usr/share/nvim/runtime,/usr/lib64/nvim,~/.local/share/nvim/lazy/cmp-path/after,~/.local/share/nvim/lazy/cmp-buffer/after,~/.local/share/nvim/lazy/cmp-nvim-lsp/after,~/.local/share/nvim/lazy/cmp-nvim-lua/after,~/.local/share/nvim/lazy/cmp_luasnip/after,~/.local/share/nvim/lazy/indent-blankline.nvim/after
set shiftwidth=2
set shortmess=lTOsFoICt
set noshowmode
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set statusline=%!v:lua.require('nvchad.stl.default')()
set tabstop=2
set termguicolors
set textwidth=80
set timeoutlen=400
set undofile
set updatetime=250
set whichwrap=<>[]hl,b,s
set window=54
" vim: set ft=vim :
