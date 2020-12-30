set shiftwidth=8
set softtabstop=8

nnoremap <leader>d :GoDef<cr>
nnoremap <leader>i :GoImports<cr>:GoFmt<cr>zR
nnoremap <leader>b :GoDebugBreakpoint<cr>
nnoremap <leader>c :GoDebugContinue<cr>
nnoremap <leader>s :GoDebugStep<cr>
nnoremap <leader>ft :GoTestFunc!<cr>
nnoremap <leader>p :GoDebugBreakpoint<cr>
nnoremap <leader>r :GoRun<cr>
nnoremap B :!go test -bench=.<cr>

nnoremap <leader>T :call ToggleDebug()<cr>

function! ToggleDebug()
  if exists(":GoDebugStart")
    if expand('%:t') =~ '\v_test.go\Z'
      GoDebugTest .
    else
      GoDebugStart .
    endif
  else
    GoDebugStop
  endif
endfunction

nnoremap <leader>t :call <SID>RunTests()<cr>

function! s:RunTests()
  let currentFile = expand('%:t')
  if currentFile =~ '\v_test.go\Z'
    let otherFile = substitute(currentFile, '\v_test.go\Z', '.go', '')
  else
    let otherFile = substitute(currentFile, '\v.go\Z', '_test.go', '')
  endif

  execute "GoTest " . currentFile . " " . otherFile
endfunction

" go debugger
cnoreabbrev gdb GoDebugStart
cnoreabbrev gdbt GoDebugTest
cnoreabbrev gdoc GoDocBrowser
cnoreabbrev gc GoDebugContinue
cnoreabbrev gn GoDebugNext
cnoreabbrev gs GoDebugStep
cnoreabbrev gso GoDebugStepOut
cnoreabbrev gset GoDebugSet
cnoreabbrev p GoDebugPrint

setlocal foldmethod=indent
