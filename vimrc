execute pathogen#infect()
execute pathogen#helptags()

" Settings and Variables----------------- {{{

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
" }}}

" Plugins settings ----------------- {{{
" for ctrlp to allow all files to load
let g:ctrlp_max_files=0

" ctrlp ignore everything in .gitignore file
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" sets highlight color to allow ale to work with gruvbox
highlight ALEWarning ctermbg=65

" Use deoplete for autocompletion
let g:deoplete#enable_at_startup = 1

colorscheme gruvbox

" config for indent lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

" config for vim airlines
let g:airline_section_c = '%t%m (buf %n)'
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

"" sets tb to open new term to bottom
"nnoremap <leader>tb :sp \| res 20 \| term<Enter>
"
"" sets tr to open new term to right
"nnoremap <leader>tr :vsp \| term<Enter>

" sets tn to next tab
nnoremap <leader>tn :tabn<cr>

" sets tp to previous tab
nnoremap <leader>tp :tabp<cr>

" closes tab with q
nnoremap <leader>q :q<cr>

" sets w to change to next buffer
nnoremap <leader>w <C-w>w
nnoremap <C-w>w <nop>
nnoremap <C-w><C-w> <nop>

" sets p to change to previous buffer
nnoremap <leader>p <C-w>p
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

nnoremap t :call OpenQuickFix('t')<cr>
nnoremap v :call OpenQuickFix('v')<cr>
nnoremap s :call OpenQuickFix('s')<cr>
nnoremap <cr> :call OpenQuickFix('enter')<cr>

function! OpenQuickFix(letter)
  if &buftype ==# 'quickfix'
    if a:letter ==# 't'
      set switchbuf=newtab
    elseif a:letter ==# 'v'
      set switchbuf=vsplit
    elseif a:letter ==# 's'
      set switchbuf=split
    elseif a:letter ==# 'enter'
      set switchbuf=useopen
    endif

    execute "normal! \<cr>"
  else
    if a:letter ==# 'enter'
      execute "normal! \<cr>"
    else
      execute "normal! " . a:letter
    endif
  endif
endfunction

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
  normal! `<v`>"*y
  " TODO figure out this for mac vnoremap <C-c> :w !pbcopy<cr><cr>
endfunction

" }}}

" Insert Mappings ----------------- {{{

" Plugin Related Insert Mappings ---- {{{
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
"" }}}

" Command Mappings -----------------{{{

" Plugin Related Command Mappings ------- {{{
" ZSH abbreviations for fugitive commands
cnoremap gp call PushCurrentBranch('')<cr>
cnoremap ggfl call PushCurrentBranch('force ')<cr>
cnoreabbrev gup Gpull --rebase origin

function! PushCurrentBranch(force)
  let branch = FugitiveHead()
  silent execute "Gpush origin " . a:force . branch
endfunction

" }}}
" }}}

"" Terminal Mappings --------------------- {{{
" allows escaping from terminal with just esc key
"tnoremap <Esc> <C-\><C-n>
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
  if strlen(expand('%:e')) > 0 " checks if buffer is a file type and not directory
    if &buftype !=# 'terminal'
      if &modified
        :w
      endif
    endif
  endif
endfunction

" add jbuilder syntax highlighting
augroup jbuilder_files
  autocmd!
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
augroup END

" removes numbers from terminal
"augroup term_no_num
"  autocmd!
"  autocmd TermOpen * setlocal nonumber norelativenumber
"augroup END

" removes white space from ends of lines upon closing a file
augroup remove_whitespace
  autocmd!
  autocmd BufLeave *.rb,*.jbuilder,*.js,*.yml,*.vim call RemoveWhiteSpace()
augroup END

function! RemoveWhiteSpace()
  let current_line = line('.')

  %s/\s*$//g
  if &modified
    execute "w"
  endif

  execute "normal! " . current_line . "G"
endfunction

" Autocmd for plugins ---------------- {{{
augroup nerd_tree
  autocmd!
  autocmd vimenter * NERDTree | execute "normal! \<c-w>w" | if expand('%') == '' | execute "normal! \<c-w>w" | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
"  }}}

" }}}
