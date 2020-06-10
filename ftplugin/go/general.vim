set shiftwidth=8
set softtabstop=8

nnoremap <leader>d :GoDef<cr>
nnoremap <leader>g :GoImports<cr>:GoFmt<cr>

augroup format_go
  autocmd!
  autocmd BufLeave,WinLeave,VimLeave *.go :GoImports
augroup END
