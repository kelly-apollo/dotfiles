"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> General settings               
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set nocompatible
au!

set shell=/bin/bash

" Environment variable

set undodir=~/.undodir
set undofile

" Vundle initialization
set rtp+=~/Dropbox/Vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'kelly-apollo/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'xolox/vim-misc'
Plugin 'honza/vim-snippets'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'danro/rename.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/CmdlineComplete'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'mattn/emmet-vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 't9md/vim-choosewin'
Plugin 'godlygeek/tabular'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'Vimjas/vim-python-pep8-indent'


call vundle#end() 
" Vundle end

filetype plugin indent on  

set noswapfile
set nobackup
set nowritebackup

set autoindent
set ignorecase
set smartcase

set complete+=k
set formatoptions+=mM "chinese typeset format, feats 'textwidth'

let mapleader = " " "space
nnoremap <space> <nop>
map <space><space> <space>c<space>
map <space><space> <space>c<space>

ru util.vim

set history=300

command Vimrc e ~/.vimrc

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Filetype
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
au FileType htmldjango set ft=html.htmldjango
au FileType html set ft=html.htmldjango
au FileType html\|css\|htmldjango  setlocal isk+=-

set foldnestmax=1


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Files and Buffers Editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

au CursorHold * checktime

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

au BufNewFile * set ff=unix
map <c-tab> gt
map <c-s-tab> gT
	
map ,s :up<cr>
map ,q :close!<cr><C-W>p
vmap ,r <Esc>:s/<c-r>=GetVisual()<cr>//g<left><left>

au FileType dosbatch map <buffer> ,g :w<bar>silent! !%<cr>
map ,o :silent! !start explorer "%:p:h"<cr>

nmap ,yg :let tmp=line('.')<cr>gg"*yG:exec('norm '.tmp.'G')<cr>
nmap ,yy "*yy
nmap ,yw :call setreg('*', expand('<cword>'))<cr>
nmap ,yr :call setreg('*', expand('%'))<cr>
nmap ,yp :call setreg('*', expand('%:p'))<cr>
vmap ,y "*y
map ,p "*p
map ,l :e! %<cr>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Moving around
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" when using mouse click edge content, screen jumps
set scrolloff=4

set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set nowrap

inoremap <c-s> <esc><s-s>
inoremap <c-_> <esc>T_cw
inoremap <c-o> <space><cr><up><esc>A<backspace>
inoremap <c-j> <esc>o
inoremap <c-f> <esc>jo

map ,a :vert :h <c-r><c-w><cr>
imap <c-z> <c-c>zza

map <space>mm :NERDTreeClose<cr>:winc \|<cr>
map <space>mn :winc _<cr>
map <space>mb :winc =<cr>

noremap [[ :call search('\n\n\n', 'b')<cr>
vnoremap [[ :<c-u>exe "normal! gv"\|call search('\n\n\n', 'b')<cr>
noremap ]] :call search('\n\n\n')<cr>
vnoremap ]] :<c-u>exe "normal! gv"\|call search('\n\n\n')<cr>

function! <SID>LocationPrevious()                       
  try                                                   
    lprev                                               
  catch /^Vim\%((\a\+)\)\=:E553/                        
    llast                                               
  endtry                                                
endfunction                                             

function! <SID>LocationNext()                           
  try                                                   
    lnext                                               
  catch /^Vim\%((\a\+)\)\=:E553/                        
    lfirst                                              
  endtry                                                
endfunction                                             

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> ,, <Plug>LocationPrevious
nmap <silent> .. <Plug>LocationNext

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Vim Interface
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set nobomb
set ruler
set showcmd
set number
set showtabline=1
" mac ox GUI tabpage is nice
set guifont=menlo:h13
set guioptions=
set splitright

set shiftwidth=4
set tabstop=4
set softtabstop=4
au FileType yaml\|html\|javascript\|css\|markdown set shiftwidth=2|set tabstop=2|set softtabstop=2
au FileType go set noexpandtab tabstop=4 shiftwidth=4
au FileType html\|css\|scss set iskeyword+=\-
set expandtab


fun! My_ruler()
    let bom_label = 'bom'

    if &bomb == 0
        let bom_label = 'nobom'
    endif

    let seporator = ' | '
    let my_ruler_str = ''
    let items = [&fileencoding, &fileformat, bom_label]

    for item in items
        let my_ruler_str = my_ruler_str . item . seporator
    endfor

    return my_ruler_str
endf

set laststatus=2
set statusline=%m\ %F%=%{substitute(fugitive#statusline(),'.*(\\(.\\+\\)).\\+','\ git:(\\1)','g')}\ \|\ %{My_ruler()}%{strftime('%H:%M')}\ [%P]
set ruf=%30(%=%{My_ruler()}%P%)

map ,h :set hls!<cr>
map ,d :let @/ = '\<'.expand('<cword>').'\>'\|set hls<cr>
vmap ,s "9y:let @/ = '\V'.@9\|set hls<cr>

fun! OverLengthType()
    if &ft !~ 'html\|qf'
        highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        match OverLength /\%120v.\+/
    else
        match none
    endif
endf

au FileType * call OverLengthType()

syntax on
"render the whole file to avoid syntax mess
autocmd BufEnter * :syntax sync fromstart

colorscheme default
hi CursorLine   cterm=NONE ctermbg=254 ctermfg=NONE
hi Search cterm=NONE ctermfg=white ctermbg=yellow

" set tabline=%!MyTabLine()
fun! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		let s .= '%' . (i + 1) .  'T'
		let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	endfor
	let s .= '%#TabLineFill#%T'
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999XX '
	endif
	return s
endf

fun! MyTabLabel(n)
	let padding = '  '
	let indicator = ''
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let labelName = matchstr(bufname(buflist[winnr - 1]), '\v([^\\]+)@>$')
	if match(labelName, '^\s*$') != -1
		let labelName = 'Untitled'
	endif
	let labelCount = tabpagewinnr(a:n, '$')
	if labelCount > 1 | let indicator = labelCount | endif
	for i in buflist
		if getbufvar(i, '&modified')
			let indicator = '+' . indicator
			break
		endif
	endfor
	if indicator != ''| let indicator .= ' ' | endif
	let labelName = padding . indicator . labelName . padding
	return labelName
endf


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Encoding
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set encoding=utf-8
set fileencodings=utf-8,cp936,ucs-bom,utf-8,gb18030,big5,euc-jp,euc-kr,latin1
let $LANG = 'en_US'

source $VIMRUNTIME/delmenu.vim
set langmenu=en_us
source $VIMRUNTIME/menu.vim


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Complie and Debug
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" location list
map ,cw :lw<cr>

fun! Compile()
	exec 'silent w'
	exec 'silent make'
	if !v:shell_error
		echo 'Compile successful!'
		exec 'bo :cw 10'
		return 0
	endif
	echo 'Error occur!'
	exec 'cw'
	return 1
endf

fun! CompileRun(compileError)
	if !a:compileError
		exec '!setlocal enabledelayedexpansion&&cd %:h&&cls&&java %:t:r'
		exec 'redraw'
	endif
endf

map <silent> <F9> :call Compile()<cr>
map <silent> <F10> :call CompileRun(Compile())<cr>

au FileType java set makeprg=jikes\ -nowarn\ -Xstdout\ +E\ %
au FileType javascript setl makeprg=gjslint\ %
au FileType javascript setl errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyle%s,%-Gscript\ can\ %s,%-G
au FileType python setl makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
au FileType python setl errorformat=%f:%l:\ %m
au FileType c set makeprg=gcc\ -o\ %<\ %  


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> commandline
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cmap <c-l> <plug>CmdlineCompleteForward
cmap <c-y> <plug>CmdlineCompleteBackward
nmap ,x :@:<cr>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> NERDTree
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let NERDTreeShowBookmarks = 1
let NERDTreeIgnore=['\.pyc$']
let NERDSpaceDelims=1
map ,a :NERDTreeToggle<cr>:winc =<cr>
map ,f :NERDTreeFind<cr>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Tagbar
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:tagbar_autofocus = 1
map <space>lc :silent !ctags %<cr>
map <space>ll :silent TagbarToggle<cr>
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
\ }


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Syntastic
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_html_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ignore_files = ['plugin', '.json$']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["java"] }

