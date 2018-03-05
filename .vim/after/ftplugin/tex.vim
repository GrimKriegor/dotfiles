" Word count:
     map <buffer> <F3> :w !detex \| wc -w<CR>
     inoremap <buffer> <F3> <Esc>:w !detex \| wc -w<CR>

" Compile document using xelatex:
     inoremap <buffer> <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
     nnoremap <buffer> <F5> :!xelatex<space><c-r>%<Enter>

" Snippets
     inoremap <buffer> ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
     inoremap <buffer> ;fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
     inoremap <buffer> ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
     inoremap <buffer> ;em \emph{}<++><Esc>T{i
     inoremap <buffer> ;bf \textbf{}<++><Esc>T{i
     vnoremap <buffer> ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
     inoremap <buffer> ;it \textit{}<++><Esc>T{i
     inoremap <buffer> ;ct \textcite{}<++><Esc>T{i
     inoremap <buffer> ;cp \parencite{}<++><Esc>T{i
     inoremap <buffer> ;glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
     inoremap <buffer> ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
     inoremap <buffer> ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
     inoremap <buffer> ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
     inoremap <buffer> ;li <Enter>\item<Space>
     inoremap <buffer> ;ref \ref{}<Space><++><Esc>T{i
     inoremap <buffer> ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
     inoremap <buffer> ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
     inoremap <buffer> ;can \cand{}<Tab><++><Esc>T{i
     inoremap <buffer> ;con \const{}<Tab><++><Esc>T{i
     inoremap <buffer> ;v \vio{}<Tab><++><Esc>T{i
     inoremap <buffer> ;a \href{}{<++>}<Space><++><Esc>2T{i
     inoremap <buffer> ;sc \textsc{}<Space><++><Esc>T{i
     inoremap <buffer> ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
     inoremap <buffer> ;sec \section{}<Enter><Enter><++><Esc>2kf}i
     inoremap <buffer> ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
     inoremap <buffer> ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
     inoremap <buffer> ;st <Esc>F{i*<Esc>f}i
     inoremap <buffer> ;beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
     inoremap <buffer> ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
     nnoremap <buffer> ;up /usepackage<Enter>o\usepackage{}<Esc>i
     inoremap <buffer> ;tt \texttt{}<Space><++><Esc>T{i
     inoremap <buffer> ;bt {\blindtext}
     inoremap <buffer> ;nu $\varnothing$
     inoremap <buffer> ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
     inoremap <buffer> ;rn (\ref{})<++><Esc>F}i

" Logical symbols
     inoremap <buffer> ;m $$<Space><++><Esc>2T$i
     inoremap <buffer> ;M $$$$<Enter><Enter><++><Esc>2k$hi
     inoremap <buffer> ;neg {\neg}
     inoremap <buffer> ;V {\vee}
     inoremap <buffer> ;or {\vee}
     inoremap <buffer> ;L {\wedge}
     inoremap <buffer> ;and {\wedge}
     inoremap <buffer> ;ra {\rightarrow}
     inoremap <buffer> ;la {\leftarrow}
     inoremap <buffer> ;lra {\leftrightarrow}
     inoremap <buffer> ;fa {\forall}
     inoremap <buffer> ;ex {\exists}
     inoremap <buffer> ;dia	{\Diamond}
     inoremap <buffer> ;box	{\Box}
     inoremap <buffer> ;gt	{\textgreater}
     inoremap <buffer> ;lt	{\textless}
