" plugins ------------------ {{{
" using latest version of neovim
" install instructions: https://github.com/neovim/neovim/wiki/Installing-Neovim

" everything loaded with pathogen
" mkdir -p ~/.config/nvim/autoload ~/.config/nvim/bundle && curl -LSso ~/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

" ale
" cd ~/.config/nvim/bundle && git clone https://github.com/w0rp/ale

" ctrlp.vim
" cd ~/.config/nvim/bundle && git clone https://github.com/ctrlpvim/ctrlp.vim

" deoplete
" autocompletion
" cd ~/.config/nvim/bundle && git clone https://github.com/shougo/deoplete.nvim

" gruvbox color scheme
" git clone https://github.com/morhetz/gruvbox.git ~/.config/nvim/bundle/gruvbox

" nerdcommenter
" cd ~/.config/nvim/bundle && git clone https://github.com/scrooloose/nerdcommenter

" vim-indent-guides
" cd ~/.config/nvim/bundle && git clone https://github.com/nathanaelkane/vim-indent-guides

"load managed plugins with pathogen
execute pathogen#infect()
execute pathogen#helptags()
" }}}

" Settings and Variables----------------- {{{

" Enable syntax highlighting
syntax enable

" sets <space> to leader key
let mapleader = "\<Space>"

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
" }}}

" Normal Mappings----------------- {{{
" sets ev to open init.vim in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" sets sv to source any changes to init.vim
nnoremap <leader>sv :source $MYVIMRC<cr>

" sets a search to always be in regex mode
nnoremap / /\v

" sets tb to open new term to bottom
nnoremap <leader>tb :sp \| res 20 \| term<Enter>

" sets tr to open new term to right
nnoremap <leader>tr :vsp \| term<Enter>

" sets tn to next tab
nnoremap <leader>tn :tabn<cr>

" sets tp to previous tab
nnoremap <leader>tp :tabp<cr>

" sets hl to stop highlight from last search
nnoremap <leader>hl :noh<cr>

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

" sets ctrl-shift-f to set up a search
nnoremap <leader>F :grep! -R --exclude-dir=node_modules '' . \| copen

" Plugin Related normal Mappings -------------- {{{
" binds :ALToggle to at
nnoremap <leader>at :ALEToggle<Enter>

" binds :NERDTreeToggle to nt
nnoremap <leader>nt :NERDTreeToggle<Enter>
" }}}
" }}}

" Visual Mappings----------------- {{{
" allows copying text to system clipboard with control-c - needs dependency
" installed to linux sudo apt-get update && sudo apt-get install vim-gtk
vnoremap <C-c> "+y
" }}}

" Insert Mappings ----------------- {{{

" Plugin Related Insert Mappings ---- {{{
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
"" }}}

" Command Mappings -----------------{{{

" Plugin Related Command Mappings ------- {{{
" ZSH abbreviations for fugitive commands
cnoreabbrev gp Gpush
cnoreabbrev ggfl Gpush --force
cnoreabbrev gup Gpull --rebase
" }}}
" }}}

"" Terminal Mappings --------------------- {{{
" allows escaping from terminal with just esc key
tnoremap <Esc> <C-\><C-n>
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
augroup term_no_num
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" removes white space from ends of lines upon closing a file
augroup remove_whitespace
  autocmd!
  autocmd BufLeave *.rb,*.jbuilder,*.js,*.yml,*.vim call RemoveWhiteSpace()
augroup END

function! RemoveWhiteSpace()
  normal! ma
  %s/\s*$//g
  execute "w"
  normal! 'a
endfunction

" }}}