" fixed gui vim error prompter other than `bash`
let g:syntastic_bash_hack = 0

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Easymotion
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:EasyMotion_do_mapping=0
let g:EasyMotion_keys='jklhyuiopnm,qwertzxcvbasdgf;'
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" fixed paste(command+v) problem in EMcommandline
" https://github.com/easymotion/vim-easymotion/issues/253
autocmd VimEnter * EMCommandLineNoreMap \"\+gP <c-r>+

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> UndoTree
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

map ,u :UndotreeToggle<cr>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> gitgutter
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:gitgutter_max_signs = 1000

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> Ack.vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

noremap  <space>/ :AckW!<space>
noremap  <space>; :Ack!<space> <c-r><c-w><cr>

let g:ack_mappings = {
      \ "t": "<C-W><CR><C-W>T",
      \ "T": "<C-W><CR><C-W>TgT<C-W>j",
      \ "o": "<CR>",
      \ "O": "<CR>:cclose<CR>",
      \ "go": "<CR><C-W>p",
      \ "h": "<C-W><CR><C-W>K",
      \ "H": "<C-W><CR><C-W>K<C-W>b",
      \ "v": "<C-W><CR><C-W>L<C-W>b<C-W>J<C-W>p",
      \ "V": "<C-W><CR><C-W>L<C-W>p<C-W>c<C-W>p",
      \ "gv": "<C-W><CR><C-W>L<C-W>b<C-W>J" }

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> CtrlP
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nnoremap <Leader>fu :CtrlPFunky<cr>
nnoremap <c-n> :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = {
  \ 'dir':  'venv\|node_modules\|release\|DS_Store\|.git',
  \ 'file': '\v\.(exe|so|dll|pyc)$'
  \ }
let g:ctrlp_working_path_mode = 'rw'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> delimitMate
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:delimitMate_expand_cr = 1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> vim-table-mode
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Markdown-compatible
let g:table_mode_corner="|"
nnoremap <Leader>tm :TableModeToggle<cr>
nnoremap <Leader>ta :TableModeRealign<cr>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> vim-markdown-toc
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:vmt_dont_insert_fence = 1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> vim-choosewin
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nmap  -  <Plug>(choosewin)

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~> git-fugitive
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nnoremap ,ga :silent Git add -A<CR><CR>
nnoremap ,gq :silent Git add -A<CR><CR>:Gcommit -v<CR>
nnoremap ,gs mB:Gstatus<CR>
nnoremap ,gc :Gcommit -v -q<CR>
nnoremap ,gt :Gcommit -v -q %:p<CR>
nnoremap ,gd :Git! diff<CR>
nnoremap ,ge :Gedit<CR>
nnoremap ,gr :Gread<CR>
nnoremap ,gw :Gwrite<CR><CR>
nnoremap ,gb :Git branch<Space>
nnoremap ,gco :Git checkout<Space>
nnoremap ,gp :!git push<CR>
nnoremap ,gl :!git pull<CR>

au FileType git nnoremap <buffer> C `B:\|pclose\|silent Git add -A\|Gcommit -v<cr>
au FileType git nnoremap <buffer> B `B:\|pclose<cr>

" close tab page and focus left 
let s:prevtabnum=tabpagenr('$')
augroup TabClosed
    autocmd! TabEnter * :if tabpagenr('$')<s:prevtabnum && tabpagenr()>1
                \       |   tabprevious
                \       |endif
                \       |let s:prevtabnum=tabpagenr('$')
augroup END
