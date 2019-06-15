"""
""" General
"""

" Window name
let &titlestring = @%
set title

" Syntax highlighting
syntax on

" Visual mode color
highlight Visual cterm=reverse ctermbg=NONE

" Line numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Identation
filetype plugin indent on
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

" Highlight searches
set hlsearch
hi Search cterm=bold ctermfg=black ctermbg=yellow
set ignorecase smartcase

" Status line
hi Statusline ctermbg=Gray ctermfg=234
hi StatusLineNC ctermbg=Gray ctermfg=234

" Popup
hi Pmenu ctermfg=Gray ctermbg=Black guibg=Black
hi PmenuSel ctermfg=Black ctermbg=Gray guibg=Gray
hi PmenuSbar ctermfg=Black ctermbg=Gray guibg=Gray
function! InsertTabWrapper(direction)
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  elseif "backward" == a:direction
    return "\<c-p>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper("forward")<CR>
inoremap <S-Tab> <c-r>=InsertTabWrapper("backward")<CR>

" Invisible characters
set list
set listchars=tab:ᐅ\ 

" Wild menu
set wildmenu

" Shared clipboard
set clipboard=unnamedplus


"""
""" Navigation and workflow
"""

" Switchbuf preferences
set switchbuf=useopen,split,usetab

" Pane navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Tab bar
hi TabLineFill ctermfg=Black ctermbg=White
hi TabLine ctermfg=Blue ctermbg=Black
hi TabLineSel ctermfg=Red ctermbg=Black

" Buffers
set hidden
nmap <leader>bl :ls<CR>
nmap <leader>j :bnext<CR>
nmap <leader>k :bprevious<CR>
nmap <leader>bc :enew<cr>
nmap <leader>bq :bp <BAR> bd #<CR>

" Splits
hi VertSplit ctermfg=Black ctermbg=White
set fillchars+=vert:\ 

" Location list
noremap <leader>lo :lopen<CR>
noremap <leader>lc :lclose<CR>

" Preview windows
noremap <leader>pc :pclose<CR>

" Navigating with guides
inoremap ;;<Space> <Esc>/<++><Enter>"_c4l
vnoremap ;;<Space> <Esc>/<++><Enter>"_c4l
map ;;<Space> <Esc>/<++><Enter>"_c4l
inoremap ;gui <++>

"""
""" Utilities
"""

" Reload Vim config file
nnoremap <Leader>sv :so ~/.vimrc<CR>

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

" Cursor line
hi CursorLine cterm=NONE ctermbg=233
nnoremap <Leader>c :set cursorline!<CR>

" Copy and paste on X clipboard
map <leader>cc :w !xsel -i -b<CR>
map <leader>cp :w !xsel -i -p<CR>
map <leader>cs :w !xsel -i -s<CR>
map <leader>pp :r!xsel -p<CR>
map <leader>ps :r!xsel -s<CR>
map <leader>pb :r!xsel -b<CR>

" Spell-check:
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=1
hi clear SpellRare
hi SpellRare cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
let g:myLang = 0
let g:myLangList = ['nospell', 'en_us', 'pt_pt']
function! MySpellLang()
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'Spellcheck language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
map <F7> :<C-U>call MySpellLang()<CR>

" Find (grep)
nnoremap <Leader>fg :exec ":Grep ".input("grep: ")<CR>
nnoremap <Leader>fr :exec ":Rg ".input("ripgrep: ")<CR>


"""
""" Plugin specific
"""

" Filetype
set nocompatible
filetype plugin on
let g:vimwiki_ext2syntax = {
  \ '.Rmd': 'markdown',
  \ '.rmd': 'markdown',
  \ '.md': 'markdown',
  \ '.markdown': 'markdown',
  \ '.mdown': 'markdown'
\}

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" ALE
nnoremap <Leader>gt :ALEGoToDefinition<CR>
nnoremap <Leader>gr :ALEFindReferences<CR>
nnoremap <Leader>gd :ALEHover<CR>
nnoremap <Leader>gs :ALESymbolSearch<CR>
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%severity%] %s (%code%) [%linter%]'

" vim-android
let g:android_sdk_path = expand("$ANDROID_HOME")
let g:gradle_daemon = 1
let g:gradle_sync_on_load = 0
let g:gradle_show_signs = 0
function! LoadDeps(buffer) abort
  call gradle#sync()
  return extend(gradle#classPaths(), android#classPaths())
endfunction
augroup GradleGroup
  autocmd!
  au BufWrite build.gradle call gradle#sync()
augroup END
