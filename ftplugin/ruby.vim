inoremap <Enter> <Enter><esc>:call <SID>CompleteMethod()<cr>i

function! s:CompleteMethod()
  let lineNumber = line('.')
  let lineNumber -= 1
  let lineNumberChecker = lineNumber
  let line = getline(lineNumber)
  let indent = indent(lineNumber) / &shiftwidth

  while getline(lineNumberChecker) =~ '\v^\s*$' && lineNumberChecker !=# 1
    let lineNumberChecker -= 1
    let indent = indent(lineNumberChecker) / &shiftwidth
  endwhile

  if line =~ '\v do( \|.*\|\s*)?$' || line =~ '\v(^|\s*)(def |class |module |if |unless)'
    call <SID>IndentThisLine(indent)
    normal! iend
    s/\s*$//g
    execute "normal! k$o"
    call <SID>IndentThisLine(indent + 1)
  else
    if line =~ '\v^\s*$'
      call setline(lineNumber, '')
    endif

    call <SID>IndentThisLine(indent)
  endif
endfunction

function! s:IndentThisLine(num)

  normal! it
  let indentNumber = a:num
  while indentNumber > 0
    normal! v>

    let indentNumber -= 1
  endwhile
  execute "normal! r\<space>"
endfunction
