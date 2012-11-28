if exists('g:loaded_ctrlp_git_branches') && g:loaded_ctrlp_git_branches
  finish
endif
let g:loaded_ctrlp_git_branches = 1

let s:system = function(get(g:, 'ctrlp#git#system_function', 'system'))

let s:git_branches_var = {
\  'init':   'ctrlp#git_branches#init()',
\  'exit':   'ctrlp#exit()',
\  'accept': 'ctrlp#git_branches#accept',
\  'lname':  'git_branches',
\  'sname':  'git_branches',
\  'type':   'path',
\  'nolim':  1,
\  'opmul':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_branches_var)
else
  let g:ctrlp_ext_vars = [s:git_branches_var]
endif

function! ctrlp#git_branches#init()
  return split(s:system('git branches'), "\n")
endfunc

function! ctrlp#git_branches#accept(mode, str)
  call s:system('git checkout '.shellescape(a:str))
endfunc

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git_branches#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
