source ~/.vim/plugins.vim

" =========================================================================== "
" ===                          GENERAL CONFIG                             === "
" =========================================================================== "

" Change leader to a comma because the backslash is too far away
let mapleader=","

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

" set utf8 to show glyphs
set encoding=utf-8

" File-type highlighting and configuration.
syntax on
filetype on
filetype plugin on
filetype indent on

" Don't show last command down the left bottom
set noshowcmd
" set showcmd

" Ability to copy and paste outside of vim
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Hides buffers instead of closing them
" allow Vim to manage multiple buffers effectively
set hidden

" Enable extended % matching e.g. if/elsif/else/end
runtime macros/matchit.vim

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Wrap lines at convenient points
set linebreak

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" Allow backspace in insert mode
set backspace=indent,eol,start

" Store lots of :cmdline history
set history=500

" Show current mode down the bottom
set showmode

" Disable cursor blink
set gcr=a:blinkon0

" No sounds
set visualbell

" Reload files changed outside vim
set autoread

" Show long lines
set display+=lastline

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" show the textwidth value column
set colorcolumn=+1

" Enable line numbers
set number
set numberwidth=5

" Use one space, not two, after punctuation.
set nojoinspaces

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" sex max col for syntax highlighting
set synmaxcol=300

" syntax sync minlines=10000
set redrawtime=10000

let python_highlight_all=1

" Sets the terminal title
set title

" turn off the scroll bar
set guioptions-=L
set guioptions-=r

" turn off swap files
set noswapfile
set nobackup
set nowb

" disable bell and blinking screen at end of files
set belloff=all

" Set .axlsx as ruby files
autocmd BufNewFile,BufRead *.xlsx.axlsx set syntax=ruby

" Automatically removes all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Fix css syntax highlight for words with hyphen
autocmd FileType scss set iskeyword+=-
autocmd FileType sass set iskeyword+=-

" TODO, explain these lines
set nocp
let g:rehash256 = 1
let t_Co = 512
set timeout timeoutlen=1500
set showbreak=...

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file."
set viminfo+=n~/.vim/viminfo
if exists("+undofile")
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
" Enable folding
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ NERDTree =========================

" Custom icons for expandable/expanded directories
" let g:NERDTreeDirArrowExpandable = '⬏'
" let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['\.swp$', '^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$', '\.pyc$', '\~$']

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files/directories
let g:NERDTreeShowHidden = 1

let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

nnoremap <silent> <Leader>v :NERDTreeFind<CR>

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
nmap wm :NERDTree<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" =========================================================================== "
" ===                               UI                                    === "
" =========================================================================== "

" Enable true color support
set termguicolors

" Editor theme
set background=dark
colorscheme gruvbox

" Add custom highlights in method that is executed every time a colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
function! MyHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Make background transparent for many things
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=NONE guibg=NONE
hi! SignColumn ctermfg=NONE guibg=NONE
hi! StatusLine guifg=#16252b guibg=#6699CC
hi! StatusLineNC guifg=#16252b guibg=#16252b

" Customize NERDTree directory
hi! NERDTreeCWD guifg=#99c794

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" ==================== Splits ====================

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Easy CTRL+W with SHIFT
nnoremap <S-DOWN> <C-W><C-J>
nnoremap <S-UP> <C-W><C-K>
nnoremap <S-RIGHT> <C-W><C-L>
nnoremap <S-LEFT> <C-W><C-H>

" Easy CTRL+W with C-vimkeys
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Resize windows with arrow keys
nnoremap <tab><Up> <C-w>+
nnoremap <tab><Down> <C-w>-
nnoremap <tab><Left> <C-w><
nnoremap <tab><Right> <C-w>>

" =========================================================================== "
" ===                            KEY MAPPINGS                             === "
" =========================================================================== "

"   <leader>h - Find and replace
map <leader>h :%s///<left><left>

"   <Space> - PageDown
"   -       - PageUp
" noremap <Space> <PageDown>
noremap - <PageUp>

map ,Q :lclose<CR>
map ,q :ccl<CR>

" Allow saving of files as sudo when I forget to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Map ,, to open last file
nnoremap <Leader><Leader> <C-^>

