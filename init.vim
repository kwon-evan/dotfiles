" utf-8 byte sequence.
set encoding=utf-8

" ------------------------------------
"  Vim-Plug Plugins
" ------------------------------------
"  NOTE: see https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" UI & THEME
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'preservim/tagbar'
Plug 'lukas-reineke/indent-blankline.nvim'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'

" UTIL
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'folke/which-key.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Code Editting
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

" Color Scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

" ------------------------------------
"  Key Bindings
" ------------------------------------
" <F1> 을 통해 NvimTree 와 Tagbar 열기
nnoremap <silent><F1> :NvimTreeToggle<CR><bar>:TagbarToggle <CR>

"  F2 to Vertical Terminal
nnoremap <silent><F2> :ToggleTerm size=40 direction=vertical<CR>

"  F3 to Horizontal Terminal
nnoremap <silent><F3> :ToggleTerm size=10 direction=horizontal<CR>

"  F3 to Horizontal Terminal
nnoremap <silent><F4> :ToggleTerm size=10 direction=float<CR>

" 터미널 모드에서 <Ctrl + w> 누르면 명령 모드로 전환하고 <Ctrl + w> 입력
tmap <silent><C-w> <ESC><C-w>

" <ESC> 입력 시 <C-\><C-n> 실행 => 터미널 모드에서 기본 모드로 전환
tnoremap <silent><ESC> <C-\><C-n>

" <Ctrl + h, l> 를 눌러서 이전, 다음 탭으로 이동
nnoremap <silent><C-j> :tabprevious<CR>
nnoremap <silent><C-k> :tabnext<CR>

" <Ctrl + j, k> 를 눌러서 이전, 다음 버퍼로 전환
nnoremap <silent><C-h> :bp<CR>
nnoremap <silent><C-l> :bn<CR>

" ------------------------------------
"  Vim Configuration
" ------------------------------------
"  base
set updatetime=1000
set number
set relativenumber
set showmatch
set mouse=a
set termguicolors
set autoindent
set smartindent
set clipboard+=unnamedplus

" transparent buffer
" highlight Normal guibg=NONE
" highlight EndOfBuffer guibg=NONE

" 줄번호 배경색은 투명(NULL)하게, 
" 글자는 굵게(bold), 글자색은 하얗게(White)
highlight LineNr guibg=NONE gui=bold 
" guifg=white

" 행 표시선 색상
highlight ColorColumn guibg=White


" ------------------------------------
"  Lualine Configuration
" ------------------------------------
lua << END
require('lualine').setup {
	options = {
		theme='tokyonight',
		component_separators = { left = '|', right = '|'},
		section_separators = { left = '', right = ''},
		},
	}
END

" ------------------------------------
"  Autopairs Configuration
" ------------------------------------

lua << EOF
require("nvim-autopairs").setup {}
EOF

" ------------------------------------
"  CoC Configuration
" ------------------------------------
"  INSTALL:  :CocInstall coc-pyright
"  INSTALL:  :CocInstall coc-clangd
"  INSTALL:  :CocInstall coc-json
"  INSTALL:  :CocInstall coc-tabnine
"  INSTALL:  :CocInstall coc-sh
"  INSTALL:  :CocInstall coc-prettier

set signcolumn=yes

" <TAB>으로 자동완성 이동 <ENTER>로 선택
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <c-space> 으로 자동완성 실행
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

lua << EOF
require("nvim-tree").setup()
EOF

" ------------------------------------
" tagbar Configuration
" ------------------------------------
" tagbar 생성 시 우측 하단에 위치하게끔 생성
let g:tagbar_position = 'right'
let g:tagbar_width = 30

" ------------------------------------
" Which-Key Configuration
" ------------------------------------
lua << EOF
require("which-key").setup {}
EOF

" ------------------------------------
"  Commentary Configuration
" ------------------------------------
" <Ctrl + />으로 현재 줄 주석처리
nnoremap <C-_> :Commentary<cr>j
inoremap <C-_> <Esc>:Commentary<cr>ji

" ------------------------------------
"  Telescope Configuration
" ------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <silent><C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ------------------------------------
"  EasyAlign Configuration
" ------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ------------------------------------
" Which-Key Configuration
" ------------------------------------
lua << EOF
require("toggleterm").setup {}
EOF


" ------------------------------------
" BarBar Configuration
" ------------------------------------
lua << EOF
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      require'bufferline.api'.set_offset(31, 'FileTree')
    end
  end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match('NvimTree') then
      require'bufferline.api'.set_offset(0)
    end
  end
})
EOF


" ------------------------------------
" BarBar Configuration
" ------------------------------------
lua << EOF
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    -- show_current_context_start = true,
}
EOF

" ------------------------------------
" COLORSCHEME: tokyonight
" ------------------------------------
lua << EOF
require("tokyonight").setup({
  style = "night",
  transparent = true, 
  terminal_colors = true, 
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark", 
  },
  sidebars = { "qf", "help", "NvimTree", "Tagbar", "ToggleTerm" },
  hide_inactive_statusline = true,
  dim_inactive = true, -- dims inactive windows
  lualine_bold = true,
})
EOF
colorscheme tokyonight
hi NvimTreeNormal guibg=NONE cterm=NONE
hi NvimTreeNormalNC guibg=NONE cterm=NONE

