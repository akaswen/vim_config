nnoremap <leader>g :set operatorfunc=<SID>AckOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>AckOperator(visualmode())<cr>
nnoremap <leader>F :call AckOperatorFullTextSearch("", ".")<Left><Left><Left><Left><Left><Left><Left>

function! s:AckOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  call AckOperatorFullTextSearch(@@, ".")

  let @@ = saved_unnamed_register
endfunction


function! g:AckOperatorFullTextSearch(value, directories)
  silent execute "Ack! " . shellescape(a:value) . " " . shellescape(a:directories)
  call matchadd('Search', a:value)
endfunction
