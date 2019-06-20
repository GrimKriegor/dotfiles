" Identation
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" ALE
let g:ale_linters = {'java': split('checkstyle' . ' ' . system("get-java-project-linter"))}
let g:ale_java_eclipselsp_config_path = expand("$HOME") . '/.jdtls'
let g:ale_java_javalsp_executable = 'java-language-server'

" vim-android
"" workaround for hsanson/vim-android#74
if index(g:ale_linters['java'], 'android') > 0
  call gradle#sync()
endif
