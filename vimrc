execute pathogen#infect()
execute pathogen#helptags()

" Settings and Variables----------------- {{{{{{{{{{{{

" Enable syntax highlighting
syntax enable

" sets <space> to leader key
let mapleader = "\<Space>"

let $VIM = $HOME . "/.vim"

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Setting dark mode
set background=dark

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" When opening a new line and no filetype-specific indenting is enabled,
" keep the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm


" Use visual bell instead of beeping when doing something wrong
set visualbell

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number relativenumber

" Indentation settings for using 2 spaces instead of tabs.
set shiftwidth=2
set softtabstop=2
set expandtab

" indents wrapped text
set breakindent

" decreases time it takes for cursor hold event to fire for autosave
set updatetime=1000

"" helps vim to be slightly faster with syntax highlighting turned on
"set re=1

" disable swap files
set noswapfile

" sets splits to be default to bottom or to right
set splitbelow
set splitright

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" supposed to make vim faster with syntax highlighting
set re=1

" highlights searched term
set hlsearch

" auto jumps to first match for search
set incsearch

" make backspace work normally
set backspace=indent,eol,start
" }}}}}}}}}}}}

" Plugins settings ----------------- {{{
" for ctrlp to allow all files to load
let g:ctrlp_max_files=0

" ctrlp ignore everything in .gitignore file
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" sets highlight color to allow ale to work with gruvbox
highlight ALEWarning ctermbg=65

colorscheme gruvbox

" config for indent lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

" config for vim airlines
let g:airline_section_c = '%f (buf %n)'
let g:airline_section_y = ''
let g:airline_section_x = ''
let g:airline_section_z = 'line: %l/%L, col: %c'
let g:airline_theme="dark"

" shows hidden files by default in nerdtree
let NERDTreeShowHidden=1

let g:NERDTreeWinSize=50

" }}}

" Normal Mappings----------------- {{{
" sets ev to open init.vim in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" sets sv to source any changes to init.vim
nnoremap <leader>sv :source $MYVIMRC<cr>

" sets tn to next tab
nnoremap <leader>tn :tabn<cr>

" sets tp to previous tab
nnoremap <leader>tp :tabp<cr>

" closes tab with q
nnoremap <leader>q :q!<cr>

" sets w to change to next buffer
nnoremap <C-w>w <nop>
nnoremap <C-w><C-w> <nop>

" sets p to change to previous buffer
nnoremap <C-w>p <nop>
nnoremap <C-w><C-p> <nop>

" shortkey for switching buffers
nnoremap <leader>b :call SwitchBuffers()<left>

function! SwitchBuffers(num)
  let currentBuffer = bufnr('%')
  while currentBuffer !=# a:num
    execute "normal! \<c-w>w"

    let currentBuffer = bufnr('%')
  endwhile
endfunction

" quickfix window mappings
nnoremap <leader>t :call OpenQuickFix('t')<cr>
nnoremap <leader>i :call OpenQuickFix('i')<cr>
nnoremap <leader>s :call OpenQuickFix('s')<cr>
nnoremap <cr> :call OpenQuickFix('enter')<cr>

function! OpenQuickFix(letter)
  if &buftype ==# 'quickfix'
    if a:letter ==# 't'
      set switchbuf=newtab
    elseif a:letter ==# 'i'
      set switchbuf=vsplit
    elseif a:letter ==# 's'
      set switchbuf=split
    elseif a:letter ==# 'enter'
      set switchbuf=useopen
    endif

    execute "normal! \<cr>"
  endif
endfunction

" vimdiff mappings
nnoremap <leader>d :call ToggleDiffMode()<cr>

function! ToggleDiffMode()
  if &diff
    diffo
  else
    diffthis
  endif
endfunction

" allows changing windows with alt + movement key
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

" easy redraw
nnoremap <leader>r :redraw!<cr>

" Plugin Related normal Mappings -------------- {{{
" binds :ALToggle to at
nnoremap <leader>at :ALEToggle<Enter>

" binds :NERDTreeToggle to nt
nnoremap <leader>nt :NERDTreeToggle<Enter>
" }}}
" }}}

" Visual Mappings----------------- {{{
" allows copying text to system clipboard with control-c -
" linux needs dependency installed, but mac uses something else
" sudo apt-get update && sudo apt-get install vim-gtk

vnoremap <C-c> :<C-u>call CopyToClipboard()<cr>

function! CopyToClipboard()
  normal! `<v`>"+y
endfunction

" }}}

" Insert Mappings ----------------- {{{
" allows changing windows with alt + movement key
inoremap <C-h> <Esc><c-w>h
inoremap <C-j> <Esc><c-w>j
inoremap <C-k> <Esc><c-w>k
inoremap <C-l> <Esc><c-w>l
"" }}}

" Command Mappings -----------------{{{

" Plugin Related Command Mappings ------- {{{
" ZSH abbreviations for fugitive commands
cnoreabbrev gp call PushBranch()
cnoreabbrev ggfl Gpush --force
cnoreabbrev gup call ForcePushBranch()

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! PushBranch()
  let branch = GitBranch()
  execute "Gpush -u origin " . branch
endfunction

function! ForcePushBranch()
  let branch = GitBranch()
  execute "Gpush --force -u origin " . branch
endfunction

" }}}
" }}}

" Terminal Mappings --------------------- {{{
" allows changing windows with alt + movement key
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l

tnoremap <C-n> <C-\><C-n>
" }}}

" Autocmd Groups ---------------------------- {{{
" sets folding for vim files
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup autosave
  autocmd!
  autocmd VimLeavePre,FocusLost,CursorHold,CursorHoldI,WinLeave,TabLeave,InsertLeave,BufDelete,BufWinLeave * call AutoSave()
augroup END

function! AutoSave()
  if &buftype !=# 'terminal' && &buftype != "nofile"
    if &modified
      :w
    endif
  endif
endfunction

" removes white space from ends of lines upon closing a file
augroup remove_whitespace
  autocmd!
  autocmd BufLeave * call RemoveWhiteSpace()
augroup END

function! RemoveWhiteSpace()
  if &modifiable
ruby << EOF
  buf = Vim::Buffer.current
  (1..buf.count).each do |n|
    line = buf[n]
    if line.match?(/\s+$/)
      buf[n] = line.rstrip
    end
  end
EOF
  endif
endfunction

" Autocmd for plugins ---------------- {{{
augroup nerd_tree
  autocmd!

  autocmd vimenter * call OpenNerdTree()
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

function! OpenNerdTree()
  if !(&diff)
    NERDTree
    execute "normal! \<c-w>w"
    if expand('%') == ''
      execute "normal! \<c-w>w"
    endif
  endif
endfunction
"  }}}

" }}
