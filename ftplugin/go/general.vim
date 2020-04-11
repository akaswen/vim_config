set shiftwidth=8
set softtabstop=8

augroup fmt_go
  autocmd!
  autocmd BufWritePost *.go execute "GoFmt"
augroup END
