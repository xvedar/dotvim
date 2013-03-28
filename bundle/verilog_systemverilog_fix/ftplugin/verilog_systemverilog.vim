" Vim filetype plugin file
" Language:	SystemVerilog (superset extension of Verilog)
" Maintainer:	Amit Sethi <amitrajsethi@yahoo.com>
" Last Change:	Tue Jun 26 08:56:34 IST 2006
" Version: 1.0

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" xvedar
"
"
" Insert SystemVerilog header at the begining of the file
func! InsertSvHeader()
	" 2nd line is copied into 'x' variable
	" let x=getline(2)
	silent! execute "2g/^/let x=getline('.')"
	
	if x=~#'Block'
		echom "!WOOH!"
	else
		" Insert the header at the begining of the file
		0r ~/dotvim/bundle/verilog_systemverilog_fix/svheader.txt
		" regex to change
		" in the next line containing pattern substitute the pattern with current date
		silent! execute '/!!!DATE!!!/s//' .strftime("%Y %b %d")
	endif
endf

":2g/^/let x=getline('.') | if x=~#'Block' | echo"WOOH!" | else | echo"BBB" | endif      
" examples regex:
" :g/^baz/s/foo/bar/g 	Change each 'foo' to 'bar' in each line starting with 'baz'. 
" :/test/,/guest/s/foo/bar/g - specify ranges (b/w words)
"silent! execute '1,10g/Last Modified/s/Last Modified\s*:.*/Last Modified : ' .strftime("%c")
" to change the date (in the line range from 1 to 10)
"silent! execute "1," . 10 . 'g/Last Modified/s/Last Modified\s*:.*/Last Modified : ' .strftime("%c")
"silent! execute '1,10s/Last Modified\s*:.*/Last Modified : ' .strftime("%c")
" to change the file name (in the line range from 1 to 10)
"silent! execute "1," . 10 . 'g/File Name\s*:.*/s//File Name : ' .expand("%")

let maplocalleader = "\\" " specify prefix 'localleader' key

" F2 to insert header
" normal mode no remap
"nnoremap <f2> :0r ~/dotvim/bundle/verilog_systemverilog_fix/svheader.txt<cr>:1,10s/!!!DATE!!!/\=strftime("%Y %b %d")<cr><esc>
nnoremap <localleader>h :call InsertSvHeader()<cr>

" Redate file header automatically
function! ReDateHeader()
	" to remember current cursor position
	" ma: set mark 'a' for the current position
	" H : go to the 1st on-screen line
	" ml: set mark 'l' for this position
	silent! normal! maHml
	
	" go to the 1st line
	silent! normal! gg
	
	" in the next line containing pattern
	" substitute the pattern with the current date and time
	silent! execute '/File Name/s/\(File Name\s*:\).*/\1 ' .expand("%")
	
	" in the next line containing pattern
	" substitute the pattern with the current date and time
	silent! execute '/Last Modified/s/\(Last Modified\s*:\).*/\1 ' .strftime("%c")
	
	" go to the last cursor position
	" `l: jump to mark 'l'
	" zt: set this line the 1st on-screen
	" `a: jump to mark 'a'
	silent! normal! `lzt`a
endf

" Redate when save the file
autocmd BufWritePre,filewritepre *.v,*.vh,*.sv,*.svi,*.svh call ReDateHeader()

" Behaves just like Verilog
runtime! ftplugin/verilog.vim
