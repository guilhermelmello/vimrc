"" .vimrc file by Guilherme L. Mello
"" based on https://github.com/mbrochh/vim-as-a-python-ide/blob/master/.vimrc

"==============================================================================
"   VIm Instalation
"==============================================================================

" Prerequisites:
" (FEDORA) sudo dnf builddep vim

" $ git clone https://github.com/vim/vim
" $ cd vim
" $ ./configure --with-features=big --enable-pythoninterp --with-python-config-dir=/usr/lib64/python2.7/config
" $ make && make install

" obs.:
" --with-python-config-dir must point to 'config.c' dir, where python is
"  installed



"==============================================================================
"   VIm Configuration
"==============================================================================

"" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


"" Setup Pathogen to manage your plugins
"" mkdir -p ~/.vim/autoload ~/.vim/bundle
"" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
"" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
""call pathogen#infect()
execute pathogen#infect()
""call pathogen#helptags()


"" Better copy & paste
"" When you want to paste large blocks of code into vim, press F2 before you
"" paste. At the bottom you should see ``-- INSERT (paste) --``.
"set pastetoggle=<F2>
"set clipboard=unnamed
"set number


"" Mouse and backspace
"set mouse=a  " on OSX press ALT and click
"set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap  <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
"vnoremap <leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


"" Color Scheme (Solarized)
"" mkdir -p ~/.vim/bundle && cd ~/.vim/bundle
"" git clone git://github.com/altercation/vim-colors-solarized.git
syntax enable
set background=dark
colorscheme solarized


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Show whitespace
" MUST be inserted AFTER the colorscheme command
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


"" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233


"" easier formatting of paragraphs
" vmap Q gq
" nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


"" Disable stupid backup and swap files - they trigger too many events
"" for file system watchers
" set nobackup
" set nowritebackup
" set noswapfile


"==============================================================================
" Python IDE Setup
"==============================================================================

"" Settings for vim-powerline
"" Tenho que verificar qual é a melhor opção para instalar.
"" Dá para instalar por:
""      dnf install vim-plugin-powerline
""      pip install powerline-status
"" cd ~/.vim/bundle
"" pip install powerline-status
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)


"" Settings for ctrlp
"" cd ~/.vim/bundle
"" git clone https://github.com/kien/ctrlp.vim.git
"let g:ctrlp_max_height = 30
"set wildignore+=*.pyc
"set wildignore+=*_build/*
"set wildignore+=*/coverage/*


"" Settings for jedi-vim
"" sudo yum install vim-jedi.noarch
"" cd ~/.vim/bundle
"" git clone git://github.com/davidhalter/jedi-vim.git
"let g:jedi#usages_command = "<leader>z"
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
"map <leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


"" Better navigating through omnicomplete option list
"" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

"" Change the popup color
highlight Pmenu      ctermbg=233 ctermfg=blue gui=bold
highlight PmenuSel   ctermfg=0   ctermbg=7
highlight PmenuSbar  ctermfg=7   ctermbg=0
highlight PmenuThumb ctermfg=0   ctermbg=7


"" Python folding
"" mkdir -p ~/.vim/ftplugin
"" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
"set nofoldenable
