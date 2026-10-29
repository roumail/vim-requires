" vim-requires: the startup warning roumail's plugins show when a plugin they
" require isn't loaded.

let s:pending = []

" roumail_requires#check(name, deps): once every plugin has loaded (VimEnter,
" or now when later), warn about the plugins in deps that aren't. deps maps
" each to its g:loaded_* guard: {'tpope/vim-fugitive': 'g:loaded_fugitive'}
function! roumail_requires#check(name, deps) abort
  call add(s:pending, [a:name, a:deps])
  if v:vim_did_enter
    call s:warn()
  elseif len(s:pending) == 1
    augroup roumail_requires
      autocmd!
      autocmd VimEnter * ++once call s:warn()
    augroup END
  endif
endfunction

function! s:warn() abort
  for [l:name, l:deps] in remove(s:pending, 0, -1)
    let l:missing = keys(filter(copy(l:deps), '!exists(v:val)'))
    if !empty(l:missing)
      echohl WarningMsg
      echomsg l:name . ': requires ' . join(sort(l:missing), ', ')
      echohl None
    endif
  endfor
endfunction
