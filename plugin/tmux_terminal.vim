" open terminal with F12
nnoremap <F12> :call <SID>OpenTerminal()<cr>

" close terminal with F12
tnoremap <F12> <C-W>N:q!<cr>

function! s:OpenTerminal()
  term tmux
  wincmd J
  resize 20
endfunction
