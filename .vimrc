"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle "Shougo/neocomplete.vim"
NeoBundle "tyru/caw.vim"
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle "thinca/vim-quickrun"
NeoBundle "Shougo/vimproc"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "jceb/vim-hier"
NeoBundle "itchyny/lightline.vim"
NeoBundle "KazuakiM/vim-qfstatusline"
NeoBundle "dannyob/quickfixstatus"
call neobundle#end()
 
" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html

""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:gitgutter_system_function       = 'vimproc#system'
let g:gitgutter_system_error_function = 'vimproc#get_last_status'
let g:gitgutter_shellescape_function  = 'vimproc#shellescape'
nnoremap <silent> ,b :<C-u>Unite file_mru buffer<CR>
" nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,f :<C-u>Unite file_rec/async:!<CR>
nnoremap <silent> ,r :<C-u>Unite file_mru buffer<CR>
" nnoremap <silent> ,r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,y :<C-u>Unite history/yank<CR>

" unite-grepのバックエンドをagに切り替える
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200
let s:unite_ignore_file_rec_patterns=
      \ ''
      \ .'vendor/bundle\|.bundle/\|\.sass-cache/\|'
      \ .'node_modules/\|bower_components/\|'
      \ .'\.\(bmp\|gif\|jpe\?g\|png\|webp\|ai\|psd\)"\?$'

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" ファイルは tabdrop で開く
call unite#custom#default_action('file' , 'tabopen')

" unite-grepのキーマップ
" 選択した文字列をunite-grep
vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

call unite#custom#source(
      \ 'file_rec/async,file_rec/git',
      \ 'ignore_pattern',
      \ s:unite_ignore_file_rec_patterns)

""""""""""""""""""""""""""""""
" NeoCompleteを設定
""""""""""""""""""""""""""""""
" 補完を有効にする
let g:neocomplete#enable_at_startup = 1

" 補完に時間がかかってもスキップしない
let g:neocomplete#skip_auto_completion_time = ""


""""""""""""""""""""""""""""""
" caw.vimを設定
""""""""""""""""""""""""""""""
" コメントアウトを切り替えるマッピング
" \c でカーソル行をコメントアウト
" 再度 \c でコメントアウトを解除
" 選択してから複数行の \c も可能
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

" \C でコメントアウトの解除
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)


"""""""""""""""""""""""""""""
"Markdownのプレビュー機能を設定
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown

"""""""""""""""""""""""""""""
"Nerdtreeを設定
""""""""""""""""""""""""""""""
nnoremap <silent><C-e> :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""
"watvhlogsを設定
""""""""""""""""""""""""""""""
" 書き込み後にシンタックスチェックを行う
let g:watchdogs_check_BufWritePost_enable = 1

" こっちは一定時間キー入力がなかった場合にシンタックスチェックを行う
" バッファに書き込み後、1度だけ行われる
let g:watchdogs_check_CursorHold_enable = 1

" watchdogs_checker/_ に設定を記述する事で全ての watchdogs_checker で有効になる
" hook/close_quickfix/enable_exit 1 で :WatchdogsRun 終了時に quickfix ウィンドウが閉じる
let g:quickrun_config = {
\   "watchdogs_checker/_" : {
\       "hook/close_quickfix/enable_exit" : 1,
\   },
\}

" watchdogs.vim の設定を追加
call watchdogs#setup(g:quickrun_config)

" watchdogsのフックを設定
let g:quickrun_config["watchdogs_checker/_"] = {
      \ "outputter/quickfix/open_cmd" : "",
      \ "hook/qfstatusline_update/enable_exit" : 1,
      \ "hook/qfstatusline_update/priority_exit" : 4,
      \ }

" :WatchdogsRun後にlightline.vimを更新
let g:Qfstatusline#UpdateCmd = function('lightline#update')

" lightline.vimの設定
let g:lightline = {
    \ 'mode_map': {'c': 'NORMAL'},
    \ 'active': {
    \   'right': [
    \     [ 'syntaxcheck' ],
    \   ]
    \ },
    \ 'component_expand': {
    \   'syntaxcheck': 'qfstatusline#Update',
    \ },
    \ 'component_type': {
    \   'syntaxcheck': 'error',
    \ },
    \ }

"-------------------------
" End Neobundle Settings.
"-------------------------
"=======================================================

" ------------------------------------------------------
" colorscheme
" ------------------------------------------------------
autocmd ColorScheme * highlight LineNr ctermfg=200
syntax on
set background=dark
colorscheme hybrid

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
 
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

""""""""""""""""""""""""""""""
" 各種オプションの設定
""""""""""""""""""""""""""""""
" タグファイルの指定(でもタグジャンプは使ったことがない)
set tags=~/.tags
" スワップファイルは使わない(ときどき面倒な警告が出るだけで役に立ったことがない)
set noswapfile
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" コマンドラインに使われる画面上の行数
set cmdheight=2
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" タブ入力を複数の空白入力に置き換える
set expandtab
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" 行番号を表示する
set number
" 対応する括弧やブレースを表示する
set showmatch
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" タブ文字の表示幅
set tabstop=2
" Vimが挿入するインデントの幅
set shiftwidth=2
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" jjでエスケープ
inoremap <silent> jj <ESC>
" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"タブ、空白、改行の可視化
"set list
"set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

"全角スペースをハイライト表示
"function! ZenkakuSpace()
"    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
"endfunction
"   
"if has('syntax')
"    augroup ZenkakuSpace
"        autocmd!
"        autocmd ColorScheme       * call ZenkakuSpace()
"        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"    augroup END
"    call ZenkakuSpace()
"endif

" カッコの補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif
