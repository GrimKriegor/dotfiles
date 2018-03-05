" Indentation
    setlocal shiftwidth=2
    setlocal tabstop=2

" Snippets
    inoremap <buffer> ;b <b></b><Space><++><Esc>FbT>i
    inoremap <buffer> ;i <em></em><Space><++><Esc>FeT>i
    inoremap <buffer> ;h1 <h1></h1><Enter><Enter><++><Esc>2kf<i
    inoremap <buffer> ;h2 <h2></h2><Enter><Enter><++><Esc>2kf<i
    inoremap <buffer> ;h3 <h3></h3><Enter><Enter><++><Esc>2kf<i
    inoremap <buffer> ;p <p></p><Enter><Enter><++><Esc>02kf>a
    inoremap <buffer> ;a <a<Space>href=""><++></a><Space><++><Esc>14hi
    inoremap <buffer> ;e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
    inoremap <buffer> ;ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
    inoremap <buffer> ;li <Esc>o<li></li><Esc>F>a
    inoremap <buffer> ;ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
    inoremap <buffer> ;im <table<Space>class="image"><Enter><caption align="bottom"></caption><Enter><tr><td><a<space>href="pix/<++>"><img<Space>src="pix/<++>"<Space>width="<++>"></a></td></tr><Enter></table><Enter><Enter><++><Esc>4kf>a
    inoremap <buffer> ;td <td></td><++><Esc>Fdcit
    inoremap <buffer> ;tr <tr></tr><Enter><++><Esc>kf<i
    inoremap <buffer> ;th <th></th><++><Esc>Fhcit
    inoremap <buffer> ;tab <table><Enter></table><Esc>O
    inoremap <buffer> ;gr <font color="green"></font><Esc>F>a
    inoremap <buffer> ;rd <font color="red"></font><Esc>F>a
    inoremap <buffer> ;yl <font color="yellow"></font><Esc>F>a
    inoremap <buffer> ;dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
    inoremap <buffer> ;dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
