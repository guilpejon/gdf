"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

"load pathogen managed plugins
call pathogen#infect()
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" " exist in the background without being in a window.
" " http://items.sjbach.com/319/configuring-vim-right
"set hidden

" Change leader to a comma because the backslash is too far away
" " That means all \x commands turn into ,x
" " The mapleader has to be set before vundle starts loading all
" " the plugins.
let mapleader=","
set timeout timeoutlen=1500

" Show long lines
set display+=lastline

" more natural split opening
set splitbelow
set splitright

" ==================== Vim Wiki  =================
" Run multiple wikis "
let g:vimwiki_list = [
                        \{'path': '~/Documents/VimWiki/personal.wiki'},
                        \{'path': '~/Documents/VimWiki/tech.wiki'}
                \]
au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map d :VimwikiMakeDiaryNote
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map c :call ToggleCalendar()

" ================ Zoom on Windows  ================

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

" ================ The Silver Searcher  =============

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

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

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

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

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

au BufNewFile,BufRead *.py
   \ set tabstop=4 |
   \ set softtabstop=4 |
   \ set shiftwidth=4 |
   \ set textwidth=79 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

au BufNewFile,BufRead *.rb,*.erb
   \ set tabstop=2 |
   \ set softtabstop=2 |
   \ set shiftwidth=2 |
   \ set textwidth=79 |
   \ set expandtab |
   \ set autoindent |
   \ set fileformat=unix

"load ftplugins and indent files
filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
" set list listchars=tab:\ \ ,trail:·

set showbreak=...
" set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

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

" =============== Set .axlsx as ruby files ================

autocmd BufNewFile,BufRead *.xlsx.axlsx set syntax=ruby

" ===== Automatically removes all trailing whitespace =====

autocmd BufWritePre * %s/\s\+$//e

" ================ Custom Settings ========================

set nocp
set encoding=utf-8
set background=dark
let g:rehash256 = 1
let t_Co = 512
let g:molokai_original = 1
colorscheme molokai

" sex max col for syntax highlighting
set synmaxcol=300
" syntax sync minlines=10000
set redrawtime=10000
let python_highlight_all=1
"turn on syntax highlighting
syntax on

"add some line space for easy reading
set linespace=4

set title

" Ability to copy and paste outside of vim
" set clipboard=unnamed
" set clipboard=unnamedplus
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

"turn off the scroll bar
set guioptions-=L
set guioptions-=r

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Don't  know what these do
nnoremap <Esc>A <up>
nnoremap <Esc>B <down>
nnoremap <Esc>C <right>
nnoremap <Esc>D <left>
inoremap <Esc>A <up>
inoremap <Esc>B <down>
inoremap <Esc>C <right>
inoremap <Esc>D <left>

" ================ Custom Settings from https://github.com/jordanhudgens/vim-settings/blob/master/vim-settings ========================

" Window pane resizing
nnoremap <silent> <Leader>[ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>] :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <Leader>{ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>} :exe "resize " . (winheight(0) * 2/3)<CR>

" ===== Seeing Is Believing =====
" " Assumes you have a Ruby with SiB available in the PATH
" " If it doesn't work, you may need to `gem install seeing_is_believing -v
" 3.0.0.beta.6`
" " ...yeah, current release is a beta, which won't auto-install
"
" " Annotate every line
"
" nmap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
"
"  " Annotate marked lines
"
" nmap <leader>n :%.!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
"
"  " Remove annotations
"
" nmap <leader>c :%.!seeing_is_believing --clean<CR>;
"
"  " Mark the current line for annotation
"
nmap <leader>m A # => <Esc>
"
"  " Mark the highlighted lines for annotation
"
vmap <leader>m :norm A # => <Esc>

" Plugin call to ctrl p for fuzzy file search
"

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ================ Custom Helpers  ========================

" make ^ work
" nmap <S-6> ˆ

