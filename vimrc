"
" ============================================================
" Vim 基本設定
" ============================================================

" ------------------------------------------------------------
" 文字コード・改行コード
" ------------------------------------------------------------

scriptencoding utf-8

" ファイルを開く際の文字コード判定順
set fileencodings=ucs-bom,utf-8,cp932,utf-16le

if has('unix')
    set fileformats=unix,dos,mac
else
    set fileformats=dos,unix,mac
endif

" vi互換にしない
if &compatible
    set nocompatible
endif


" ------------------------------------------------------------
" ファイル・バッファ
" ------------------------------------------------------------

" 保存時のみ元ファイルバックアップを作成する機能を無効化
set nobackup

" 正常終了（保存完了）後にバックアップファイルを削除する
" 保存時のみ元ファイルバックアップを作成し、保存成功後バックアップを削除する
set writebackup

" スワップファイルを作成する
set swapfile

" 編集中のファイルのディレクトリをカレントディレクトリにする
set autochdir

" 編集中のファイルが変更されたら自動で読み直す
set autoread

" バッファが編集中でもその他のファイルを開けるようにする
set hidden

" 起動時の空バッファの扱いを変更する。
autocmd BufLeave * if bufnr('%') == 1 && bufname('%') == '' | setlocal bufhidden=wipe | endif


" ------------------------------------------------------------
" 表示
" ------------------------------------------------------------

" 行番号を表示
set number

" 現在の行を強調表示
set cursorline

" 現在の列を強調表示
" set cursorcolumn

" 行末の1文字先までカーソルを移動できるようにする
set virtualedit=onemore

" ビープ音を可視化
set visualbell

" ステータスラインを常に表示
set laststatus=2

" 折り返ししない
"set nowrap

" 全角幅で表示する
if has('multi_byte')
    set ambiwidth=double
endif

" 背景色
set background=dark
colorscheme slate

" ------------------------------------------------------------
" 不可視文字
" ------------------------------------------------------------

" 不可視文字を可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%


" ------------------------------------------------------------
" カーソル・編集
" ------------------------------------------------------------

" カーソル移動を行をまたいで可能にする
set whichwrap=b,s,[,],<,>

" バックスペースを空白・行末・行頭でも使えるようにする
set backspace=indent,eol,start

" 括弧入力時に対応する括弧を表示
set showmatch
set matchtime=1

" ヤンク／プット時にクリップボードを使用する
set clipboard+=unnamed

" ペーストモードの切り替え
set pastetoggle=


" ------------------------------------------------------------
" コマンドライン
" ------------------------------------------------------------

" 入力中のコマンドをステータスに表示
set showcmd

" コマンドライン補完
set wildmode=list:longest
set wildmenu


" ------------------------------------------------------------
" 検索
" ------------------------------------------------------------

" 小文字だけなら大文字小文字を区別しない
set ignorecase

" 大文字を含む場合は大文字小文字を区別する
set smartcase

" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch

" 最後まで検索したら最初に戻る
set wrapscan

" 検索語をハイライト表示
set hlsearch

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR>

" ------------------------------------------------------------
" Terminal設定
" ------------------------------------------------------------

" スクロールバッファの容量（行数）を指定する
set termwinscroll=20000

" ターミナルで Esc キー(または、CTRL + [ )を2回押すとノーマルモード（スクロール可能）に切り替える
" 元に戻すには insert モードにする('i'を入力する)
tmap <Esc><Esc> <C-W>N

" ------------------------------------------------------------
" Git Bash ターミナルの起動
" ------------------------------------------------------------

" Windows（32ビットまたは64ビット）環境の場合のみ実行
if has('win32') || has('win64')

  " Git Bash を開く専用コマンド :term_git を定義
  command! TermGit call s:OpenGitBash()

  function! s:OpenGitBash() abort
    " Git Bash の実行ファイルパス
    let l:bash_path = 'C:/Program Files/Git/bin/bash.exe'

    " Git Bash のログインスクリプトによる 'cd ~' (ホームへの移動) をスキップさせる
    let $CHERE_INVOKING = 1

    " ++dir=... で Vim のカレントディレクトリを明示指定
    let l:cwd = fnameescape(getcwd())

    if filereadable(l:bash_path)
      let l:options = '-i -l'

      " ターミナルで Git Bash をログインシェルとして起動
      " 1. 画面下に高さ12行の空きウィンドウを作成
      belowright 12new

      " 2. 作成したカレントウィンドウ内でターミナルを起動
      call term_start([l:bash_path, '-i', '-l'], {
            \ 'cwd': getcwd(),
            \ 'term_finish': 'close',
            \ 'curwin': 1,
            \ })
    else
      echoerr 'Git Bash が見つかりません: ' . l:bash_path
    endif
  endfunction

  " コマンドラインで 'term_git' と打ったら"TermGit"に自動置換して起動
  cabbrev term_git TermGit

