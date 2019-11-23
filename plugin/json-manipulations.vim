nnoremap <leader>j :set operatorfunc=<SID>FormatJSON<cr>g@
vnoremap <leader>j :<c-u>call <SID>FormatJSON(visualmode())<cr>

function! s:FormatJSON(type)
  if a:type ==? 'v'
    normal! `<v`>d
  elseif a:type ==? 'char'
    normal! `[hv`]ld
  else
    return
  endif

ruby << EOF
  vim_path = Vim.evaluate("$VIM")
  load_file = File.join(vim_path, 'plugin', 'lib')
  $LOAD_PATH << load_file unless $LOAD_PATH.include?(load_file)

  require 'json_manipulator'

  test = JsonManipulator::Manipulator.new(Vim.evaluate('@@')).pretty_print
EOF
endfunction
