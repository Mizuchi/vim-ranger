vim-ranger
==========

How to use it
---------------

It just works.

User Guide
----------

`ranger <http://ranger.nongnu.org/>`_ is a file manager with VI key bindings.

This plugin is similar to `nerdtree <https://github.com/scrooloose/nerdtree>`_. 
It overrides the default file browser (netrw), so if you :edit a directory a ranger will be opened. 
When you open a file in ranger, it will be opened in vim.
You could also select multiple files and open'em all at once (use ``v`` to select multiple files in ranger).
BTW, don't use it with nerdtree at the same time. 

Configuration
-------------

Set ranger executable path: `let g:ranger_executable = 'ranger'`

Tips
-----

You can add ``nnoremap <f3> :tabe %:p:h<cr>`` to your .vimrc so that you could use ``<f3>`` to open new files in new tab.

Known issue
-----------

1. (Only for vanilla vim) After opening ranger once and back to vim, you can't use arrow-up/arrow-down to observe vim command line ":" history doesn't work anymore (unless restart vim).
   Workaground: use Ctrl+UP/DOWN to observe history, instead of just UP/DOWN.
2. (Only for neovim) some shortcut don't work, such as "F8", "<c-h>" because of neovim limitation.

Requirement
------------

ranger >= 1.5.1

Notes
-----

This plugin is forked from the official ranger example here:
https://github.com/hut/ranger/blob/master/examples/vim_file_chooser.vim

There are 3 main differences

1. Unlike the original plugin, in my plugin the files are opened in tabs instead of buffers.
2. Ranger will be opened automatically when you :edit a directory. The original plugin requires to execute a vim command to open ranger.
3. My plugin supports neovim.

Copyright (C) 2015 Tianjiao Yin <ytj000@gmail.com>
