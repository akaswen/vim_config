" open terminal with F12
nnoremap <F12> :call <SID>ToggleTerminal()<cr>

" close terminal with F12
tnoremap <F12> <C-W>N:q!<cr>

function! s:ToggleTerminal()
ruby << EOF
  no_term_open = true
  Vim::Window.count.times do |n|
    win = Vim::Window[n]
    result = Vim::evaluate("getbufvar(#{win.buffer.number}, '&buftype', 'normal')")
    if result == 'terminal'
      no_term_open = false
      Vim.command("bd! #{win.buffer.number}")
    end
  end
  Vim.command("call <SID>OpenTerminal()") if no_term_open
EOF
endfunction

function! s:OpenTerminal()
  term tmux
  wincmd J
  resize 20
endfunction
