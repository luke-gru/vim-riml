" Vim syntax file
" Language:       Riml
" Maintainer:     Luke Gruber
" Last Change:    Jan. 18, 2014
" Version:        0.0.1

" Quit when a syntax file was already loaded
"if exists("b:current_syntax") && b:current_syntax == "riml"
  "finish
"endif

" Include vim.vim for rimlExLiteral
syn include @rimlVimEmbed syntax/vim.vim

syn keyword rimlKeyword if else elseif while for in return is isnot finish break continue
syn keyword rimlKeyword throw try catch finally
syn keyword rimlKeyword endfunction endif endwhile endfor endtry end
syn keyword rimlKeyword super unless until new
syn match   rimlKeyword "^\s*\<\(function\|def[m]\?\)!\?\>"
syn match   rimlKeyword "\<call\>"
syn keyword rimlBool true false

" functions keywords
syn keyword rimlBuiltinFunction abs acos add append argc argidx argv argv asin atan atan2 browse browsedir bufexists buflisted bufloaded bufname bufnr bufwinnr
syn keyword rimlBuiltinFunction byte2line byteidx ceil changenr char2nr cindent clearmatches col complete complete_add complete_check confirm copy cos cosh
syn keyword rimlBuiltinFunction count cscope_connection cursor cursor deepcopy delete did_filetype diff_filler diff_hlID empty escape eval eventhandler executable
syn keyword rimlBuiltinFunction exists extend exp expand feedkeys filereadable filewritable filter finddir findfile float2nr floor fmod fnameescape fnamemodify
syn keyword rimlBuiltinFunction foldclosed foldclosedend foldlevel foldtext foldtextresult foreground garbagecollect get get getbufline getbufvar getchar
syn keyword rimlBuiltinFunction getcharmod getcmdline getcmdpos getcmdtype getcwd getfperm getfsize getfontname getftime getftype getline getline getloclist getmatches
syn keyword rimlBuiltinFunction getpid getpos getqflist getreg getregtype gettabvar gettabwinvar getwinposx getwinposy getwinvar glob globpath has has_key haslocaldir
syn keyword rimlBuiltinFunction hasmapto histadd histdel histget histnr hlexists hlID hostname iconv indent index input inputdialog inputlist inputrestore inputsave
syn keyword rimlBuiltinFunction inputsecret insert isdirectory islocked items join keys len libcall libcallnr line line2byte lispindent localtime log log10 map maparg
syn keyword rimlBuiltinFunction mapcheck match matchadd matcharg matchdelete matchend matchlist matchstr max min mkdir mode mzeval nextnonblank nr2char pathshorten pow
syn keyword rimlBuiltinFunction prevnonblank printf pumvisible range readfile reltime reltimestr remote_expr remote_foreground remote_peek remote_read remote_send remove
syn keyword rimlBuiltinFunction remove rename repeat resolve reverse round search searchdecl searchpair searchpairpos searchpos server2client serverlist setbufvar setcmdpos
syn keyword rimlBuiltinFunction setline setloclist setmatches setpos setqflist setreg settabvar settabwinvar setwinvar shellescape simplify sin sinh sort soundfold
syn keyword rimlBuiltinFunction spellbadword spellsuggest split sqrt str2float str2nr strchars strdisplaywidth strftime stridx string strlen strpart strridx strtrans strwidth
syn keyword rimlBuiltinFunction submatch substitute synID synIDattr synIDtrans synstack system tabpagebuflist tabpagenr tabpagewinnr taglist tagfiles tempname tan tanh
syn keyword rimlBuiltinFunction tolower toupper tr trunc type undofile undotree values virtcol visualmode winbufnr wincol winheight winline winnr winrestcmd winrestview winsaveview
syn keyword rimlBuiltinFunction winwidth writefile
" negative lookahead (zero-width) for '(' after 'function|call'
syn match   rimlBuiltinFunction "\<\(function\|call\)(\@="

syn keyword rimlBuiltinCommand echo echon echomsg echoerr echohl execute exec sleep

syn match rimlNumber "\<\d\+\([lL]\|\.\d\+\)\="
syn match rimlNumber "-\d\+\([lL]\|\.\d\+\)\="
syn match rimlNumber "\<0[xX]\x\+"
syn match rimlNumber "#\x\{6}"

syn match rimlVar "\<[bwglsavn]:\K\k*\>"
syn match rimlVar contained "\<\K\k*\>"
syn match rimlFuncVar contained "a:\(\K\k*\|\d\+\)"
syn match rimlFBVar contained "\<[bwglsavn]:\K\k*\>"

syn keyword rimlLet let unlet skipwhite nextgroup=rimlVar,rimlFuncVar

