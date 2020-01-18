let w:selecting_terminal = 0
set cmdheight=2

if !exists('w:current_session')
  let w:current_session = "new session"
endif

" open terminal with F12
nnoremap <F12> :call <SID>InitiateTerminalSelection()<cr>

" close terminal with F12
tnoremap <F12> <C-W>N:q!<cr>

function! s:InitiateTerminalSelection()
  if w:selecting_terminal
  else
    call <SID>ToggleTerminal()
  endif
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
    Vim.command("call <SID>OpenTerminal()")
  end
EOF
endfunction

function! s:OpenTerminal()
  let w:selecting_terminal = 1
ruby << EOF
  vim_path = Vim.evaluate("$VIM")
  load_file = File.join(vim_path, 'plugin', 'lib')
  $LOAD_PATH << load_file unless $LOAD_PATH.include?(load_file)

  require 'tmux_sessions'

  Vim.command("call popup_clear()")
  sessions = TmuxSessions::Sessions.new
  current_width = 1
  names = sessions.sessions.map(&:name).each_with_index do |name, i|
    highlight = 'Comment'
    highlight = 'Search' if name == Vim.evaluate('w:current_session')
    Vim.command("call popup_create('#{name}', {'col': #{current_width}, 'line': 999, 'highlight': '#{highlight}'})")
    current_width += name.length + 2
  end
EOF
endfunction

function! s:OldOpenTerminal()
ruby << EOF
  require 'date'

  sessions = `tmux ls`.split("\n")
  if sessions.length > 1 || sessions[0].include?(":")
    sessions.map! do |session_string|
      {
        session_name: session_string.split(":").first,
        session_date: DateTime.parse(session_string.scan(/\(created (.*\d)\)/).first.first)
      }
    end
    sessions.sort_by! { |ses| ses[:session_date] }.reverse!
    Vim.command("call <SID>OpenExistingSession(#{sessions.first[:session_name]})")
  else
    Vim.command("call <SID>OpenNewSession()")
  end
EOF
endfunction

function! s:OpenNewSession()
  term tmux
  wincmd J
  resize 20
endfunction

function! s:OpenExistingSession(session_name)
  execute "term tmux a -t " . a:session_name
  wincmd J
  resize 20
endfunction
