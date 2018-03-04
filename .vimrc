" Load plugins through Pathogen
    execute pathogen#infect()
    execute pathogen#helptags()

" Syntax highlighting
    syntax on

" Filetype plugin
    set nocompatible
    filetype plugin on

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

" Interpret .md files, etc. as .markdown
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Navigating with guides
    inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
    vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
    map <Space><Tab> <Esc>/<++><Enter>"_c4l
    inoremap ;gui <++>

""
"
" Snippets
"
""

"""LATEX
    " Word count:
    autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
    autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
    " Compile document using xelatex:
    autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
    autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>
    " Code snippets
    autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
    autocmd FileType tex inoremap ;fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
    autocmd FileType tex inoremap ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
    autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
    autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
    autocmd FileType tex vnoremap ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
    autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
    autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
    autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i
    autocmd FileType tex inoremap ;glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
    autocmd FileType tex inoremap ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
    autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ;li <Enter>\item<Space>
    autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
    autocmd FileType tex inoremap ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
    autocmd FileType tex inoremap ;can \cand{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ;con \const{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ;v \vio{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
    autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
    autocmd FileType tex inoremap ;beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
    autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
    autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
    autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ;bt {\blindtext}
    autocmd FileType tex inoremap ;nu $\varnothing$
    autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
    autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

"""LATEX Logical symbols
    autocmd FileType tex inoremap ;m $$<Space><++><Esc>2T$i
    autocmd FileType tex inoremap ;M $$$$<Enter><Enter><++><Esc>2k$hi
    autocmd FileType tex inoremap ;neg {\neg}
    autocmd FileType tex inoremap ;V {\vee}
    autocmd FileType tex inoremap ;or {\vee}
    autocmd FileType tex inoremap ;L {\wedge}
    autocmd FileType tex inoremap ;and {\wedge}
    autocmd FileType tex inoremap ;ra {\rightarrow}
    autocmd FileType tex inoremap ;la {\leftarrow}
    autocmd FileType tex inoremap ;lra {\leftrightarrow}
    autocmd FileType tex inoremap ;fa {\forall}
    autocmd FileType tex inoremap ;ex {\exists}
    autocmd FileType tex inoremap ;dia    {\Diamond}
    autocmd FileType tex inoremap ;box    {\Box}
    autocmd FileType tex inoremap ;gt    {\textgreater}
    autocmd FileType tex inoremap ;lt    {\textless}

"""PHP/HTML
    autocmd FileType php,html inoremap ;b <b></b><Space><++><Esc>FbT>i
    autocmd FileType php,html inoremap ;i <em></em><Space><++><Esc>FeT>i
    autocmd FileType php,html inoremap ;h1 <h1></h1><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ;h2 <h2></h2><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ;h3 <h3></h3><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ;p <p></p><Enter><Enter><++><Esc>02kf>a
    autocmd FileType php,html inoremap ;a <a<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType php,html inoremap ;e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType php,html inoremap ;ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
    autocmd FileType php,html inoremap ;li <Esc>o<li></li><Esc>F>a
    autocmd FileType php,html inoremap ;ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
    autocmd FileType php,html inoremap ;im <table<Space>class="image"><Enter><caption align="bottom"></caption><Enter><tr><td><a<space>href="pix/<++>"><img<Space>src="pix/<++>"<Space>width="<++>"></a></td></tr><Enter></table><Enter><Enter><++><Esc>4kf>a
    autocmd FileType php,html inoremap ;td <td></td><++><Esc>Fdcit
    autocmd FileType php,html inoremap ;tr <tr></tr><Enter><++><Esc>kf<i
    autocmd FileType php,html inoremap ;th <th></th><++><Esc>Fhcit
    autocmd FileType php,html inoremap ;tab <table><Enter></table><Esc>O
    autocmd FileType php,html inoremap ;gr <font color="green"></font><Esc>F>a
    autocmd FileType php,html inoremap ;rd <font color="red"></font><Esc>F>a
    autocmd FileType php,html inoremap ;yl <font color="yellow"></font><Esc>F>a
    autocmd FileType php,html inoremap ;dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
    autocmd FileType php,html inoremap ;dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc

""".bib
    autocmd FileType bib inoremap ;a @article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journal<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>8kA,<Esc>i
    autocmd FileType bib inoremap ;b @book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>6kA,<Esc>i
    autocmd FileType bib inoremap ;c @incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>8kA,<Esc>i

"MARKDOWN
    autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
    autocmd Filetype markdown,rmd inoremap ;n ---<Enter><Enter>
    autocmd Filetype markdown,rmd inoremap ;b ****<++><Esc>F*hi
    autocmd Filetype markdown,rmd inoremap ;s ~~~~<++><Esc>F~hi
    autocmd Filetype markdown,rmd inoremap ;e **<++><Esc>F*i
    autocmd Filetype markdown,rmd inoremap ;h ====<Space><++><Esc>F=hi
    autocmd Filetype markdown,rmd inoremap ;i ![](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ;a [](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ;1 #<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ;2 ##<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ;3 ###<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ;l --------<Enter>
    autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>
    autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
    autocmd Filetype rmd inoremap ;r ```{r}<CR>```<CR><CR><esc>2kO
    autocmd Filetype rmd inoremap ;p ```{python}<CR>```<CR><CR><esc>2kO

""".xml
    autocmd FileType xml inoremap ;e <item><Enter><title><++></title><Enter><pubDate><Esc>:put<Space>=strftime('%c')<Enter>A</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>5kcit
    autocmd FileType xml inoremap ;a <a href="<++>"><++></a><++><Esc>F"ci"
