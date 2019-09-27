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

  let @/ = @@

  let @@ = saved_anonymous_register
endfunction
