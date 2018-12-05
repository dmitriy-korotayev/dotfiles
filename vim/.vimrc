" Author: Dmitriy Korotayev
" Thanks or their vimrc to: Steve Losh <steve@stevelosh.com>

" Preamble {{{

set nocp " Vi-compatibility off

" Per project .vimrc
set exrc    " enable per-directory .vimrc files
set secure  " disable unsafe commands in local .vimrc files
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}
" Load Plugins {{{

call plug#begin('~/.vim/plugged')
let lite = $VIM_LITE == 'true' ? 1 : 0

" Sensible defaults
Plug 'tpope/vim-sensible'
" Appearance {{{

" Best colorscheme
Plug 'altercation/vim-colors-solarized'
" Better whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" }}}
" Text {{{

" Linediff - compare two blocks of code
"Plug 'AndrewRadev/linediff.vim'
" NERDCommenter - intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
" Surround - quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Tabular - readable code with smart <space>ing
Plug 'godlygeek/tabular'
" vim-textobj-user - Create your own text objects
Plug 'kana/vim-textobj-user'
" ic, ac, iC, and aC as text-objects.
" Use them in commands like vic, cic, and daC
Plug 'coderifous/textobj-word-column.vim'

" }}}
" Editing {{{

" Abolish - ultimate iabbrev solution
Plug 'tpope/vim-abolish'
" delimitMate - auto-completion for ({["'`
Plug 'Raimondi/delimitMate'
if !lite
    " UltiSnips - best snippet engine (python-based)
    Plug 'SirVer/ultisnips'
    " YouCompleteMe: a code-completion engine for
    "Plug 'Valloric/YouCompleteMe'
endif

" }}}
" Files and their containers {{{

" Ag.vim - Ack.vim alternative
Plug 'rking/ag.vim'
" Ale - Asynchronous Lint Engine
Plug 'w0rp/ale'
" BufferLine - buffers in the command line
Plug 'bling/vim-bufferline'
" :BufOnly - leave only current buffer
Plug 'vim-scripts/BufOnly.vim'
" CtrlP - full path fuzzy file, buffer, mru, tag finder
Plug 'kien/ctrlp.vim'
" Vim-Sync - \su to upload to and \sd to download from remote.
" Uses .sync in a project directory
Plug 'eshion/vim-sync'
" NetGrep - grep and find on a remote server
Plug 'sirbrillig/netgrep'
" :Greplace - replacing pattern across multiple files
Plug 'vim-scripts/Greplace.vim'
" MRU - Most Recently Used files
Plug 'yegappan/mru'
" NERDTree - tree explorer
if !lite
    Plug 'scrooloose/nerdtree'
endif
" :Rename the current file and retain relative path
Plug 'danro/rename.vim'

" }}}
" Filetype-specific {{{

" Most of language packs you'll need
Plug 'sheerun/vim-polyglot'
" Bash
" Plug 'vim-scripts/bash-support.vim'
" HTML & preprocessors {{{

" Emmet - expanding html abbreviations
Plug 'mattn/emmet-vim'

" Matchit - extended % matching
Plug 'tmhedberg/matchit'
" MatchTag - highlight matching tag
Plug 'gregsexton/MatchTag'
" CloseTag - Automatically closes HTML tags on >
Plug 'alvan/closetag.vim'

" Ragtag - Useful mappings like <C-X>= or <C-X><Space>
" for XML/HTML and dynamic content files
" Also encodes tags, <C-V>% - URL encode next character
Plug 'tpope/vim-ragtag'

" }}}
" JS & preprocessors {{{

" Syntax for lots of javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Tern-based (improved) javascript editing
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

" detect extensionless node scripts (executables) via shebang
" and add gf for going to node_modules files
Plug 'moll/vim-node'

" Parameter completion (in or after ' or "), bound to user complete
"Plug 'othree/jspc.vim'
" Automatic import generation with <leader>j
Plug 'trotzig/import-js'
" <leader>pd on function to insert jsdoc above
Plug 'heavenshell/vim-jsdoc'

" }}}
" Ruby and RoR {{{

" rails.vim - Ruby on Rails power tools
Plug 'tpope/vim-rails'

" Endwise - adding end after if, do, def...
" Also supports bash, c/c++, lua
Plug 'tpope/vim-endwise'

" Refactoring tool for Ruby (:R...)
Plug 'ecomba/vim-ruby-refactoring'

" A custom text object for selecting ruby blocks
if !lite
    Plug 'nelstrom/vim-textobj-rubyblock'
endif

" }}}

" }}}
" Uncategorized {{{

" Clam - advanced shell output
Plug 'sjl/clam.vim'
" Fugitive - Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" Git runtime files
Plug 'tpope/vim-git'
" Ruscmd - command mode in Russian keyboard layout
if !lite
    Plug 'powerman/vim-plugin-ruscmd'
