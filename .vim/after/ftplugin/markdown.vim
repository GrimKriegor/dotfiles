" Snippets
    map <leader>w yiWi[<esc>Ea](<esc>pa)
    inoremap ;n ---<Enter><Enter>
    inoremap ;b ****<++><Esc>F*hi
    inoremap ;s ~~~~<++><Esc>F~hi
    inoremap ;e **<++><Esc>F*i
    inoremap ;h ====<Space><++><Esc>F=hi
    inoremap ;i ![](<++>)<++><Esc>F[a
    inoremap ;a [](<++>)<++><Esc>F[a
    inoremap ;1 #<Space><Enter><++><Esc>kA
    inoremap ;2 ##<Space><Enter><++><Esc>kA
    inoremap ;3 ###<Space><Enter><++><Esc>kA
    inoremap ;l --------<Enter>
    map <F5> :!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>
    map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<spa    ce>--vanilla<enter>
    inoremap ;r ```{r}<CR>```<CR><CR><esc>2kO
    inoremap ;p ```{python}<CR>```<CR><CR><esc>2kO

