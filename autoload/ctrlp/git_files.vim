if exists('g:loaded_ctrlp_git_files') && g:loaded_ctrlp_git_files
  finish
endif
let g:loaded_ctrlp_git_files = 1

let s:system = function(get(g:, 'ctrlp#git#system_function', 'system'))

let s:git_files_var = {
\  'init':   'ctrlp#git_files#init()',
\  'exit':   'ctrlp#exit()',
\  'accept': 'ctrlp#acceptfile',
\  'lname':  'git_files',
\  'sname':  'git_files',
\  'type':   'path',
\  'nolim':  1,
\  'opmul':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_files_var)
else
  let g:ctrlp_ext_vars = [s:git_files_var]
endif

function! ctrlp#git_files#init()
  return split(s:system('git ls-files'), "\n")
endfunc

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git_files#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
