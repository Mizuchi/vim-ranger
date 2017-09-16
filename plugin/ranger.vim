" forked from 
" https://github.com/hut/ranger/blob/master/examples/vim_file_chooser.vim
"

if !exists('g:ranger_executable')
  let g:ranger_executable = 'ranger'
endif

if !exists('g:ranger_open_mode')
  let g:ranger_open_mode = 'tabe'
endif

function! s:RangerChooserForAncientVim(dirname)
    let temp = tempname()
    if has("gui_running")
        exec 'silent !xterm -e ' . g:ranger_executable . ' --choosefiles=' . shellescape(temp) . ' ' . a:dirname
    else
        exec 'silent !' . g:ranger_executable . ' --choosefiles=' . shellescape(temp) . ' ' . a:dirname
    endif
    if !filereadable(temp)
        " close window if nothing to read, probably user closed ranger
        close
        redraw!
        return
    endif
    let names = readfile(temp)
    if empty(names)
        " close window if nothing to open.
        close
        redraw!
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    filetype detect
    " open any remaning items in new tabs
    for name in names[1:]
        exec g:ranger_open_mode . ' ' . fnameescape(name)
        filetype detect
    endfor
    redraw!
endfunction

function! s:RangerChooserForNeoVim(dirname)
    let s:callback = {'tempname': tempname()}
    function! s:callback.on_exit(id, exit_status, event) dict abort
        if exists('g:ranger_on_exit')
          exec g:ranger_on_exit
        endif
        try
            if filereadable(self.tempname)
                let names = readfile(self.tempname)
                exec 'edit ' . fnameescape(names[0])
                for name in names[1:]
                    exec g:ranger_open_mode . ' ' . fnameescape(name)
                endfor
            endif
        endtry
    endfunction
    let cmd = g:ranger_executable . ' --choosefiles='.s:callback.tempname.' '.shellescape(a:dirname)
    call termopen(cmd, s:callback)
    startinsert
endfunction

function! s:RangerChooser(dirname)
    if isdirectory(a:dirname)
        if has('nvim')
            call s:RangerChooserForNeoVim(a:dirname)
        else
            call s:RangerChooserForAncientVim(a:dirname)
        endif
    endif
endfunction

au BufEnter * silent call s:RangerChooser(expand("<amatch>"))
let g:loaded_netrwPlugin = 'disable'
