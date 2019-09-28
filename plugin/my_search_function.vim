" sets a search to always be in regex mode
nnoremap / /\v

" sets hl to stop highlight from last search
nnoremap <leader>hl :call DeleteSearchMatches()<cr>:noh<cr>

" allows search with motion
nnoremap <leader>/ :set operatorfunc=<SID>SearchOperator<cr>g@
vnoremap <leader>/ :<c-u>call <SID>SearchOperator(visualmode())<cr>


function! s:SearchOperator(type)
  let saved_anonymous_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  call DeleteSearchMatches()

  let @/ = @@
  call matchadd('search', @/)

  let @@ = saved_anonymous_register
endfunction

function! DeleteSearchMatches()
  let matches = getmatches()

  for i in matches
    if i['group'] ==# 'Search'
      call matchdelete(i['id'])
    endif
  endfor
endfunction

