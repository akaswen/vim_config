set shiftwidth=8
set softtabstop=8

augroup auto_import
  autocmd!
  autocmd VimLeavePre,FocusLost,CursorHold,CursorHoldI,WinLeave,TabLeave,InsertLeave,BufDelete,BufWinLeave *.go if &buftype != 'nofile' | execute "GoImports" | execute "GoFmt" | endif
augroup END
