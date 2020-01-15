" Snippets
    map <buffer> <leader>w yiWi[<esc>Ea](<esc>pa)
    inoremap <buffer> ;n ---<Enter><Enter>
    inoremap <buffer> ;b ****<++><Esc>F*hi
    inoremap <buffer> ;s ~~~~<++><Esc>F~hi
    inoremap <buffer> ;e **<++><Esc>F*i
    inoremap <buffer> ;h ====<Space><++><Esc>F=hi
    inoremap <buffer> ;i ![](<++>)<++><Esc>F[a
    inoremap <buffer> ;a [](<++>)<++><Esc>F[a
    inoremap <buffer> ;1 #<Space><Enter><++><Esc>kA
    inoremap <buffer> ;2 ##<Space><Enter><++><Esc>kA
    inoremap <buffer> ;3 ###<Space><Enter><++><Esc>kA
    inoremap <buffer> ;l --------<Enter>
    map <buffer> <F5> :!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>

" Tables
let g:table_mode_corner='|'