" bind K to rip grep word under cursor
nnoremap K :Rg <C-R><C-W><CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Force the use of HJKL as cursor movement
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" set wildmode=list:longest,list:full
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<Tab>"
"     else
"         return "\<C-p>"
"     endif
" endfunction
" inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
" inoremap <S-Tab> <C-n>

" when press { + Enter, the {} block will expand.
imap {<CR> {}<ESC>i<CR><ESC>

"map Q to something useful, like indenting the file
noremap Q gg=G

" Remove all ; from file
map <Leader>; :%s/;//g <CR>
" Remove all { from file
map <Leader>. :%s/{//g <CR>
" Remove all } from file
map <Leader>/ :%s/}//g <CR>

" Copy outside of vim with C-y and paste with C-p
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" bind \ (backward slash) to grep shortcut
nnoremap \ :Rg<SPACE>

" ================ Zoom on Windows  ===============

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-O> :ZoomToggle<CR>

" ================ Quickfix window  ==================

" leader+ENTER opens item in split window
" autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L
" autocmd BufReadPost quickfix nnoremap <buffer> r :copen<CR>

" This is only availale in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'
endfunction

autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>

map [q :cn<CR>
map ]q :cp<CR>
" [Q   :cfirst
" ]Q   :clast

" =========================================================================== "
" ===                            INDENTATION                              === "
" =========================================================================== "

set autoindent
set smartindent
set smarttab
set tabstop=2

" add some line space for easy reading
set linespace=4

" Indentation amount for < and > commands.
set shiftwidth=2

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Insert spaces when TAB is pressed.
set expandtab

" Dart rules
au BufNewFile,BufRead *.dart
   \ set tabstop=2 |
   \ set softtabstop=2 |
   \ set shiftwidth=2 |
   \ set textwidth=119 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

" Python rules
au BufNewFile,BufRead *.py
   \ set tabstop=4 |
   \ set softtabstop=4 |
   \ set shiftwidth=4 |
   \ set textwidth=119 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

" Ruby rules
au BufNewFile,BufRead *.rb,*.erb
   \ set tabstop=2 |
   \ set softtabstop=2 |
   \ set shiftwidth=2 |
   \ set textwidth=119 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

" =========================================================================== "
" ===                            PLUGINS                                  === "
" =========================================================================== "

" ====================== Emmet ======================

let g:user_emmet_leader_key=','

" ====================== FZF ======================

" CTRL+P for FZF
nnoremap <silent> <C-P> :Files<CR>

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Rg! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --sortr path '.<q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ====================== airline ======================

" Airline theme
let g:airline_theme='gruvbox'

" Extensions
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_extensions = ['branch', 'coc']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Hide the Nerdtree status line to avoid clutter
let g:NERDTreeStatusline = ''

" Disable vim-airline in preview mode
let g:airline_exclude_preview = 1

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

" =============== markdown preview ================

let g:mkdp_auto_start = 1

" ====================== coc ======================

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

let g:coc_global_extensions = ['coc-solargraph']

" =================== Deoplete =====================

" deoplete startup
" let g:deoplete#enable_at_startup = 1

" ================ Colorizer ======================

"Disabled because of lag
" let g:colorizer_auto_filetype='css,html'
" let g:colorizer_auto_color = 1
" let g:colorizer_skip_comments = 1
" let g:colorizer_fgcontrast = 2 " 2 is default
" let g:colorizer_colornames = 1
" let g:colorizer_syntax = 1

" ================ Ale =============================

" Disable ale completion in favor of coc
let g:ale_completion_enabled = 0

" start vim with linter column open
let g:ale_sign_column_always = 1

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '-'

" let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0

let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}

let g:ale_fixers = {'javascript': [], 'ruby': ['rubocop']}
" let g:ale_fixers = {'javascript': ['eslint'], 'ruby': ['rubocop']}
let g:ale_fix_on_save = 0
nnoremap gp :silent %!prettier --stdin --trailing-comma all --single-quote<CR>
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'

" disable word highlights
let g:ale_set_highlights = 0
" highlight ALEWarning ctermfg=3
" highlight ALEError ctermbg=DarkMagenta

