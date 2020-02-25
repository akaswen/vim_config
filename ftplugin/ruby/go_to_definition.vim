nnoremap <leader>d :call <SID>GrepDefinition()<cr>

function! s:GrepDefinition()
  let saved_unnamed_register = @@

  normal! viwy

  if @@ !=# "."
    silent execute "grep! -R --exclude-dir={node_modules,coverage} " . shellescape("def " . @@) . " ."
    copen
    nohl
    wincmd J
    redraw!
    call matchadd('Search', @@)
  endif

  let @@ = saved_unnamed_register
endfunction
