if exists('g:loaded_ctrlp_git') && g:loaded_ctrlp_git
  finish
endif
let g:loaded_ctrlp_git = 1

let s:system = function(get(g:, 'ctrlp#git#system_function', 'system'))

let s:git_var = {
\  'init':   'ctrlp#git#init()',
\  'exit':   'ctrlp#exit()',
\  'accept': 'ctrlp#acceptfile',
\  'lname':  'git',
\  'sname':  'git',
\  'type':   'path',
\  'nolim':  1,
\  'opmul':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_var)
else
  let g:ctrlp_ext_vars = [s:git_var]
endif

function! ctrlp#git#init()
  return split(s:system('git ls-files'), "\n")
endfunc

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
