nnoremap <leader>s :set operatorfunc=<SID>Surround<cr>g@
vnoremap <leader>s :<c-u>call <SID>Surround(visualmode())<cr>
nnoremap cs :call <SID>ChangeSurround()<cr>

function! s:ChangeSurround()
  let previousCharacter = nr2char(getchar())
  let newCharacter = nr2char(getchar())
  let currentCharacter = strcharpart(getline('.')[col('.') - 1:], 0, 1)

  let previousOpenCharacter = previousCharacter
  let previousCloseCharacter = previousCharacter
  let newOpenCharacter = newCharacter

  if previousCharacter ==# "(" || previousCharacter ==# ")"
    let previousOpenCharacter = "("
    let previousCloseCharacter = ")"
  elseif previousCharacter ==# "[" || previousCharacter ==# "]"
    let previousOpenCharacter = "["
    let previousCloseCharacter = "]"
  elseif previousCharacter ==# "{" || previousCharacter ==# "}"
    let previousOpenCharacter = "{"
    let previousCloseCharacter = "}"
  endif

  if newOpenCharacter ==# "(" || newOpenCharacter ==# ")"
    let newOpenCharacter = "("
  elseif newOpenCharacter ==# "[" || newOpenCharacter ==# "]"
    let newOpenCharacter = "["
  elseif newOpenCharacter ==# "{" || newOpenCharacter ==# "}"
    let newOpenCharacter = "{"
  endif


  if currentCharacter ==# previousOpenCharacter
    normal! x
  else
    execute "normal! ?" . previousOpenCharacter . "\<cr>x"
  endif

  call <SID>AddOpening(newCharacter)
  execute "normal! /" . previousCloseCharacter . "\<cr>xh"
  call <SID>AddClosing(newCharacter)
  execute "normal! ?" . newOpenCharacter . "\<cr>"
endfunction

function! s:Surround(mode)
  normal! mp
  let char = getchar()

  if a:mode ==? 'v'
    normal! `<mo`>
  elseif a:mode ==? 'char'
    normal! `[mo`]
  endif

  call <SID>SurroundMarks(char)
  normal! `p
endfunction

function! s:SurroundMarks(char)
  call <SID>AddClosing(a:char)
  normal! `o
  call <SID>AddOpening(a:char)
endfunction

function! s:AddOpening(char)
  if a:char ==# "\""
    let openingCharacter = "\""
  elseif a:char ==# "'"
    let openingCharacter = "'"
  elseif a:char ==# "["
    let openingCharacter = "["
  elseif a:char ==# "]"
    let openingCharacter = "[ "
  elseif a:char ==# "{"
    let openingCharacter = "{"
  elseif a:char ==# "}"
    let openingCharacter = "{ "
  elseif a:char ==# "("
    let openingCharacter = "("
  elseif a:char ==# ")"
    let openingCharacter = "( "
  elseif a:char ==# "|"
    let openingCharacter = "|"
  else
    return
  endif

  execute "normal! i" . openingCharacter
endfunction

function! s:AddClosing(char)
  if a:char ==# "\""
    let closingCharacter = "\""
  elseif a:char ==# "'"
    let closingCharacter = "'"
  elseif a:char ==# "["
    let closingCharacter = "]"
  elseif a:char ==# "]"
    let closingCharacter = " ]"
  elseif a:char ==# "{"
    let closingCharacter = "}"
  elseif a:char ==# "}"
    let closingCharacter = " }"
  elseif a:char ==# "("
    let closingCharacter = ")"
  elseif a:char ==# ")"
    let closingCharacter = " )"
  elseif a:char ==# "|"
    let closingCharacter = "|"
  else
    return
  endif

  execute "normal! a" . closingCharacter
endfunction

