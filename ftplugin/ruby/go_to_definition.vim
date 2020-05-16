nnoremap <leader>d :call <SID>GrepDefinition()<cr>

function! s:GrepDefinition()
  let saved_unnamed_register = @@

  normal! viwy

  if @@ !=# "."
    silent execute "Ack! '(def|class|module) " . shellescape(@@) . "' ."
    call matchadd('Search', @@)
  endif

  let @@ = saved_unnamed_register
endfunction
