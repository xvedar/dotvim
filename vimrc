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

" command -nargs=1 Inshtml :normal i You text1 text2 <args><ESC>
" Inshtml blah

"function Varg2(foo, ...)
"  a:foo, a:0, - arguments
"  echom a:foo " display foo value
"  echom a:0   " display the number of extra arguments you were given
"  echom a:1   " display each extra argument
"  echo a:000  " will be set to a list containing all the extra arguments that were passed
"  let foo_tmp = a:foo " assignment
"endfunction

"func! InsertHeader()
"	r~/dotvim/1.txt
"	normal! i text1 text3
"	command! i <cr>sdfsdf<cr> 
"endf

" normal mode nonrecursive mapping
"nnoremap <F2> :call InsertHeader()<CR>

" pathogen
filetype off
execute pathogen#infect()
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

set scrolloff=3 " number of lines before/after cursor while up/down

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

    noremap <F12> :emenu Font.<Tab>

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
  noremap + <C-W>+
  " press '-' key
  noremap - <C-W>-
  " the same functionality as two lines above
  "noremap <kPlus> <C-W>+
  "noremap <kMinus> <C-W>-
  
  " Ctrl+k - move cursor window up
  noremap <C-K> <C-W>k<C-W>_
  " Ctrl+j - move cursor window dn
  noremap <C-J> <C-W>j<C-W>_
"  noremap <kDivide> <c-w><
"  noremap <kMultiply> <c-w>>
"  noremap <kDivide> <c-w><
"  noremap <kMultiply> <c-w>>
endif

"noremap <Up> <c-w>k<c-w>_<c-w><Bar>
"noremap <Down> <c-w>j<c-w>_<c-w><Bar>
"noremap <Left> <c-w>h<c-w>_<c-w><Bar>
"noremap <Right> <c-w>l<c-w>_<c-w><Bar>

" ~/.vimrc ends here
