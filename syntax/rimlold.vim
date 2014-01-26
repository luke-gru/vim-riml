" Language:    Riml
" Maintainer:  Luke Gruber <luke.gru@gmail.com>
" URL:         http://github.com/luke-gru/vim-riml
" License:     MIT

if exists('b:current_syntax') && b:current_syntax == 'riml'
  finish
endif

if exists("g:vimsyn_noerror")
  let s:vimsyn_noerror_old = g:vimsyn_noerror
else
  let s:vimsyn_noerror_old = -1
endif

let g:vimsyn_noerror = 1

source $VIMRUNTIME/syntax/vim.vim

syn keyword vimCommand contained new class unless until def defm end super riml_source riml_include riml_import true false

syn keyword vimFuncKey contained  def defm

syn match vimFunction "\<def\%[m]!\=\s\+\%(<[sS][iI][dD]>\|[sSgGbBwWtTlLn]:\)\=\%(\i\|[#.]\|{.\{-1,}}\)*\ze\s*(" contains=@vimFuncList nextgroup=vimFuncBody

syn match vimOper /===/ skipwhite nextgroup=vimString,vimSpecFile

syn region VimString contained oneline start=/"/ end=/"/ skip=/\\"/ contains=rimlInterp

syn region rimlInterp contained matchgroup=rimlInterpDelim start=/#{/ end=/}/ contains=@rimlAll
hi def link rimlInterpDelim PreProc

syn cluster rimlAll contains=vimIsCommand,vimNumber,vimVar,vimFBVar,
\                              vimCmdSep,@vimOperGroup,@vimFuncList,
\                              @vimFuncBodyList,vimComment,vimEnvvar,
\                              vimString,vimLet,vimFuncVar,vimCmdSep


if s:vimsyn_noerror_old ==# -1
  unlet! g:vimsyn_noerror
else
  g:vimsyn_noerror = s:vimsyn_noerror_old
end

let b:current_syntax='riml'