endif


" ------------------------------------------------------------
" PowerShell 5.1 ターミナルの起動
" ------------------------------------------------------------

" Windows（32ビットまたは64ビット）環境の場合のみ実行
if has('win32') || has('win64')

  " PowerShell 5.1 を開く専用コマンド :term_pwsh を定義
  command! TermPowerShell call s:OpenPowerShell51()

  function! s:OpenPowerShell51() abort
    " PowerShell 5.1 の実行ファイルパス
    let l:ps_path = 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe'

     if filereadable(l:ps_path)
       " 1. 画面下に高さ 12 行の新規ウィンドウを作成
       belowright 12new

       " 2. 作成したウィンドウ内で PowerShell を起動（Vimのカレントディレクトリを渡す）
       call term_start([l:ps_path, '-NoExit', '-ExecutionPolicy', 'Bypass'], {
         \ 'cwd': getcwd(),
         \ 'term_finish': 'close',
         \ 'curwin': 1,
         \ })
    else
      echoerr 'PowerShell 5.1 が見つかりません: ' . l:ps_path
    endif
  endfunction

  " コマンドラインで 'term_git' と打ったら"TermPowerShell"に自動置換して起動
  cabbrev term_pwsh TermPowerShell
endif


" ------------------------------------------------------------
" ステータスライン
" ------------------------------------------------------------

set statusline=%F
set statusline+=%m
set statusline+=%r
set statusline+=%=
set statusline+=[%l/%L]
set statusline+=[%c]
set statusline+=[%{(&fenc!=''?&fenc:&enc).':'.&ff}]


" ============================================================
" ファイルタイプ
" ============================================================

filetype plugin indent on
syntax on


" ------------------------------------------------------------
" ファイルタイプ・新規ファイルのデフォルト設定
" ------------------------------------------------------------

function! s:SetDefaultFileSettings() abort
    " ファイルタイプが決まらない場合はtextにする
    if len(&filetype) == 0
        set filetype=text
    endif

    " 新規ファイルの保存文字コード
    if len(&fileencoding) == 0
        if has('unix')
            set fileencoding=utf-8
        else
            set fileencoding=cp932
        endif
    endif
endfunction

autocmd BufEnter * call s:SetDefaultFileSettings()


" ------------------------------------------------------------
" コメント化・アンコメント化
" ------------------------------------------------------------

