set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()

" NOTE: comments after Bundle command are not allowed..
" let Vundle manage Vundle
" required! 
Plugin 'VundleVim/Vundle.vim'

" Github repos
"Plugin 'altercation/vim-colors-solarized'
Plugin 'jsenin/molokai'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-markdown'
"Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-bufferline'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
"Plugin 'digitaltoad/vim-jade'
Plugin 'chase/vim-ansible-yaml'
Plugin 'moll/vim-node'
"Plugin 'cakebaker/scss-syntax.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'tao12345666333/vim-vue'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'

" vim-scripts repos
Plugin 'AutoClose'

call vundle#end()            " required
filetype plugin indent on    " required

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_auto_jump = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']

" Solarized settings
"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colo solarized 
" Molokai settings
let g:molokai_original = 1
let g:rehash256 = 1
colo molokai

let g:ansible_options = {'ignore_blank_lines': 0}
let g:user_emmet_leader_key='<C-Z>'

set encoding=utf-8
set cpoptions+=$
set gcr=a:blinkon0
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set nowrap

" Temp text wrapping
"set textwidth=79
"set formatoptions+=t

set hlsearch
set incsearch
set ignorecase
set number
set guioptions-=T
syntax on

set hidden		" allow buffers with unsaved changes
set mouse=a		" enable mouse scrolling and clicking in iTerm
set wildmenu	" expand vim commands like :tabe
set wildmode=full
set scrolloff=4	" keep 4 lines off the edges of the screen when scrolling
set nobackup	" no backup file clutter
set noswapfile	" never used it
set nomodeline	" ignore vim modelines
"set laststatus=2 " always show statusline

" fix workman binding
noremap l o
noremap o l
noremap L O
noremap O L
noremap j n
noremap n j
noremap J N
noremap N J
noremap k e
noremap e k
noremap K E
noremap E <nop>
noremap h y
noremap y h
noremap H Y
noremap Y H

" remap surround plugin	
let g:surround_no_mappings = 1
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap hs  <Plug>Ysurround
nmap hS  <Plug>YSurround
nmap hss <Plug>Yssurround
nmap hSs <Plug>YSsurround
nmap hSS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround


" remap buffer switching
map <C-o> :bn<CR>
map <C-y> :bp<CR>
" clear search results
vnoremap // y/<C-R>"<CR>"

" Use space as ex command unit (:)
map <Space> :

let mapleader=","
" map <leader>/ to turn off search highlight
nnoremap <Leader>/ :noh<CR>
" Make it easy to edit files from same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" set snippet dir
let g:snippets_dir = '~/code/dotfiles/vimsnippets/'

" Bufferline is also printing to statusline, do not want :F
let g:bufferline_echo = 0
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_theme='badwolf' let g:airline_powerline_fonts=1

" tagbar autofocus and autoclose
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_iconchars = ['▾', '▸']

let g:ctrlp_tabpage_position = 'ac'

" Ignore compiled python
set wildignore+=*.pyc
" dont look at .hg dirs to decide where current working dir is, messes up with
" subrepos
let g:ctrlp_working_path_mode = '0'

" Ignore certain files
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|\.git\|\.hg\|\.svn\|dist'

" let easytags look for tags file in project
set tags=./.tags;
let g:easytags_dynamic_files = 1
" disable auto update because it seems to make vim lag
" (use :UpdateTags -R ./*)
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0

" include local vim conf
let s:extrarc = expand($HOME . '/.vimrc.local')
if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
endif

autocmd BufLeave,FocusLost * silent! wall

" hg diff stuff
function! Hgdiff()             
	vnew                       
	silent r !hg diff          
	0                          
	set filetype=diff          
	setlocal buftype=nofile    
	setlocal noswapfile        
	wincmd w                   
endfunction                    
command! Hgdiff call Hgdiff() 
