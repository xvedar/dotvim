" ~/.vimrc (configuration file for vim only)

" create link
" ln -sfn ~/.vim/vimrc ~/.vimrc

" ---- Automatic keyboard layout switching upon entering/leaving insert mode
" ---- using xkb-switch utility
" ----
"  http://lin-techdet.blogspot.com/2012/12/vim-xkb-switch-libcall.html
fun! <SID>xkb_switch(mode)
    let cur_layout = substitute(system('xkb-switch'), '\n', '', 'g')
    if a:mode == 0
        if cur_layout != 'us'
            call system('xkb-switch -s us')
        endif
        let b:xkb_layout = cur_layout
    elseif a:mode == 1
        if exists('b:xkb_layout') && b:xkb_layout != cur_layout
            call system('xkb-switch -s '.b:xkb_layout)
        endif
    endif
endfun

if executable('xkb-switch')
    autocmd InsertEnter * call <SID>xkb_switch(1)
    autocmd InsertLeave * call <SID>xkb_switch(0)
endif

" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	if $USER != ''
	    let login = $USER
	elseif $LOGNAME != ''
	    let login = $LOGNAME
	else
	    let login = 'unknown'
	endif
	let newline = stridx(login, "\n")
	if newline != -1
	    let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
	    let hostname = $HOSTNAME
	else
	    let hostname = system('hostname -f')
	    if v:shell_error
		let hostname = 'localhost'
	    endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
	    let hostname = strpart(hostname, 0, newline)
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()

" pathogen
filetype off
"execute pathogen#infect()
syntax on
filetype plugin indent on

" icf file type
au BufNewFile,BufRead *.icf setfiletype perl6

set vb " use visual bell instead of beeping

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch    " incremental search (while typing)
set shiftwidth=4 " Number of spaces to use for each step of (auto)indent
set tabstop=4    " to tell vim how many columns a tab counts for
"set expandtab   " hitting Tab in insert mode will produce the appropriate number of spaces
set noexpandtab  " opposite to expandtab
set smarttab     " <Tab> in front of a line inserts blanks according to 'shiftwidth'
    
set linebreak "
set textwidth=500 "Maximum width of text that is being inserted

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

" syntax highlighting
syntax on

" hightlight search pattern
set hlsearch

" to use command mode while russian keyboard on
" edit mode only
"set keymap=russian-jcukenwin
"set iminsert=0
"set imsearch=0
"highlight lCursor guifg=NONE guibg=Cyan

if has("gui_running")
	
	" initial vim window size
	set lines=70 columns=108
	
	" pattern match color
	hi MatchParen guifg=#000000 guibg=#D0D090

	" GUI font type
	if has("gui_gtk2")
		set guifont=DroidSansMono\ 11
	elseif has("gui_win32")
		set guifont=Consolas:h11:cANSI
	endif
	
	set linespace=0
	colorscheme torte
	set bg=dark
	
	" remove toolbar
	set guioptions-=T
	" remove menu bar
	set guioptions-=m
    
    " gui cursor: n-v-c mode
    highlight Cursor guifg=black guibg=green
    set guicursor=n-v-c:block-Cursor
    set guicursor+=n-v-c:blinkon0

    " Press F12
    " Select desired coding style with Tab
    set wildmenu
    set wcm=<Tab>
    
    menu Font.DejaVuSansMono10 :set guifont=DejaVuSansMono\ 10<CR>
    menu Font.DejaVuSansMono11 :set guifont=DejaVuSansMono\ 11<CR>
    menu Font.DroidSansMono10  :set guifont=DroidSansMono\ 10<CR>
    menu Font.DroidSansMono11  :set guifont=DroidSansMono\ 11<CR>
    menu Font.Monospace10      :set guifont=Monospace\ 10<CR>
    menu Font.Monospace11      :set guifont=Monospace\ 11<CR>

    map <F12> :emenu Font.<Tab>

else
	"colorscheme darkblue
	"colorscheme bluegreen
	colorscheme koehler
endif

set showmatch

set nu
set ruler

" the fast way to resize the active window 
" using + and - keys
" <C-W> = Ctrl+W
" <S-C-W> = Shift+Ctrl+W
" <A-s> = Alt+s

if bufwinnr(1)
  
  " press '+' key
  map + <C-W>+
  " press '-' key
  map - <C-W>-
  " the same functionality as two lines above
  "map <kPlus> <C-W>+
  "map <kMinus> <C-W>-
  
  " Ctrl+k - move cursor window up
  map <C-K> <C-W>k<C-W>_
  " Ctrl+j - move cursor window dn
  map <C-J> <C-W>j<C-W>_
"  map <kDivide> <c-w><
"  map <kMultiply> <c-w>>
"  map <kDivide> <c-w><
"  map <kMultiply> <c-w>>
endif

"map <Up> <c-w>k<c-w>_<c-w><Bar>
"map <Down> <c-w>j<c-w>_<c-w><Bar>
"map <Left> <c-w>h<c-w>_<c-w><Bar>
"map <Right> <c-w>l<c-w>_<c-w><Bar>

" ~/.vimrc ends here
