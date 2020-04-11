set cmdheight=2

ruby << EOF
  vim_path = Vim.evaluate("$VIM")
  load_file = File.join(vim_path, 'plugin', 'lib')
  $LOAD_PATH << load_file unless $LOAD_PATH.include?(load_file)

  require 'tmux_sessions'
EOF

" open terminal with F12
nnoremap <F12> :call <SID>InitiateTerminalSelection()<cr>

" close terminal with F12
tnoremap <F12> <C-W>N:q!<cr>

function! s:InitiateVariables()
  if !exists('t:selecting_terminal')
    let t:selecting_terminal = 0
  endif

  if !exists('t:current_session')
    let t:current_session = "new session"
  endif
endfunction

function! s:InitiateTerminalSelection()
  call <SID>InitiateVariables()

  if t:selecting_terminal
    call <SID>ChangeSelection()
  else
    call <SID>ToggleTerminal()
  endif
endfunction

function! s:ChangeSelection()
ruby << EOF
  Vim.command("call popup_clear()")
  sessions = TmuxSessions::Sessions.new(Vim::evaluate('t:current_session'))
  sessions.increment_session_name
  sessions.create_popup
EOF
endfunction

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
  if no_term_open
    Vim.command("call <SID>OpenTerminalSelector()")
  end
EOF
endfunction

function! s:OpenTerminalSelector()
  let t:selecting_terminal = 1
ruby << EOF
  sessions = TmuxSessions::Sessions.new(Vim.evaluate('t:current_session'))
  sessions.create_popup
EOF
endfunction



" select terminal with enter
nnoremap <expr> <cr> t:selecting_terminal ? ':call <SID>SelectSession()<cr>':'<cr>'

function! s:SelectSession()
  if t:current_session == 'new session'
    let session_name = input('Session Name: ')
    call <SID>OpenNewSession(session_name)
  elseif t:current_session == 'close'
    let t:current_session = 'new session'
    let t:selecting_terminal = 0
    call popup_clear()
  else
    call <SID>OpenExistingSession(t:current_session)
  endif
endfunction

function! s:OpenNewSession(new_session_name)
  let t:current_session = 'new session'
  let t:selecting_terminal = 0
  call popup_clear()

ruby << EOF
  name = Vim::evaluate('a:new_session_name')
  if name == ''
    Vim.command('term tmux')
  else
    name.gsub!(' ', '_')
    Vim.command("execute 'term tmux new -s #{name}'")
  end
EOF

  wincmd J
  resize 20
endfunction

function! s:OpenExistingSession(session_name)
  let t:current_session = 'new session'
  let t:selecting_terminal = 0
  call popup_clear()
  execute "term tmux a -t " . a:session_name
  wincmd J
  resize 20
endfunction

nnoremap <expr> <BS> (exists('t:selecting_terminal') && t:selecting_terminal) ? ':call <SID>DeleteSession()<cr>':'<BS>'

function! s:DeleteSession()
  if t:current_session !=# 'new session' || t:current_session !=# 'close'
    let message = 'Are you sure you want to kill session ' . t:current_session . "? y/n: "
    let decision = input(message)
    if decision == 'y'
      silent execute "!tmux kill-session -t " . t:current_session
      let t:current_session = 'new session'
      let t:selecting_terminal = 0
      call popup_clear()
      redraw!
    endif
  endif
endfunction

augroup open_quickfix
  autocmd!
  autocmd BufRead quickfix call <SID>InitiateVariables()
augroup END

nnoremap <expr> <C-m> (exists('t:selecting_terminal') && t:selecting_terminal) ? ':call <SID>RenameSession()<cr>':'<C-m>'

function! s:RenameSession()
  if t:current_session == 'new sesion' || t:current_session == 'close'
    return
  endif

  let new_session = input('Enter new session name: ')
  let command = "!tmux rename-session -t " . t:current_session . " " . new_session
  echom command
  silent execute command
  redraw!
  call <SID>OpenExistingSession(new_session)
endfunction
