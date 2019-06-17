" Identation
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" ALE
let b:ale_linters = {'java': split(system("get-java-project-linter"))}
let g:ale_java_eclipselsp_config_path = expand("$HOME") . '/.jdtls'
let g:ale_java_javalsp_executable = 'java-language-server'
let g:ale_java_javalsp_classpaths = 'LoadDeps'