endif
" Scratch buffer for vim
Plug 'duff/vim-scratch'
" Tagbar - displays tags in a window, ordered by class
Plug 'majutsushi/tagbar'
" Vim-misc - Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-misc'

" }}}
" Add plugins to &runtimepath
call plug#end()

" }}}

" Options {{{

" Common {{{

" Use mouse for selection and movement
set mouse=a
set shell=/bin/bash

" utf-8 {{{

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

" }}}
" redraws {{{
set ttyfast " u got a fast terminal
"set ttyscroll=3
set lazyredraw " to avoid scrolling problems
" }}}

" }}}
" Interface {{{

set nu " Line numbers at the left

set stl=%f%r%w%h%4m\ (%{&ff}){%Y}\ [%l,%v][%p%%] " statusline format
set sc " Visual mode info on the right

" Colors {{{

set t_Co=256 " 256 colors
"set smc=500 " Don't try to highlight long lines
let g:solarized_termcolors=256
let g:solarized_termtrans=1 " transparent terminal bg
colorscheme solarized

" }}}

set tf " Improves smoothness of redrawing
set lz " Screen doesn't redraw on macro, etc execution

" }}}
" Text {{{

" Behavior {{{

set tw=72 " Text width set at the best default
set fo-=t " Don't move text onto new line automatically

set so=3 " Minimal number of lines above the cursor

set wrap " Wrap the text in a window
set lbr " break line with 'breakat' characters like -,@=<space>
set cc=+1 " textwidth breakpoint vertical column

" }}}
" Folding & brackets {{{

set fdm=marker " Fold by pre-set markers
set fdls=0 " Close all folds on file open

set sm " Highlight matching bracket

" }}}
" Searching {{{

set grepprg=ack " use Ack instead of grep

set ic  " Ignore case in search
set scs " if uppercase letter is typed, search case-sensitive

set hls " Highlight previous search pattern matches

" }}}

" }}}
" Editing {{{

" Tabs {{{

set sw=2  " Number of spaces for >>,<<,(auto)indentation
set sr    " Round indentation, disallow extra spaces
set ts=2  " Number of spaces for <Tab>
set et    " Use spaces for <Tab> in insert mode
"set sts=2 " Number of spaces for <Tab> in insert mode

" }}}
" Typing assistance (autocomplete, spelling) {{{

set completeopt=longest,menuone,preview " Better Completion
set dict=/usr/share/dict/words " Word dictionary for completion
set spl=en
set spf=~/.vim/en.utf-8.add " Custom word spelling file

" Wildmenu completion {{{

set wim=longest,list,full

" Ignored files
set wig+=.hg,.git,.svn                    " Version control
set wig+=lib
set wig+=node_modules,bower_components,build " ususal js stuff

set wig+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wig+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wig+=*.spl                            " compiled spelling word lists

set wig+=*.sw?                            " Vim swap files
set wig+=*.pyc                            " Python byte code
set wig+=*.luac                           " Lua byte code

set wig+=*.DS_Store                       " OSX bullshit
set wig+=*.orig                           " Merge resolution files

" }}}

" }}}

" }}}
" Files and their containers {{{

set bkc=yes " cp a file on backup instead of mv
set ar " Read file automatically on modification outside
set spr " Splits created on the right

" open help on the right too
cnoremap help vert help 

" }}}
" Buffers {{{

set hid " Hide buffer, don't require save/undo

" }}}
" Sessions {{{

" Restore last cursor position
au BufWinLeave *.c mkview
au BufWinEnter *.c silent loadview

" Swap {{{

if isdirectory($HOME . '/.vim/tmp/swap') == 0
  :sil !mkdir -p ~/.vim/tmp/swap >/dev/null 2>&1
endif
set dir=~/.vim/tmp/swap//   " swap files

" }}}
" Undo {{{

set udf     " Enable undo file
set ul=1000 " Maximum number of undo's in memory
if isdirectory($HOME . '/.vim/tmp/undo') == 0
  :sil !mkdir -p ~/.vim/tmp/undo >/dev/null 2>&1
endif
set udir=~/.vim/tmp/undo//

" }}}
" Backup {{{

set bk      " Enable backups
if isdirectory($HOME . '/.vim/tmp/backup') == 0
  :sil !mkdir -p ~/.vim/tmp/backup >/dev/null 2>&1