function! ToggleComment(comment) range
    let comment = escape(a:comment, '\')
    let all_commented = 1

    for lnum in range(a:firstline, a:lastline)
        if getline(lnum) !~# '^\s*' . comment . '\s'
            let all_commented = 0
            break
        endif
    endfor

    if all_commented
        " 全行がコメントならアンコメント
        execute a:firstline . ',' . a:lastline
                    \ . 's/^\(\s*\)' . comment . '\s\?/\1/'
    else
        " それ以外はコメント
        execute a:firstline . ',' . a:lastline
                    \ . 's/^\(\s*\)/\1' . a:comment . ' /'
    endif
endfunction


" ============================================================
" text
" ============================================================

augroup filetype_text
    autocmd!

    " 引用コメント化・引用アンコメント化
    autocmd FileType text xnoremap <buffer> <silent> <C-K> :call ToggleComment('>')<CR>

    " インデント
    autocmd FileType text setlocal tabstop=4 shiftwidth=4 softtabstop=0
augroup END


" ============================================================
" Vim
" ============================================================

augroup filetype_vim
    autocmd!

    " インデント
    autocmd FileType vim setlocal smartindent shiftwidth=2 tabstop=2 softtabstop=0

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.vimrc,*.gvimrc :%s/\s\+$//ge

    " コメント化・アンコメント化
    autocmd FileType vim xnoremap <buffer> <silent> <C-K> :call ToggleComment('"')<CR>

    " TAB文字をスペースにする
    autocmd FileType vim setlocal expandtab
augroup END


" ============================================================
" SQL
" ============================================================

augroup filetype_sql
    autocmd!

    " インデント
    autocmd FileType sql setlocal smartindent shiftwidth=4 tabstop=4 softtabstop=0

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.sql :%s/\s\+$//ge

    " コメント化・アンコメント化
    autocmd FileType sql xnoremap <buffer> <silent> <C-K> :call ToggleComment('--')<CR>
augroup END


" ============================================================
" C / C++
" ============================================================

augroup filetype_cpp
    autocmd!

    " インデント
    autocmd FileType c,cpp setlocal cindent shiftwidth=4 tabstop=4 softtabstop=0

    " コメント引用
    autocmd FileType text vmap <S-k> :s/\v^(.*)$/> \1/<Enter>::nohlsearch<Enter>

    " アンコメント引用
    autocmd FileType text vmap <S-l> :s/\v^> (.*)$/\1/g<Enter>::nohlsearch<Enter>

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.c,*.cpp,*.h :%s/\s\+$//ge

    " termdebugプラグインを読み込む
    autocmd FileType c,cpp packadd termdebug

    " マウスを有効にする
    autocmd FileType c,cpp setlocal mouse=a

    " ソースファイル全体を整形する
    autocmd FileType c,cpp noremap <buffer> <F7> :%!clang-format --style Microsoft<CR>

    " 選択した行を整形する
    autocmd FileType c,cpp vnoremap <buffer> <F7> :!clang-format --style Microsoft<CR>

    " コメント化・アンコメント化
    autocmd FileType c,cpp xnoremap <buffer> <silent> <C-K> :call ToggleComment('//')<CR>
augroup END


" ============================================================
" Python
" ============================================================

augroup filetype_python
    autocmd!

    " 自動インデント
    autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

    " インデント
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=0 expandtab

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.py :%s/\s\+$//ge

    " ソースファイル全体を整形する with black
    autocmd FileType python noremap <buffer> <F7> :%!black -q -<CR>

    " 選択した範囲を整形する with black
    autocmd FileType python vnoremap <buffer> <F7> :!black -q -<CR>

    " コメント化・アンコメント化
    autocmd FileType python xnoremap <buffer> <silent> <C-K> :call ToggleComment('#')<CR>
augroup END


" ============================================================
" YAML
" ============================================================

augroup filetype_yaml
    autocmd!

    " 自動インデント
    autocmd FileType yaml setlocal smartindent
    autocmd FileType yaml setlocal cinwords={,[,:

    " インデント
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.yaml :%s/\s\+$//ge

augroup END

" ============================================================
" バッチファイル(BAT, CMD)
" ============================================================

function! ToggleBatComment() range
    let all_commented = 1

    for lnum in range(a:firstline, a:lastline)
        if getline(lnum) !~? '^\s*REM\>'
            let all_commented = 0
            break
        endif
    endfor

    if all_commented
        execute a:firstline . ',' . a:lastline
                    \ . 's/^\(\s*\)REM\>\s\?/\1/'
    else
        execute a:firstline . ',' . a:lastline
                    \ . 's/^\(\s*\)/\1REM /'
    endif
endfunction

augroup filetype_bat
    autocmd!

    " 自動インデント
    autocmd FileType dosbatch,bat setlocal smartindent

    " インデント
    autocmd FileType dosbatch,bat setlocal tabstop=2 shiftwidth=2 softtabstop=0

    " コメント化・アンコメント化
    autocmd FileType dosbatch,bat xnoremap <buffer> <silent> <C-K> :call ToggleBatComment()<CR>

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.bat,*.cmd :%s/\s\+$//ge

    " 文字コードを強制する
    autocmd FileType dosbatch,bat setlocal fileencoding=cp932 fileformat=dos
augroup END

" ============================================================
" Windows INIファイル(INI)
" ============================================================

augroup filetype_ini
    autocmd!

    " 自動インデント
    autocmd FileType dosini setlocal smartindent

    " インデント
    autocmd FileType dosini setlocal tabstop=2 shiftwidth=2 softtabstop=0

    " コメント化・アンコメント化
    autocmd FileType dosini xnoremap <buffer> <silent> <C-K> :call ToggleComment(';')<CR>

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.ini :%s/\s\+$//ge

    " 文字コードを強制する
    autocmd FileType dosini setlocal fileencoding=cp932 fileformat=dos
augroup END


" ============================================================
" VB / VBS
" ============================================================

augroup filetype_vb
    autocmd!

    " 自動インデント
    autocmd FileType vb setlocal smartindent

    " インデント
    autocmd FileType vb setlocal tabstop=2 shiftwidth=2 softtabstop=0

    " コメント化・アンコメント化
    autocmd FileType vb xnoremap <buffer> <silent> <C-K> :call ToggleComment("'")<CR>

    " 保存時、行末スペースを削除
    autocmd BufWritePre *.vbs,*.vb :%s/\s\+$//ge
augroup END
