" Ale
let b:ale_linters = {'c': ['ccls'], 'cpp': ['ccls']}

let g:custom_c_linter = Filify#process('.ale_linter', {'default_return':'gcc'})
let g:ale_c_cc_executable = g:custom_c_linter
let g:custom_c_options = Filify#process('.ale_config', {'default_return':'-std=c11 -Wall'})
let g:ale_c_cc_options = g:custom_c_options
let g:ale_c_clang_options = g:custom_c_options
let g:ale_c_clangcheck_options = g:custom_c_options
let g:ale_c_clangd_options = g:custom_c_options
let g:ale_c_clangtidy_options = g:custom_c_options
let g:ale_c_clazy_options = g:custom_c_options
let g:ale_c_cpplint_options = g:custom_c_options
let g:ale_c_flawfinder_options = g:custom_c_options
let g:ale_c_gcc_options = g:custom_c_options

let g:custom_cpp_linter = Filify#process('.ale_linter', {'default_return':'gcc'})
let g:ale_cpp_cc_executable = g:custom_cpp_linter
let g:custom_cpp_options = Filify#process('.ale_config', {'default_return':'-std=c++14 -Wall'})
let g:ale_cpp_cc_options = g:custom_cpp_options
let g:ale_cpp_clang_options = g:custom_cpp_options
let g:ale_cpp_clangcheck_options = g:custom_cpp_options
let g:ale_cpp_clangd_options = g:custom_cpp_options
let g:ale_cpp_clangtidy_options = g:custom_cpp_options
let g:ale_cpp_clazy_options = g:custom_cpp_options
let g:ale_cpp_cpplint_options = g:custom_cpp_options
let g:ale_cpp_flawfinder_options = g:custom_cpp_options
let g:ale_cpp_gcc_options = g:custom_cpp_options
