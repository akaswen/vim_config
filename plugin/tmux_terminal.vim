" open terminal with F12
nnoremap <F12> :call <SID>OpenTerminal()<cr>

" close terminal with F12
tnoremap <F12> <C-W>N:q!<cr>

function! s:OpenTerminal()
  let tmux_sessions = split(system('tmux ls'), "\n")
  if len(tmux_sessions) >= 0
    let tmux_session = split(tmux_sessions[0], ":")
    let tmux_session_name = tmux_session[0]
    execute "term ++rows=20 tmux a -t " . tmux_session_name
  else
    term tmux ++rows=20
  endif
endfunction
