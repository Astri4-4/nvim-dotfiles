set relativenumber
set number

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'junegunn/goyo.vim'
Plug 'windwp/nvim-autopairs'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'Alexis12119/nightly.nvim'
Plug 'jelera/vim-javascript-syntax'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
Plug 'scottmckendry/cyberdream.nvim', { 'as': 'cyberdream' }
Plug 'folke/tokyonight.nvim', { 'as': 'tokyonight' }
Plug 'ellisonleao/gruvbox.nvim', { 'as': 'gruvbox' }
Plug 'hrsh7th/nvim-cmp'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'stevearc/dressing.nvim'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'echasnovski/mini.nvim'

call plug#end()

colorscheme rose-pine
autocmd VimEnter * NERDTree

let mapleader = " " " map leader to comma
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <C-r> :! npm run dev<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

highlight Normal guibg=none

lua << EOF


require("nvim-autopairs").setup {}


require'nvim-treesitter.configs'.setup{
	ensure_installed = {"javascript"},

	sync_install = false,


	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}

}

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  }
})


EOF

" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <S-Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
"inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(1)<Cr>
"snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'


lua << EOF


local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("all", {
	s("ternary", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),

	s("test", { t"first node", t"second node", i(1, "third node") }),

	s("trig", {
	i(1), t" ", sn(2, {
		t" ", i(1), t" ", i(2)
	})
})

})

ls.add_snippets("css", {
	s("jcc", {
		i(1, "justify-content: center;")
	}),
	s("aic", {
		i(1, "align-items: center;")
	}),
	s("df",  {
		i(1, "display: flex;")
	}),
	s("dn", {
		i(1, "display: none;")
	}),
	s("p0", {
		i(1, "padding: 0;")
	}),
	s("m0", {
		i(1, "margin: 0;")
	}),
	s("pa", {
		i(1, "position: absolute;")
	}),
	s("pf", {
		i(1, "position: fixed;")
	}),
	s("pr", {
		i(1, "position: relative;")
	})
})

ls.add_snippets("javascript", {

	s("func", {
		t"function ", i(1, "name"), t"() {}"
	}),

	s("log", {
		i(1, "console.log()")
	})

})

EOF


