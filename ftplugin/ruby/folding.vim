setlocal foldmethod=expr
setlocal foldexpr=GetRubyFold(v:lnum)

function! GetRubyFold(lnum)
  if getline(a:lnum - 1) =~? '\v^\s*def\s'
    return "a1"
  endif

  if getline(a:lnum - 1) =~? '\v^\s*if\s'
    return "a1"
  endif

  if getline(a:lnum - 1) =~? '\v^\s*unless\s'
    return "a1"
  endif

  if getline(a:lnum - 1) =~? '\v\sdo\s*$'
    return "a1"
  endif

  if getline(a:lnum + 1) =~? '\v^\s*end\s*$'
    return "s1"
  endif

  return '-1'
endfunction
