" utf-8 byte sequence.
set encoding=utf-8

" ------------------------------------
"  Vim-Plug Plugins
" ------------------------------------
"  NOTE: see https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" THEME
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bluz71/vim-nightfly-guicolors'

" UTIL
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Code Editting
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

call plug#end()

" set Vim update time
set updatetime=1000

" <F1> 을 통해 NERDTree 와 Tagbar 열기
nnoremap <silent><F1> :NERDTreeToggle<CR><bar>:TagbarToggle <CR>

" <Ctrl + h, l> 를 눌러서 이전, 다음 탭으로 이동
nnoremap <silent><C-j> :tabprevious<CR>
nnoremap <silent><C-k> :tabnext<CR>

" <Ctrl + j, k> 를 눌러서 이전, 다음 버퍼로 전환
nnoremap <silent><C-h> :bp<CR>
nnoremap <silent><C-l> :bn<CR>

" vim configuration
set number
set relativenumber
set showmatch
set mouse=a
set termguicolors
set autoindent
set smartindent
colorscheme nightfly
set clipboard+=unnamedplus

" ------------------------------------
"  Autopairs Configuration
" ------------------------------------

lua << EOF
require("nvim-autopairs").setup {}
EOF

" ------------------------------------
"  Vim Highlight Configuration
" ------------------------------------

" transparent buffer
highlight Normal guibg=NONE
highlight EndOfBuffer guibg=NONE

" 줄번호 배경색은 투명(NULL)하게, 
" 글자는 굵게(bold), 글자색은 하얗게(White)
highlight LineNr guibg=NONE gui=bold guifg=white

" 행 표시선 색상
highlight ColorColumn guibg=White

" ------------------------------------
"  CoC Configuration
" ------------------------------------
"  NOTE: :CocInstall coc-pyright
"  NOTE: :CocInstall coc-clangd
"  NOTE: :CocInstall coc-json
"  NOTE: :CocInstall coc-tabnine
"  NOTE: :CocInstall coc-sh
"  NOTE: :CocInstall coc-prettier

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

" ------------------------------------
" NERDTree highlight
" ------------------------------------
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" ------------------------------------
" tagbar Configuration
" ------------------------------------
" tagbar 생성 시 우측 하단에 위치하게끔 생성
let g:tagbar_position = 'right'
let g:tagbar_width = 30

" ------------------------------------
" NERDTree Configuration
" ------------------------------------
" 창 크기(가로)를 20 으로 설정
let g:NERDTreeWinSize=30

" ------------------------------------
"  PowerLine Configuration
" ------------------------------------
" Tab line 에 파일명만 출력되도록 설정
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Powerline-font 활성화
let g:airline_powerline_fonts = 1 
" 우측 하단(botright)에 창 생성(new), 해당 창을 terminal 로 변경
" 크기를 10 으로 재설정(resize) 후 창 높이를 고정(winfixheight)시킴
" 줄번호는 삭제하고, 터미널 디렉터리 글자색을 변경

" ------------------------------------
"  Commentary Configuration
" ------------------------------------
" <Ctrl + />으로 현재 줄 주석처리
nnoremap <C-_> :Commentary<cr>j
inoremap <C-_> <Esc>:Commentary<cr>ji

" ------------------------------------
"  F2 to Terminal
" ------------------------------------
" F2 눌러서 터미널 실행
nnoremap <silent><F2> 
	\:botright vsplit new<CR><bar>
	\:terminal<CR><bar><ESC>
	\:set norelativenumber<CR><bar>
	\:set nonu<CR><bar>
	\i

	" \:resize 10<CR><bar>
	" \:set winfixheight<CR><bar>

" 터미널 모드에서 <Ctrl + w> 누르면 명령 모드로 전환하고 <Ctrl + w> 입력
tmap <silent><C-w> <ESC><C-w>

" jk 혹은 kj 를 누르면 <ESC> 를 실행
tmap <silent>jk <ESC>
tmap <silent>kj <ESC>

" <ESC> 입력 시 <C-\><C-n> 실행 => 터미널 모드에서 기본 모드로 전환
tnoremap <silent><ESC> <C-\><C-n>

" ------------------------------------
"  Telescope Configuration
" ------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <silent><C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

