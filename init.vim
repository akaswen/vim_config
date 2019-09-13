" plugins ------------------ {{{
" using latest version of neovim
" install instructions: https://github.com/neovim/neovim/wiki/Installing-Neovim
"
" everything loaded with pathogen
" mkdir -p ~/.config/nvim/autoload ~/.config/nvim/bundle && curl -LSso ~/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" ack.vim (requires installing ack dependency)
" cd ~/.config/nvim/bundle && git clone https://github.com/idbrii/vim-ack
"
" ctrlp.vim
" cd ~/.config/nvim/bundle && git clone https://github.com/ctrlpvim/ctrlp.vim
"
" nerdtree
" cd ~/.config/nvim/bundle && git clone https://github.com/scrooloose/nerdtree
"
" vim-airline-themes
" cd ~/.config/nvim/bundle && git clone https://github.com/vim-airline/vim-airline-themes
"
" vim-surround
" cd ~/.config/nvim/bundle && git clone https://github.com/tpope/vim-surround
"
" ale
" cd ~/.config/nvim/bundle && git clone https://github.com/w0rp/ale
"
" nerdcommenter
" cd ~/.config/nvim/bundle && git clone https://github.com/scrooloose/nerdcommenter
"
" vim-airline
" cd ~/.config/nvim/bundle && git clone https://github.com/vim-airline/vim-airline
"
" vim-indent-guides
" cd ~/.config/nvim/bundle && git clone https://github.com/nathanaelkane/vim-indent-guides
"
" vim-css-color
" cd ~/.config/nvim/bundle && git clone https://github.com/ap/vim-css-color
"
" vim-javascript
" cd ~/.config/nvim/bundle && git clone https://github.com/pangloss/vim-javascript
"
" vim-jsx
" cd ~/.config/nvim/bundle && git clone https://github.com/mxw/vim-jsx
"
" gruvbox color scheme
" git clone https://github.com/morhetz/gruvbox.git ~/.config/nvim/bundle/gruvbox
"
" vim-mltiple-cursors
" cd ~/.config/nvim/bundle && git clone https://github.com/terryma/vim-multiple-cursors
"
" fugitive
" cd ~/.config/nvim/bundle && git clone https://github.com/tpope/vim-fugitive
"
" vim-workspace
" cd ~/.config/nvim/bundle && git clone https://github.com/thaerkh/vim-workspace
"
" deoplete
" autocompletion
" cd ~/.config/nvim/bundle && git clone https://github.com/shougo/deoplete.nvim


"load managed plugins with pathogen
execute pathogen#infect()
execute pathogen#helptags()
" }}}

" Settings ------------------- {{{
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

" helps vim to be slightly faster with syntax highlighting turned on
set re=1

" sets splits to be default to bottom or to right
set splitbelow
set splitright
" }}}

" Variables --------------------- {{{
" sets <space> to leader key
let mapleader = ' '

" vim-airline for status lines on top of page
" sets tab theme
let g:airline_theme='powerlineish'

" set smart tab line
let g:airline#extensions#tabline#enabled = 1

" config for indent lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

" for ctrlp to allow all files to load
let g:ctrlp_max_files=0

" ctrlp ignore everything in .gitignore file
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" highlight searched term with ack
let g:ackhighlight = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" sets tab theme
let g:airline_theme='powerlineish'

" sets smart tab line
let g:airline#extensions#tabline#enabled = 1

" allows autosaving with workspace
let g:workspace_autosave_always = 1

" Use deoplete for autocompletion
let g:deoplete#enable_at_startup = 1
" }}}

" Normal Mappings ------------------- {{{

" binds :NERDTreeToggle to nt
nnoremap <leader>nt :NERDTreeToggle<Enter>

" binds :ALToggle to at
nnoremap <leader>at :ALEToggle<Enter>

" sets tb to open new term to bottom
nnoremap <leader>tb :sp \| res 20 \| term<Enter>

" sets tr to open new term to right
nnoremap <leader>tr :vsp \| term<Enter>

" sets ev to open init.vim in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" sets sv to source any changes to init.vim
nnoremap <leader>sv :source $MYVIMRC<cr>

" sets tn to next tab
nnoremap <leader>tn :tabn<cr>

" sets tp to previous tab
nnoremap <leader>tp :tabp<cr>

" closes tab with q
nnoremap <leader>q :q<cr>

" mappings for zsh git shortcuts
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>ggfl :Gpush --force<cr>
nnoremap <leader>gup :Gpull --rebase<cr>

" sets a to open ack search
nnoremap <leader>a :Ack! '' . <Left><Left><Left><Left>

" sets w to change to next buffer 
nnoremap <leader>w <C-w>w
nnoremap <C-w>w <nop>
nnoremap <C-w><C-w> <nop>

" sets p to change to previous buffer 
nnoremap <leader>p <C-w>p
nnoremap <C-w>p <nop>
nnoremap <C-w><C-p> <nop>

" sets a search to always be in regex mode
nnoremap / /\v

" sets hl to stop highlight from last search
nnoremap <leader>hl :noh<cr>

" sets g to run grep function
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" }}}

" Visual Mappings ------------------- {{{
" allows copying text to system clipboard with control-c - needs dependency
" installed to linux sudo apt-get update && sudo apt-get install vim-gtk
vnoremap <C-c> "+y

" allows search of highlighted text with /
vnoremap <leader>/ "+y/<C-r>"<Enter>

" allow ctrl-a to search for highlighted text
vnoremap <leader>a "+y:Ack! "<C-r>"" .

" map surround to S in visual mode
vnoremap <leader>s ysiw
" }}}

" Insert Mappings ----------------- {{{

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" switch buffers when in insert mode
inoremap <C-w>w <Esc><C-w>w
inoremap <C-w><C-w> <Esc><C-w>w
inoremap <C-w>p <Esc><C-w>p
inoremap <C-w><C-p> <Esc><C-w>p

" close current buffer wtih ctrl-q
inoremap <C-q> <Esc>:q<cr>
" }}}
"
" Insert Abbreviations ------------------ {{{
iabbrev <h1> <h1></h1>
iabbrev <h2> <h2></h2>
iabbrev <h3> <h3></h3>
iabbrev <h4> <h4></h4>
iabbrev <h5> <h5></h5>
iabbrev <h6> <h6></h6>
iabbrev <p> <p></p>
iabbrev <small> <small></small>
iabbrev <a> <a href=""></a>
iabbrev <li> <li></li>
iabbrev <ol> <ol></ol>
iabbrev <ul> <ul></ul>
iabbrev <div> <div></div>
" }}}

" Terminal Mappings --------------------- {{{
" allows escaping from terminal with just esc key
tnoremap <Esc> <C-\><C-n>

" allows switching to a different buffer from terminal insert mode
tnoremap <C-w>w <C-\><C-n><C-w>w
tnoremap <C-w><C-w> <C-\><C-n><C-w>w
tnoremap <C-w>p <C-\><C-n><C-w>p
tnoremap <C-w><C-p> <C-\><C-n><C-w>p

" close current buffer wtih ctrl-q
inoremap <C-q> <C-\><C-n>:q<cr>
" }}}

" Other -------------------- {{{

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax enable

colorscheme gruvbox

" sets highlight color to allow ale to work with gruvbox
highlight ALEWarning ctermbg=65
" }}}

" Autocommand Groups ------------- {{{

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
" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
