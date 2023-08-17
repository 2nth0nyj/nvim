vim.opt.showtabline = 2
vim.opt.number = true


--好好学习， 习惯VIM操作模式，不要用方向键
vim.keymap.set('n', '<Up>', '<NOP>')
vim.keymap.set('n', '<Down>', '<NOP>')
vim.keymap.set('n', '<Left>', '<NOP>')
vim.keymap.set('n', '<Right>', '<NOP>')
--往下移动的时候总是不注意大小写，干脆把大写的Join功能禁用了
vim.keymap.set('n', 'J',     '<NOP>')

--lazypath 当作nvim的包管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{	"ibhagwan/fzf-lua",
  		dependencies = { "nvim-tree/nvim-web-devicons" },
  		config = function()
    				require("fzf-lua").setup({})
  			end
	},
	{ "junegunn/fzf", build = "./install --bin" },
	'preservim/nerdtree',
        -- {'neoclide/coc.nvim', branch = 'release'}
	'neovim/nvim-lspconfig',
})

-- 配置LSP
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	local opts = {noremap = true, silent = true}
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts) --gD go to declaration
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)  --gd go to definition
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)  --gr go to references
end
nvim_lsp.erlangls.setup{ on_attach = on_attach }





-- C-f 用fzf来找文件
local findFilesCommand = "<cmd>lua require('fzf-lua').files({cmd = 'rg . --files -g \\\'*.{erl,hrl,txt}\\\' '})<CR>"
vim.keymap.set('n', '<C-f>', findFilesCommand, {silent = true})
-- C-p 兼容以前VSCode的习惯 
vim.keymap.set('n', '<C-p>', findFilesCommand, {silent = true})


--insert 模式下, C-w C-W 保存文件
vim.keymap.set({'i', 'n', 'v'}, '<C-w>', "<ESC>:write<CR>a", {silent = true})
vim.keymap.set({'i', 'n', 'v'}, '<C-W>', "<ESC>:write<CR>a", {silent = true})


