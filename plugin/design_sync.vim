" design-sync: vim commands for DesignSync version control
" Maintainer:   Antoine Madec <aja.madec@gmail.com>
" Version:      0.1

if exists('g:loaded_design_sync')
  finish
else
  let g:loaded_design_sync = 'yes'
endif

function DesignSyncDiff() abort
  let remote_file = tempname()
  let current_file = expand('%')
  let cmd = printf('patch --reverse -o %s < <(dssc diff -unified %s)',
        \ remote_file, current_file)
  silent let output = system(cmd)
  if v:shell_error
    echohl WarningMsg | echom "[DesignSync] not part of design sync repo" | echohl None
  else
    diffthis
    exe 'vsplit ' . remote_file
    diffthis
  endif
endfunction

function DesignSyncStatus() abort
  " TODO
endfunction

command DesignSyncDiff call DesignSyncDiff()
command DesignSyncStatus call DesignSyncStatus()