" Operators:
" =========
syn cluster rimlOperGroup contains=rimlFunc,rimlFuncVar,rimlOper,rimlOperParen,rimlNumber,rimlString,rimlRegister,rimlContinue,rimlBuiltinFunction
syn match rimlOper "\(===\?\|!=\|>=\|<=\|=\~\|!\~\|>\|<\|=\)[?#]\{0,2}" skipwhite nextgroup=rimlString
syn match rimlOper "||\|&&\|[-+.]" skipwhite nextgroup=rimlString
syn region rimlOperParen oneline matchgroup=rimlParenSep start="(" end=")" contains=@rimlOperGroup
syn region rimlOperParen oneline matchgroup=rimlSep start="{" end="}" contains=@rimlOperGroup nextgroup=rimlVar,rimlFuncVar

" Note: this is a hack to prevent keywords being highlighted when dictionary keys
syn match rimlKeywordDict "\%(\%(\.\@<!\.\)\)\_s*\%(function\|if\|else\|elseif\|while\|for\|in\|return\|is\|isnot\)\>"   transparent contains=NONE
syn match rimlKeywordDict "\%(\%(\.\@<!\.\)\)\_s*\%(finish\|break\|continue\|call\|let\|unlet\|throw\|try\|catch\|finally\)\>"     transparent contains=NONE
syn match rimlKeywordDict "\%(\%(\.\@<!\.\)\)\_s*\%(endfunction\|endif\|endwhile\|endfor\|endtry\|end\|self\|def\|defm\|super\)\>" transparent contains=NONE
syn match rimlKeywordDict "\%(\%(\.\@<!\.\)\)\_s*\%(unless\|until\|true\|false\|class\|new\)\>" transparent contains=NONE

" A non-interpolated string
syn cluster rimlBasicString contains=@Spell,rimlEscape
" An interpolated string
syn cluster rimlInterpString contains=@rimlBasicString,rimlInterp

syn region rimlString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=@rimlInterpString
syn region rimlString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=@rimlBasicString

syn region rimlInterp matchgroup=rimlInterpDelim start=/#{/ end=/}/ contained contains=ALL

" Heredoc strings
syn region rimlHeredocStart matchgroup=rimlStringDelimiter start=+<<\%(\h\w*\)\ze+hs=s+2 end=+$+ oneline
syn region rimlString start=+<<\z(\h\w*\)\ze+hs=s+2 matchgroup=rimlStringDelimiter end=+^\z1$+ contains=rimlHeredocStart,@rimlInterpString fold keepend

syn region rimlClassDeclaration start="^\s*\ze\<class\>" end="$" contains=rimlClassName,rimlClassInheritance,rimlClass,rimlOper
syn region rimlClassInheritance start="\([gs]:\)\?[A-Z_]\w*\ze\s\+<\s\+" end="$" oneline keepend matchgroup=rimlClassName contains=rimlOper,rimlClassName containedin=rimlClassDeclaration skipwhite
syn match rimlClassName "\([gs]:\)\?[A-Z_]\w*" contained containedin=rimlClassDeclaration,rimlClassInheritance,rimlImport
syn match rimlClass "\<class\>" contained containedin=rimlClassDeclaration

" riml_source and riml_include
syn region rimlInclude start="^\s*\(riml_include\|riml_source\)" end="$" matchgroup=rimlInclude skipwhite contains=rimlString oneline
syn region rimlImport start="^\s*riml_import" end="$" matchgroup=rimlImport contains=rimlClassName,rimlString,rimlImportKey skipwhite oneline
syn match rimlImportKey "\<riml_import\>" contained containedin=rimlImport

syn match rimlComment +"[^"]\+$+ contains=rimlCommentTitle
syn match rimlComment '^\s*".*$' contains=rimlCommentTitle

syn match rimlCommentTitle '"\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1 contained containedin=rimlComment

" Embedded vim in ExLiteral
syn region rimlExLiteral start=/^\s*:/ end=/$/ contains=@rimlVimEmbed

syn match rimlContinue "^\s*\\"

hi link rimlKeyword Keyword
hi link rimlBool Boolean
hi link rimlClass Keyword
hi link rimlClassName Type
hi link rimlInclude PreProc
hi link rimlImportKey PreProc
hi link rimlLet Keyword
hi link rimlBuiltinFunction Function
hi link rimlBuiltinCommand Keyword
hi link rimlString String
hi link rimlComment Comment
hi link rimlCommentTitle PreProc
hi link rimlInterpDelim Special
hi link rimlStringDelimiter Delimiter
hi link rimlNumber Number
hi link rimlOper Operator
hi link rimlParenSep Delimiter
hi link rimlSep Delimiter
hi link rimlVar Identifier
hi link rimlFuncSID Special
hi link rimlFuncKey Keyword
hi link rimlContinue Special
"highlight link rimlFunction Function

let b:current_syntax = "riml"
