if exists("g:vim_riml_syntax_checker_loaded")
  finish
endif

function! SyntaxCheckers_riml_riml_IsAvailable() dict
  return executable(self.getExec())
endfunction

function! SyntaxCheckers_riml_riml_GetLocList() dict
  let makeprg = self.makeprgBuild({
        \ 'exe': self.getExecEscaped(),
        \ 'args': '-k'})

  let errorformat =
    \ '%ERiml::SyntaxError,' .
    \ '%Clocation: <String>:%l,' .
    \ '%Zmessage: %m,' .
    \ '%ERiml::ParseError,' .
    \ '%Clocation: <String>:%l,' .
    \ '%Zmessage: %m'


  return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
      \ 'filetype': 'riml',
      \ 'name': 'riml',
      \ 'exec': 'riml' })

let g:vim_riml_syntax_checker_loaded = 1
