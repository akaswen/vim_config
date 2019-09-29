nnoremap <leader>1 :call <SID>SwitchBuffers(1)<cr>
nnoremap <leader>2 :call <SID>SwitchBuffers(2)<cr>
nnoremap <leader>3 :call <SID>SwitchBuffers(3)<cr>
nnoremap <leader>4 :call <SID>SwitchBuffers(4)<cr>
nnoremap <leader>5 :call <SID>SwitchBuffers(5)<cr>
nnoremap <leader>6 :call <SID>SwitchBuffers(6)<cr>
nnoremap <leader>7 :call <SID>SwitchBuffers(7)<cr>
nnoremap <leader>8 :call <SID>SwitchBuffers(8)<cr>
nnoremap <leader>9 :call <SID>SwitchBuffers(9)<cr>

function! s:SwitchBuffers(num)
  let currentBuffer = bufnr('%')
  while currentBuffer !=# a:num
    execute "normal! \<c-w>w"

    let currentBuffer = bufnr('%')
  endwhile
endfunction
