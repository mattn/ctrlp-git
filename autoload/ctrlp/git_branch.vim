if exists('g:loaded_ctrlp_git_branch') && g:loaded_ctrlp_git_branch
  finish
endif
let g:loaded_ctrlp_git_branch = 1

let s:system = function(get(g:, 'ctrlp#git#system_function', 'system'))

let s:git_branch_var = {
\  'init':   'ctrlp#git_branch#init()',
\  'accept': 'ctrlp#git_branch#accept',
\  'lname':  'git_branch',
\  'sname':  'git_branch',
\  'type':   'path',
\  'nolim':  1,
\  'opmul':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:git_branch_var)
else
  let g:ctrlp_ext_vars = [s:git_branch_var]
endif

function! ctrlp#git_branch#init()
  return map(split(s:system('git branch'), "\n"), 'v:val[2:]')
endfunc

function! ctrlp#git_branch#accept(mode, str)
  call ctrlp#exit()
  echo s:system('git checkout '.shellescape(a:str))
endfunc

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#git_branch#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
