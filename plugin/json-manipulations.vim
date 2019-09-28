nnoremap <leader>j :set operatorfunc=<SID>FormatJSON<cr>g@
vnoremap <leader>j :<c-u>call <SID>FormatJSON(visualmode())<cr>

function! s:FormatJSON(type)
  if a:type ==? 'v'
    normal! `<ms
  elseif a:type ==? 'char'
    normal! `[bms
  else
    return
  endif

  normal! `s
  call <SID>IndentBrackets()
  normal! `s
  call <SID>IndentCommas()
  normal! `s
endfunction

function! s:IndentCommas()
  normal %
  let finishLine = line('.')
  normal `s
  let currentLine = line('.')
  while currentLine < finishLine
    if getline('.') !~# ','
      normal! j0
    else
      execute "normal! f,a\<cr>"
      let previousQuotes = count(getline(currentLine), "\"")
      while previousQuotes / 2.0 ==# 1.5
        execute "normal! 0dwi\<c-h>\<space>"
        execute "normal! f,a\<cr>"
        let previousQuotes = count(getline(currentLine), "\"")
      endwhile
    endif

    let currentLine = line('.')
  endwhile
endfunction

function! s:IndentBrackets()
  let matchingExpression = "\\v[{|}|[|\\]]"

  execute "normal! a\<cr>"
  let currentIndent = indent(line('.'))
  let setterIndent = currentIndent + 1
  execute "call \<SID>EvenIndentation(" . currentIndent . ", " . setterIndent . ")"

  let currentIndent = indent(line('.'))
  while currentIndent !=# indent(line("'s"))
    execute "normal! /" . matchingExpression . "\<cr>"
    let currentCharacter = strcharpart(getline('.')[col('.') - 1:], 0, 1)

    if currentCharacter =~# "\\v[{|[]"
      execute "normal! a\<cr>"
      normal! w
      let currentIndent = indent(line('.'))
      let setterIndent = currentIndent + 1
    else
      execute "normal! i\<cr>"
      normal! w
      let currentIndent = indent(line('.'))
      normal! %
      let setterIndent = indent(line('.'))
      normal! %
    endif

    execute "call \<SID>EvenIndentation(" . currentIndent . ", " . setterIndent . ")"
    let currentIndent = indent(line('.'))
  endwhile
endfunction

function! s:EvenIndentation(currentIndent, setterIndent)
  let current = a:currentIndent
  let setter = a:setterIndent
  if current < setter
    while current < setter
      normal! >>
      let current += &shiftwidth
    endwhile
  else
    while current > setter
      normal! <<
      let current -= &shiftwidth
    endwhile
  endif
endfunction
