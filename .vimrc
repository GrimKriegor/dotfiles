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
    set number
    highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Identation
    filetype plugin indent on
    set shiftwidth=2
    set softtabstop=2

" Highlight searches
    set hlsearch

" Status line
    hi Statusline ctermbg=Gray ctermfg=234
    hi StatusLineNC ctermbg=Gray ctermfg=234

" Popup colors
    hi Pmenu ctermfg=Gray ctermbg=Black guibg=Black
    hi PmenuSel ctermfg=Black ctermbg=Gray guibg=Gray

" Wild menu
    set wildmenu

" Shared clipboard
    set clipboard=unnamedplus


"""
""" Navigation and workflow
"""

" Switchbuf preferences
    set switchbuf+=usetab,newtab

" Pane navigation
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l

" Tab bar
    hi TabLineFill ctermfg=Black ctermbg=White
    hi TabLine ctermfg=Blue ctermbg=Black
    hi TabLineSel ctermfg=Red ctermbg=Black

" Splits
    hi VertSplit ctermfg=Black ctermbg=White
    set fillchars+=vert:\ 

" Navigating with guides
    inoremap ;;<Space> <Esc>/<++><Enter>"_c4l
    vnoremap ;;<Space> <Esc>/<++><Enter>"_c4l
    map ;;<Space> <Esc>/<++><Enter>"_c4l
    inoremap ;gui <++>


"""
""" Utilities
"""

" Highlight trailing whitespaces
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()

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

" Insert real tab characters
    inoremap <S-Tab> <C-V><Tab>


"""
""" Plugin specific
"""

" Filetype
    set nocompatible
    filetype plugin on
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" NERDTree
    map <C-n> :NERDTreeToggle<CR>

" Syntastic
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

" Tagbar
    nmap <F8> :TagbarToggle<CR>

" goyo.vim
    map <F10> :Goyo<CR>
    inoremap <F10> <esc>:Goyo<CR>a

" vim-javacomplete2
    autocmd FileType java setlocal omnifunc=javacomplete#Complete

" YouCompleteMe
    nnoremap <Leader>gt :YcmCompleter GoTo<CR>
    nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gdf :YcmCompleter GoToDefinitionElseDeclaration<CR>
    let g:ycm_filetype_blacklist = {
        \ 'text': 1,
        \ 'conf': 1,
        \ 'markdown': 1,
        \ 'vim': 1,
        \ 'gitcommit': 1,
        \ 'mail': 1,
        \ 'tagbar': 1,
        \ 'qf': 1,
        \ 'notes': 1,
        \ 'unite': 1,
        \ 'vimwiki': 1,
        \ 'pandoc': 1,
        \ 'infolog': 1
    \}