" ================ UndoTree ==========================

nnoremap <silent> <Leader>g :UndotreeToggle<CR>

" ================ TagBar ============================

nnoremap <silent> <Leader>b :TagbarToggle<CR>

" ================ AutoTag ===========================

nnoremap <leader>ct :silent ! ctags -R --languages=ruby --exclude={.git,log,node_modules,vendor,db} -f .tags<cr>
let g:autotagTagsFile="tags"
set tags+=.tags

" ================ DevIcons ===========================

set guifont=Hack\ Nerd\ Font:h12

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" =========================================================================== "
" ===                            HELPERS                                  === "
" =========================================================================== "

" ================ PrettyXml ======================

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" =========================================================================== "
" ===                            LEGACY                                   === "
" =========================================================================== "

"" ================ Custom Settings from https://github.com/jordanhudgens/vim-settings/blob/master/vim-settings ========================

"" Window pane resizing
"nnoremap <silent> <Leader>[ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
"nnoremap <silent> <Leader>] :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
"nnoremap <silent> <Leader>{ :exe "resize " . (winheight(0) * 3/2)<CR>
"nnoremap <silent> <Leader>} :exe "resize " . (winheight(0) * 2/3)<CR>

"" ===== Seeing Is Believing =====
"" " Assumes you have a Ruby with SiB available in the PATH
"" " If it doesn't work, you may need to `gem install seeing_is_believing -v
"" 3.0.0.beta.6`
"" " ...yeah, current release is a beta, which won't auto-install
""
"" " Annotate every line
""
"" nmap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
""
""  " Annotate marked lines
""
"" nmap <leader>n :%.!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
""
""  " Remove annotations
""
"" nmap <leader>c :%.!seeing_is_believing --clean<CR>;
""
""  " Mark the current line for annotation
""
"nmap <leader>m A # => <Esc>
""
""  " Mark the highlighted lines for annotation
""
"vmap <leader>m :norm A # => <Esc>

"" Plugin call to ctrl p for fuzzy file search
""
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" ================ NOT WORKING =====================
"" Use Alt- numbers to pick the tab you want
"" map <silent> <A-1> :tabn 1<cr>
"" map <silent> <A-2> :tabn 2<cr>
"" map <silent> <A-3> :tabn 3<cr>
"" map <silent> <A-4> :tabn 4<cr>
"" map <silent> <A-5> :tabn 5<cr>
"" map <silent> <A-6> :tabn 6<cr>
"" map <silent> <A-7> :tabn 7<cr>
"" map <silent> <A-8> :tabn 8<cr>
"" map <silent> <A-9> :tabn 9<cr>

"" ================ Fugitive ==========================

"" Enable gitlab private repos for fugitive plugin
"let g:fugitive_gitlab_domains = ['http://gitlab', 'http://gitlab.com']

"" Always use vertical diffs
"set diffopt+=vertical

"" For fugitive.git, dp means :diffput. Define dg to mean :diffget
"nnoremap <silent> ,dg :diffget<CR>
"nnoremap <silent> ,dp :diffput<CR>

"" ================ Rails =============================

"" Better key maps for switching between controller and view
"nnoremap ,vv :Rview<cr>
"nnoremap ,cc :Rcontroller<cr>

"" ================ indentLine =====================

"let g:indentLine_setColors = 1
"let g:indentLine_conceallevel = 0

"" ================= Flutter =======================

"" Enable Flutter menu
"" call FlutterMenu()

"nnoremap <leader>fa :FlutterRun<cr>
"nnoremap <leader>fq :FlutterQuit<cr>
"nnoremap <leader>fr :FlutterHotReload<cr>
"nnoremap <leader>fR :FlutterHotRestart<cr>
"nnoremap <leader>fD :FlutterVisualDebug<cr>

"" ================ Unclassified ===================

"nnoremap <leader>. :CtrlPTag<cr>

""avoiding annoying CSApprox warning message
"let g:CSApprox_verbose_level = 0

""statusline setup
"set statusline=%f       "tail of the filename

""RVM
"set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file
"set laststatus=2
