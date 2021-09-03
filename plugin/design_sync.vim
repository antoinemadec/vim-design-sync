" design-sync: vim commands for DesignSync version control
" Maintainer:   Antoine Madec <aja.madec@gmail.com>
" Version:      0.1

if exists('g:loaded_design_sync')
  finish
else
  let g:loaded_design_sync = 'yes'
endif

function DesignSyncDiff() abort
  let diff_file = tempname()
  let remote_file = tempname()
  let current_file = expand('%')
  let current_file_dir = expand('%:h')
  let cmd = printf('dssc diff -unified %s > %s', current_file, diff_file)
  silent let output = system(cmd)
  if v:shell_error
    echohl WarningMsg | echom "[DesignSync] not part of design sync repo" | echohl None
    return
  endif
  let cmd = printf('patch --reverse -d %s -o %s < %s', current_file_dir, remote_file, diff_file)
  silent let output = system(cmd)
  if v:shell_error
    exe "silent w! " . remote_file
  endif
  diffthis
  exe 'vsplit ' . remote_file
  diffthis
endfunction

function DesignSyncStatus() abort
  call s:exec_and_print_cmd('dssc sitr status', 'tabnew')
  silent normal d3j
  silent g/^$/d
  normal gg
  redraw
  call s:exec_and_print_cmd('dssc ls -report status -modified -rec', 'new')
  silent normal d3j
  silent g/^$/d
  normal gg
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>dssc_ls_jump_file()<CR>
endfunction

function s:exec_and_print_cmd(cmd, new) abort
  silent let output = system(a:cmd)
  if v:shell_error
    echohl WarningMsg | echom "[DesignSync] (" . a:cmd . ") failed" | echohl None
  else
    exe a:new
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    setlocal ft=log
    call setline(1, split(output, "\n"))
  endif
endfunction

function s:dssc_ls_jump_file() abort
  let save_cursor = getpos('.')
  normal 0g_
  let filename = expand("<cWORD>")
  let search_result = search("Directory of: ", "b")
  let dirname = substitute(getline('.'), 'Directory of: file://', '', '')
  let fullpath = dirname . '/' . filename
  call setpos('.', save_cursor)
  if filereadable(fullpath)
    exe 'tabedit ' fullpath
  endif
endfunction

command DesignSyncDiff call DesignSyncDiff()
command DesignSyncStatus call DesignSyncStatus()
