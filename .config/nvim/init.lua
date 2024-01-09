-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Configs
vim.g.mapleader = ' '
-- Enable line numbers
vim.opt.nu = true
-- Set tab width to 4 spaces
vim.opt.tabstop = 4
-- Set the number of spaces for a tab in insert mode to 4
vim.opt.softtabstop = 4
-- Set the number of spaces for autoindenting in insert mode to 4
vim.opt.shiftwidth = 4
-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Enable smart indenting
vim.opt.smartindent = true
-- Disable line wrapping
vim.opt.wrap = false
-- Disable swap files
vim.opt.swapfile = false
-- Disable backup files
vim.opt.backup = false
-- Disable highlighting during search
vim.opt.hlsearch = false
-- Highlight as you type during search
vim.opt.incsearch = true
-- Extra 8 lines at the bottom
vim.opt.scrolloff = 8
-- Show signs
vim.opt.signcolumn = "yes"

-- Use capital Y to yank whole line
vim.keymap.set("n", "Y", "yy")

-- Don't override when pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })
require("bufferline").setup{
	options = {
		indicator = {
            icon = '▎',
			style = 'icon',
		},
		buffer_close_icon = 'x',
		close_icon = 'x',
		left_trunc_marker = '<',
		right_trunc_marker = '>',
	}
}

-- Tags
vim.keymap.set("n", "gd", ":tag <C-R><C-W><CR>")

-- FZF
vim.keymap.set("n", "<leader>ff","<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb","<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg","<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
vim.keymap.set("n", "<leader>gg","<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true })

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { 
      "lua", 
      "ruby", 
      "javascript", 
      "typescript", 
      "php", 
      "html", 
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- Git signs
require('gitsigns').setup()

-- Plugins
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'junegunn/fzf'
    use 'github/copilot.vim'
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rails'
    use 'vim-ruby/vim-ruby'
    use {'akinsho/bufferline.nvim'}
    use { 'ibhagwan/fzf-lua' }
    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
end)
