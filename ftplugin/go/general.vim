set shiftwidth=8
set softtabstop=8

nnoremap <leader>d :GoDef<cr>
nnoremap <leader>g :GoImports<cr>:GoFmt<cr>
nnoremap <leader>b :GoBuild<cr>
nnoremap <leader>e :GoRun<cr>
nnoremap <leader>t :GoTest<cr>
nnoremap <leader>ft :GoTestFunc<cr>
nnoremap <leader>p :GoDebugBreakpoint<cr>

" go debugger
cnoreabbrev gdb GoDebugStart
cnoreabbrev gdbt GoDebugTest
cnoreabbrev gdoc GoDocBrowser
cnoreabbrev gc GoDebugContinue
cnoreabbrev gn GoDebugNext
cnoreabbrev gs GoDebugStep
cnoreabbrev gso GoDebugStepOut
cnoreabbrev gset GoDebugSet
cnoreabbrev gprint GoDebugPrint
