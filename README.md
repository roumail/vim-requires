# vim-requires

The startup warning roumail's Vim plugins (git-extras, fzf-utils,
dispatch-extras, pytest.vim, vim-prompts, vim-review) show when a plugin they require
isn't loaded:

```
git-extras: requires tpope/vim-fugitive
```

The plugins define their commands as they load, so `vim +BranchDiff` and
`vim -c PRs` find them, and call this once every plugin has loaded, whatever
the order of your Plug lines.

## Install

```vim
Plug 'roumail/vim-requires'
```

## Use

In a plugin file, with each required plugin's `g:loaded_*` guard:

```vim
try
  call roumail_requires#check('git-extras', {
        \ 'tpope/vim-fugitive': 'g:loaded_fugitive',
        \ })
catch /^Vim\%((\a\+)\)\=:E117:/
endtry
```

The warning shows at `VimEnter`, or right away when the plugin loads later.