" when press { + Enter, the {} block will expand.
imap {<CR> {}<ESC>i<CR><ESC>

"map Q to something useful
noremap Q gg=G

" Resize windows with arrow keys
nnoremap <tab><Up> <C-w>+
nnoremap <tab><Down> <C-w>-
nnoremap <tab><Left> <C-w><
nnoremap <tab><Right> <C-w>>

" Remove all ; from file
map <Leader>; :%s/;//g <CR>
map <Leader>. :%s/{//g <CR>
map <Leader>/ :%s/}//g <CR>

" Easy CTRL+W with SHIFT
nnoremap <S-DOWN> <C-W><C-J>
nnoremap <S-UP> <C-W><C-K>
nnoremap <S-RIGHT> <C-W><C-L>
nnoremap <S-LEFT> <C-W><C-H>

" Copy outside of vim with C-y and paste with C-p
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" ================ NOT WORKING =====================
" Use Alt- numbers to pick the tab you want
" map <silent> <A-1> :tabn 1<cr>
" map <silent> <A-2> :tabn 2<cr>
" map <silent> <A-3> :tabn 3<cr>
" map <silent> <A-4> :tabn 4<cr>
" map <silent> <A-5> :tabn 5<cr>
" map <silent> <A-6> :tabn 6<cr>
" map <silent> <A-7> :tabn 7<cr>
" map <silent> <A-8> :tabn 8<cr>
" map <silent> <A-9> :tabn 9<cr>

" ===================================================
" ================ PLUGINS ==========================
" ===================================================

" ================ NERDTreeTabs =====================

" Auto open nerd tree on startup
" let g:nerdtree_tabs_open_on_gui_startup = 0

" Focus in the main content window
" let g:nerdtree_tabs_focus_on_files = 1

" map <Leader>n <plug>NERDTreeTabsToggle<CR>

" ================ NERDTree =========================

let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

nnoremap <silent> <Leader>v :NERDTreeFind<CR>

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
nmap wm :NERDTree<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.swp$']

" ================ Fugitive ==========================

" Enable gitlab private repos for fugitive plugin
let g:fugitive_gitlab_domains = ['http://gitlab', 'http://gitlab.com']

" Open split vertically
set diffopt+=vertical

" For fugitive.git, dp means :diffput. Define dg to mean :diffget
nnoremap <silent> ,dg :diffget<CR>
nnoremap <silent> ,dp :diffput<CR>

" ================ Rails =============================

" Better key maps for switching between controller and view
nnoremap ,vv :Rview<cr>
nnoremap ,cc :Rcontroller<cr>

" ================ Ale =============================

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '-'

" let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0

" Prettier
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['ruby'] = ['rubocop']
" let g:ale_fix_on_save = 1
nnoremap gp :silent %!prettier --stdin --trailing-comma all --single-quote<CR>
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'

" disable word highlights
let g:ale_set_highlights = 0
" highlight ALEWarning ctermfg=3
" highlight ALEError ctermbg=DarkMagenta

"================ Syntastic =========================

" highlight SyntasticWarning NONE
" highlight SyntasticError NONE

" "mark syntax errors with :signs
" let g:syntastic_enable_signs=1
" "automatically jump to the error when saving the file
" let g:syntastic_auto_jump=0
" "dont show the error list automatically
" let g:syntastic_auto_loc_list=0
" "don't care about warnings
" " let g:syntastic_quiet_messages = {'level': 'warnings'}
" let g:syntastic_loc_list_height=2

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1

" " I have no idea why this is not working, as it used to
" " be a part of syntastic code but was apparently removed
" " This will make syntastic find the correct ruby specified by mri
" function! s:FindRubyExec()
"   if executable("rvm")
"     return system("rvm tools identifier")
"   endif
"   return "ruby"
" endfunction

" let g:syntastic_ruby_checkers = ['rubocop']

" if !exists("g:syntastic_ruby_exec")
"   let g:syntastic_ruby_exec = s:FindRubyExec()
" endif

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" Fix css syntax highlight for words with hyphen
autocmd FileType scss set iskeyword+=-
autocmd FileType sass set iskeyword+=-

" ================ UtilSnips =====================

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ================ indentLine =====================

let g:indentLine_setColors = 1
let g:indentLine_conceallevel = 0

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

" ================ Unclassified ===================

map ,Q :lclose<CR>
map ,q :ccl<CR>

" Airline (pretty tabs)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"avoiding annoying CSApprox warning message
let g:CSApprox_verbose_level = 0

"statusline setup
set statusline=%f       "tail of the filename

"RVM
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"map to bufexplorer
"nnoremap <leader>b :BufExplorer<cr>

"key mapping for Gundo
nnoremap <F4> :GundoToggle<CR>

"tagbar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" autotag configuration
let g:autotagTagsFile="tags"
