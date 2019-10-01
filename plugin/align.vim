vnoremap <leader>a :<c-u>call <SID>Align()<cr>

function! s:Align()
  let alignCharacter = nr2char(getchar())
  normal! `<
  let currentLine = line("'<")
  let endLine = line("'>")
  let alignColumn = 0
  while currentLine <= endLine
    execute "normal! 0f" . alignCharacter
    if alignCharacter ==# ":"
      normal! l
    endif
    let col = col('.')
    if alignColumn < col
      let alignColumn = col
    endif

    normal! j
    let currentLine = line('.')
  endwhile

  normal! `<
  let currentLine = line('.')

  while currentLine <= endLine
    execute "normal! 0f" . alignCharacter
    if alignCharacter ==# ":"
      normal! l
    endif

    execute "normal! " . alignColumn . "i\<space>\<esc>0" . alignColumn . "lvwhx"

    normal! j
    let currentLine = line('.')
  endwhile
  normal! `<
endfunction
