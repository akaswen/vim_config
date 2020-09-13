set shiftwidth=8
set softtabstop=8

nnoremap <leader>d :GoDef<cr>
nnoremap <leader>g :GoImports<cr>:GoFmt<cr>
nnoremap <leader>b :GoDebugBreakpoint<cr>
nnoremap <leader>c :GoDebugContinue<cr>
nnoremap <leader>s :GoDebugStep<cr>
nnoremap <leader>ft :GoTestFunc<cr>
nnoremap <leader>p :GoDebugBreakpoint<cr>

nnoremap <leader>t :call ToggleDebugTest()<cr>

function! ToggleDebugTest()
  if exists(":GoDebugStart")
    GoDebugTest
  else
    GoDebugStop
  endif
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
