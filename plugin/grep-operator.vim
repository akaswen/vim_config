nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
nnoremap <leader>F :call GrepOperatorFullTextSearch("", ".", "-i")<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  call GrepOperatorFullTextSearch(@@, ".", "")

  let @@ = saved_unnamed_register
endfunction


function! g:GrepOperatorFullTextSearch(value, directories, options)
  silent execute "grep! -R " . a:options . " --exclude-dir={node_modules,coverage} " . shellescape(a:value) . " " . shellescape(a:directories)
  copen
  nohl
  wincmd J
  redraw!
  call matchadd('Search', a:value)
endfunction
