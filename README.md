# Rationale

Vim commands for DesignSync version control

# Installation

```vim
Plug 'antoinemadec/vim-design-sync'
```

# Commands

| Command           | Description                  |
| ---               | ---                          |
| `:DesignSyncDiff` | diff current file with trunk |

# Vimrc Example
```vim
" mappings
nnoremap <silent> \dv :<C-u>DesignSyncDiff<CR>
```

# License

MIT
