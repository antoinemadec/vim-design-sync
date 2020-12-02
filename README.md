# Rationale

Vim commands for DesignSync version control

# Installation

```vim
Plug 'antoinemadec/vim-design-sync'
```

# Commands

| Command             | Description                                                            |
| ---                 | ---                                                                    |
| `:DesignSyncStatus` | print dssc ls and dssc sitr status in new tab, enter to jump in a file |
| `:DesignSyncDiff`   | diff current file with trunk                                           |

# Vimrc Example
```vim
" mappings
nnoremap <silent> \ds :<C-u>DesignSyncStatus<CR>
nnoremap <silent> \dv :<C-u>DesignSyncDiff<CR>
```

# License

MIT
