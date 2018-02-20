" Load plugins through Pathogen
execute pathogen#infect()

" Syntax highlighting
syntax on

" Line numbers
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Identation
filetype plugin indent on
set shiftwidth=2
set softtabstop=2

" Shared clipboard
set clipboard=unnamedplus

" Highlight searches
set hlsearch

" Pane navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Tab navigation
map <C-k> :tabn<CR>
map <C-j> :tabp<CR>
map <C-n> :tabnew<CR>

" Tab bar
hi TabLineFill ctermfg=Black ctermbg=White
hi TabLine ctermfg=Blue ctermbg=Black
hi TabLineSel ctermfg=Red ctermbg=Black

" NERDTree toggle key
map <C-m> :NERDTreeToggle<CR>

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Tagbar toggle key
nmap <F8> :TagbarToggle<CR>

" Window name
let &titlestring = @%
set title
