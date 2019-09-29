nnoremap <leader>s :set operatorfunc=<SID>Surround<cr>g@
vnoremap <leader>s :<c-u>call <SID>Surround(visualmode())<cr>
nnoremap cs :call <SID>ChangeSurround()<cr>

function! s:ChangeSurround()
  let previousCharacter = getchar()
  let newCharacter = getchar()

  execute "normal! ?" . previousCharacter . "\<cr>x"
  call <SID>AddOpening(newCharacter)
  execute "normal! /" . previousCharacter . "\<cr>x"
  call <SID>AddClosing(newCharacter)
  execute "normal! ?" . newCharacter . "\<cr>"
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
  if a:char ==# 34
    let openingCharacter = "\""
  elseif a:char ==# 39
    let openingCharacter = "'"
  elseif a:char ==# 91
    let openingCharacter = "["
  elseif a:char ==# 93
    let openingCharacter = "[ "
  elseif a:char ==# 123
    let openingCharacter = "{"
  elseif a:char ==# 125
    let openingCharacter = "{ "
  elseif a:char ==# 40
    let openingCharacter = "("
  elseif a:char ==# 41
    let openingCharacter = "( "
  elseif a:char ==# 124
    let openingCharacter = "|"
  else
    return
  endif

  execute "normal! i" . openingCharacter
endfunction

function! s:AddClosing(char)
  if a:char ==# 34
    let closingCharacter = "\""
  elseif a:char ==# 39
    let closingCharacter = "'"
  elseif a:char ==# 91
    let closingCharacter = "]"
  elseif a:char ==# 93
    let closingCharacter = " ]"
  elseif a:char ==# 123
    let closingCharacter = "}"
  elseif a:char ==# 125
    let closingCharacter = " }"
  elseif a:char ==# 40
    let closingCharacter = ")"
  elseif a:char ==# 41
    let closingCharacter = " )"
  elseif a:char ==# 124
    let closingCharacter = "|"
  else
    return
  endif

  execute "normal! a" . closingCharacter
endfunction