endif
set bdir=~/.vim/tmp/backup//
set bsk=/tmp/*,/private/tmp/*" " Make Vim able to edit crontab files again.

" }}}

" }}}

" }}}
" Mappings {{{

" Common {{{

" Move by characters, not lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

inoremap jj <Esc>

nnoremap ; :
vnoremap ; :

" Unmap {{{

" Make Q useful and avoid the confusing Ex mode.
noremap Q <nop>

"noremap  <F1> <nop>

" }}}


" }}}
" Text {{{

" Selection {{{

" Select (charwise) the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" "u" in visual mode accidentally to "y". Use "gu".
vnoremap u <nop>
vnoremap gu u

" }}}
" Folding {{{

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
nnoremap <C-Space> zMzv
vnoremap <C-Space> zMzv

" }}}
" Searching {{{

" Clear search matches
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Don't move on *
nnoremap * *<c-o>

" }}}

" }}}
" Editing {{{

" Text {{{

" Delete until the end of line
nnoremap D d$

" }}}
" Lines {{{

" Split line
nnoremap S i<cr><esc>
" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Drag Lines {{{

" <c-j> and <c-k> to drag lines in any mode
noremap <c-j> :m+<CR>
noremap <c-k> :m-2<CR>
"inoremap <c-j> <Esc>:m+<CR>
"inoremap <c-k> <Esc>:m-2<CR>
vnoremap <c-j> :m'>+<CR>gv
vnoremap <c-k> :m-2<CR>gv

" }}}

" }}}
" More {{{

" System clipboard {{{

" Toggle paste
set pastetoggle=<F6>

nnoremap <leader>y "+y
nnoremap <leader>p :set paste<CR>"+p<CR>:set nopaste<CR>
nnoremap <leader>P :set paste<CR>"+P<CR>:set nopaste<CR>
vnoremap <leader>y "+ygv

" }}}

" Clean trailing whitespace
"nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" }}}

" }}}
" Files and their containers {{{

" Save with sudo
cmap w!! %!sudo tee > /dev/null %

" Filetypes {{{

nnoremap <leader>fp :set ft=php<CR>
nnoremap <leader>fr :set ft=ruby<CR>
nnoremap <leader>fe :set ft=eruby<CR>

nnoremap <leader>fc :set ft=css<CR>
nnoremap <leader>fh :set ft=html<CR>
nnoremap <leader>fj :set ft=javascript<CR>

nnoremap <leader>fl :set ft=slim<CR>
nnoremap <leader>fa :set ft=haml<CR>
nnoremap <leader>fd :set ft=jade<CR>
nnoremap <leader>fs :set ft=sass<CR>
nnoremap <leader>fo :set ft=coffee<CR>

nnoremap <leader>fv :set ft=vim<CR>
nnoremap <leader>fz :set ft=zsh<CR>

" }}}
" Windows {{{

" Just my favourite window mapping
nnoremap , <C-w>

" Close window.
noremap QQ :q<CR>
" Close all.
noremap QA :qa<CR>
" Close, damn you!
noremap Q! :q!<CR>

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-\> <c-w>v<c-]>zvzz

" }}}
" Buffers {{{

" Close buffer (aka buffer delete)
noremap QB :bd<CR>
" Close all buffers except opened one
noremap QO :BufOnly

" Delete all buffers
nnoremap <leader>bd :1,1000bd<CR>:bd<CR><CR>

" }}}

" }}}
" Other {{{

" Edit vimrc file
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
" Refresh vimrc and vim itself
nnoremap <silent> <leader>rv :source $MYVIMRC<CR>

" }}}

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set noto

" }}}
" Functions {{{

" Toggle Background {{{

function! ToggleBackground()
let isbgl = &bg == "light"
colorscheme solarized
exe isbgl ? "se bg=dark" : "se bg=light"
endfunction
map <silent><F7> :call ToggleBackground()<CR>

" }}}
" MakeSession and LoadSession {{{

function! MakeSession() " {{{
if exists(':MgrClose')
exe 'MgrClose'
endif

let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
if (filewritable(b:sessiondir) != 2)
exe 'silent !mkdir -p ' b:sessiondir
redraw!
endif
let b:filename = b:sessiondir . '/session.vim'
exe "mksession! " . b:filename
exe "silent !chown dmitriy -R ".b:sessiondir

if exists(':MgrOpen')
exe 'MgrOpen'
endif
endfunction " }}}
function! LoadSession() " {{{
let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
let b:sessionfile = b:sessiondir . "/session.vim"
if (filereadable(b:sessionfile))
exe 'source ' b:sessionfile
else
echo "No session loaded."
endif
endfunction " }}}
"au VimEnter * nested if argc() == 0 | :call LoadSession() | endif
"au VimLeave * :call MakeSession()

" }}}
" Improved indent folding {{{

" Helper functions {{{

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

" }}}

function! GetImprovedIndentFold(lnum)
    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    " If line is empty and previous is not, include it in fold,
    " relative to the next non-blank line's indentation
    if getline(a:lnum) =~? '\v^\s*$'
        if getline(a:lnum - 1) =~? '\v^\s*\S.*'
            return next_indent + 1
        endif
    endif

    " Other empty lines remain at same fold
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    " Indentation folding
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

" }}}
" Improved foldtext {{{

fu! ImprovedFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set fdt=ImprovedFoldText()

" }}}

" }}}

" Filetypes {{{

" CSS & preprocessors {{{

augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-
    au Filetype css setlocal sw=2 ts=2 sts=2

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css,*.scss inoremap <buffer> {<cr> {}<left><cr><cr><up><tab>
augroup END

" }}}
" JS {{{

let g:jsx_ext_required = 0 " Allow JSX in normal JS files
augroup ft_javascript
    au!

    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    "au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>
augroup END

" }}}
" Ruby {{{

augroup ft_ruby
    au!
    au BufNewFile,BufRead *.prawn set filetype=ruby
    au Filetype eruby setlocal sw=4 ts=4 sts=4
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    "au BufWritePost *.rb !ruby -cw %
    " File function - ruby hash syntax
    map <leader>ffrh :%s/:\(\w*\)\(\s*\)=> /\1:\2/g
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    au!
    au BufNewFile,BufRead *.m*down setlocal filetype=markdown
augroup END

" }}}
" SH {{{

augroup ft_sh
    au FileType sh setlocal fml=1
augroup END

" }}}
" PHP {{{

" *.tpl files are usually php
au BufRead,BufNewFile *.tpl set filetype=php

au FileType php set omnifunc=phpcomplete#CompletePHP

"" }}}

" }}}
" Plugins {{{

" BufferLine {{{

let g:bufferline_rotate = 2

" }}}
" Clam {{{

nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
let g:clam_autoreturn = 1

" }}}
" CloseTag {{{

let g:closetag_filenames = "*.html,*.js,*.jsx,*.php"
au FileType html,javascript.jsx,php let b:delimitMate_matchpairs = "(:),[:],{:}"

" }}}
" ctrl-p {{{

let g:ctrlp_working_path_mode = 0
let g:ctrlp_open_multiple_files = 'i'

" }}}
" delimitMate {{{

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
au FileType vim let b:delimitMate_quotes = "'"

" }}}
" Emmet {{{
let g:user_emmet_settings={'javascript.jsx': {'extends':'jsx'}}
" }}}
" Fugitive {{{

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>

nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gr :Gremove<cr>

nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>

nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gp :Git push<CR>

nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}

" "Hub"
" nnoremap <leader>H :Gbrowse<cr>
" vnoremap <leader>H :Gbrowse<cr>

" }}}
" Linediff {{{

vnoremap <leader>l :Linediff<cr>
nnoremap <leader>L :LinediffReset<cr>

" }}}
" MRU {{{

nnoremap <F3> :MRU<CR>
let MRU_File = expand('~/.vim/tmp/plugin_mru_files')

" }}}
" NERD Tree {{{

noremap  <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
            \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
            \ '.*\.o$', 'db.db', 'tags.bak']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" }}}
" NERDCommenter {{{
let NERDSpaceDelims=1
" }}}
" StripWhitespace {{{

nnoremap <leader>w :StripWhitespace<cr>

" }}}
" Vdebug {{{

let g:vdebug_options = {"port":9001}

" }}}
" Tabular {{{

if exists(":Tabularize")
    nmap <Leader>t= :Tabularize /=<CR>
    vmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t: :Tabularize /:\zs<CR>
    vmap <Leader>t: :Tabularize /:\zs<CR>
endif

" }}}
" TagBar {{{

" Open the TagBar Plugin <F4>
nmap <F4> :TagbarToggle<CR>

" }}}
" TagmaBufMgr {{{

let g:TagmaBufMgrLastLine   = 1
let g:TagmaBufMgrLocation = 'B'

"let g:TagmaBufMgrStatusLine = ' -- Buffers -- '

let g:TagmaBufMgrMapCArrow  = 0
let g:TagmaBufMgrMapChjkl   = 0
let g:TagmaBufMgrMapCTab    = 0

" }}}
" UltiSnips {{{

let g:snips_author='Dmitriy Korotayev <korotayev.dmitriy@gmail.com>'
let g:UltiSnipsExpandTrigger="<c-e>"

" }}}
" Vdebug {{{

let g:vdebug_options = {"port":9001}

" }}}

" }}}

" Fixes {{{

" Fix arrows in Insert mode {{{

imap <ESC>oA <ESC>ki
imap <ESC>oB <ESC>ji
imap <ESC>oC <ESC>li
imap <ESC>oD <ESC>hi

" }}}

" }}}
