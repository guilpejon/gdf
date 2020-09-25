" =========================================================================== "
" ===                              PLUGINS                                === "
" =========================================================================== "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.vim/plugged')

" underline word under cursor
Plug 'itchyny/vim-cursorword'

" Buffer explorer (be/bt/bs/bv)
Plug 'jlanzarotta/bufexplorer'

" Horizontal lines to show identation
Plug 'Yggdroot/indentLine'

" Change surroundings (cs/ds)
Plug 'tpope/vim-surround'

" Better repeat command (.)
Plug 'tpope/vim-repeat'

" Discover and update ctags file on save
Plug 'craigemery/vim-autotag'

" Coffeescript syntax, indenting and compiling
Plug 'kchmck/vim-coffee-script'

" Insert or delete brackets, parentesis and quotes in pair
Plug 'jiangmiao/auto-pairs'

" Fast fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Create comments (gc/gcc)
Plug 'tpope/vim-commentary'

" Asynchronous build and test dispatcher (:Dispatch rspec %)
Plug 'tpope/vim-dispatch'

" Visualize undo tree
Plug 'mbbill/undotree'

" Visualize tags
Plug 'majutsushi/tagbar'

" Bundle goodies for VIM
Plug 'tpope/vim-bundler'

" Add end at the end of if/do/...
Plug 'tpope/vim-endwise'

" Git commands shortcuts (:Gstatus, :Gdiff, :Gblame)
Plug 'tpope/vim-fugitive'

" Asynchronous completion framework
Plug 'Shougo/deoplete.nvim'
" Required plugins for deoplete
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'

" Colorize text like #fff
Plug 'chrisbra/Colorizer'

" Better syntax highlighting for js files
Plug 'jelera/vim-javascript-syntax'

" Better syntax highlighting for scss files
Plug 'cakebaker/scss-syntax.vim'

" Check syntax in Vim asynchronously and fix files
Plug 'w0rp/ale'

" Navigation sidebar
Plug 'scrooloose/nerdtree'

" Git plugin for Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Completion framework and language server client
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " Language Server support

" Open markdown preview on web when editing a .md file
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Colorscheme
Plug 'guilpejon/gruvbox'

" Status bar at the bottom of the window
Plug 'vim-airline/vim-airline'

" For Facts, Ruby functions, and custom providers
Plug 'vim-ruby/vim-ruby'

" Enable file icons on nerdtree, airline, and others
Plug 'ryanoasis/vim-devicons'

" Easy HTML edit with macros
Plug 'mattn/emmet-vim'

" Auto close HTML tags
Plug 'alvan/vim-closetag'

" Easy navigation on rails files
" Plug 'tpope/vim-rails'

" " Syntax and style checker for Python
" Plug 'nvie/vim-flake8'

call plug#end()
