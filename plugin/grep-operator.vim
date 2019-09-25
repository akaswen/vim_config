nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  silent execute "grep! -R --exclude-dir=node_modules " . shellescape(@@) . " ."
  copen
  nohl
  call matchadd('Search', @@)

  let @@ = saved_unnamed_register
endfunction

nnoremap <leader>F :call GrepOperatorFullTextSearch("", ".")

function! g:GrepOperatorFullTextSearch(value, directories)
  silent execute "grep! -R --exclude-dir=node_modules " . shellescape(a:value) . " " . shellescape(a:directories)
  copen
  nohl
  call matchadd('Search', a:value)
endfunction
