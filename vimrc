" Vim Setting

set encoding=utf-8
scriptencoding utf-8


if has ('unix')
  set fileencodings=ucs-bom,utf-8,cp932,utf-16le,euc-jp,iso-2022-jp
  set fileformats=unix,dos,mac
else
  set fileencodings=ucs-bom,utf-8,cp932,utf-16le,euc-jp,iso-2022-jp
  set fileformats=dos,unix,mac
endif

" vi互換にしない
if &compatible
  set nocompatible
endif

" バックアップファイルを作成しない
set nobackup
" バックアップファイルの出力先
"set backupdir=.

"スワップファイルを作成する
set swapfile

"60秒毎に保存
set updatetime=60000

" カレントディレクトリを開いているファイルのディレクトリに移動させる
set autochdir

" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" カーソルの位置情報を表示
"set ruler

" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ビープ音を可視化
set visualbell
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest

" 全角幅で表示する
if has("multi_byte")
    set ambiwidth=double
endif

" 折り返ししない
set nowrap

" Tab系
" 不可視文字を可視化(タブが「?-」と表示される)
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" カーソル系
set whichwrap=b,s,[,],<,>

" バックスペースを、空白、行末、行頭でも使えるようにする
set backspace=indent,eol,start

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" ペーストモードの切り替え$
set pastetoggle=<F2>

" ヤンク／プット時にクリップボードを使用する
set clipboard+=unnamed

" コマンドライン補完
set wildmenu

set statusline=%F
set statusline+=%m
set statusline+=%r
set statusline+=%=
set statusline+=[%l/%L]
set statusline+=[%c]
set statusline+=[%{(&fenc!=''?&fenc:$enc).':'.&ff}]

set background=dark

" ファイル拡張子別 キーボードショートカット
filetype on
filetype plugin indent on

" Filetypeが決まらない場合はtextにする"
function! s:NoneFileTypeSet()
  if len(&filetype) == 0
    set filetype=text
  endif
  if len(&fileencoding) == 0
    if has ('unix')
      set fileencoding=utf-8
    else
      set fileencoding=cp932
    endif
  endif
endfunction
autocmd BufEnter * call s:NoneFileTypeSet()

"[text] -----------------------------------------
augroup text
  autocmd!
  " 引用コメント化
  autocmd FileType text vmap <S-k> :s/\v^(.*)$/> \1/<Enter>::nohlsearch<Enter>

  " 引用アンコメント化
  autocmd FileType text vmap <S-l> :s/\v^> (.*)$/\1/g<Enter>::nohlsearch<Enter>
  autocmd FileType text inoremap { {}<LEFT>
  autocmd FileType text inoremap [ []<LEFT>
  autocmd FileType text inoremap ( ()<LEFT>
  autocmd FileType text inoremap " ""<LEFT>
  autocmd FileType text inoremap ' ''<LEFT>
  autocmd FileType text inoremap < <><LEFT>

  " TAB文字を見た目上何文字で表示するか
  autocmd FileType text setlocal tabstop=4

  " 自動インデントでのインデントの長さ
  autocmd FileType text setlocal shiftwidth=4

  " TABキー押下時に挿入するスペースの数
  " (設定'tabstop'に合わせる)
  autocmd FileType text setlocal softtabstop=0
augroup END

"[vim] -----------------------------------------
augroup vimfile
  autocmd!
  autocmd FileType vim setlocal smartindent shiftwidth=2 tabstop=2 softtabstop=0

  "保存時、行末スペースを削除する
  autocmd BufWritePre *.vimrc,*.gvimrc :%s/\s\+$//ge

  " コメント化
  autocmd FileType vim vmap <S-k> :s/\v^(.*)$/" \1/<Enter>::nohlsearch<Enter>

  " アンコメント化
  autocmd FileType vim vmap <S-l> :s/\v^" (.*)$/\1/g<Enter>::nohlsearch<Enter>
  autocmd FileType vim inoremap { {}<LEFT>
  autocmd FileType vim inoremap [ []<LEFT>
  autocmd FileType vim inoremap ( ()<LEFT>
  autocmd FileType vim inoremap " ""<LEFT>
  autocmd FileType vim inoremap ' ''<LEFT>

  "TAB文字をスペースにする
  autocmd FileType vim setlocal expandtab

  "構文ハイライトを有効にする
  autocmd FileType vim syntax on

  " 括弧入力時の対応する括弧を表示
  set showmatch
  set matchtime=1

augroup END
"-----------------------------------------
"[SQL] -----------------------------------------
augroup sqlfile
  autocmd!
  autocmd FileType sql setlocal smartindent shiftwidth=4 tabstop=4 softtabstop=0

  "保存時、行末スペースを削除する
  autocmd BufWritePre *.sql :%s/\s\+$//ge

  " コメント化
  autocmd FileType sql vmap <S-k> :s/\v^(.*)$/-- \1/<Enter>::nohlsearch<Enter>

  " アンコメント化
  autocmd FileType sql vmap <S-l> :s/\v^-- (.*)$/\1/g<Enter>::nohlsearch<Enter>
  autocmd FileType sql inoremap { {}<LEFT>
  autocmd FileType sql inoremap [ []<LEFT>
  autocmd FileType sql inoremap ( ()<LEFT>
  autocmd FileType sql inoremap " ""<LEFT>
  autocmd FileType sql inoremap ' ''<LEFT>

  "構文ハイライトを有効にする
  autocmd FileType sql syntax on

  " 括弧入力時の対応する括弧を表示
  set showmatch
  set matchtime=1

augroup END
"-----------------------------------------

"[C/C++] -----------------------------------------
augroup cppfile
  autocmd!
  autocmd FileType c,cpp setlocal cindent shiftwidth=4 tabstop=4 softtabstop=0

  "保存時、行末スペースを削除する
  autocmd BufWritePre *.c,*.cpp,*.h :%s/\s\+$//ge

  " termdebugプラグインを読み込む
  autocmd FileType c,cpp packadd termdebug
  autocmd FileType c,cpp setlocal mouse=a

  "[ノーマルモード]
  "ソースファイル全体を整形する with clang-format
  autocmd FileType c,cpp noremap <C-f> :%!clang-format --style Microsoft<Enter>

  "[ビジュアルモード]
  "選択した行を整形する with clang-format
  autocmd FileType c,cpp noremap <C-f> :%!clang-format --style Microsoft<Enter>

  " コメント化
  autocmd FileType c,cpp vmap <S-k> :s/\v^(.*)$/\/\/ \1/<Enter>::nohlsearch<Enter>

  " アンコメント化
  autocmd FileType c,cpp vmap <S-l> :s/\v^\/\/ (.*)$/\1/g<Enter>::nohlsearch<Enter>
  autocmd FileType c,cpp inoremap { {}<LEFT>
  autocmd FileType c,cpp inoremap [ []<LEFT>
  autocmd FileType c,cpp inoremap ( ()<LEFT>
  autocmd FileType c,cpp inoremap " ""<LEFT>
  autocmd FileType c,cpp inoremap ' ''<LEFT>

  "構文ハイライトを有効にする
  autocmd FileType c,cpp syntax on
  " 括弧入力時の対応する括弧を表示
  set showmatch
  set matchtime=1

augroup END
"-----------------------------------------

"[Python] -----------------------------------------
augroup pythonfile
  autocmd!
  autocmd FileType python setlocal smartindent
  autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=0

  "TAB文字をスペースにする
  autocmd FileType python setlocal expandtab

  "保存時、行末スペースを削除する
  autocmd BufWritePre *.py :%s/\s\+$//ge

  "[ノーマルモード]
  "ソースファイル全体を整形する with black (pip install black)
  autocmd FileType python noremap <C-f> :%!black -q -<Enter>

  "[ビジュアルモード]
  "選択した行を整形する
  autocmd FileType python vmap <S-f> :%!black -q -<Enter>

  " コメント化
  autocmd FileType python vmap <S-k> :s/\v^(.+)$/# \1/<Enter>::nohlsearch<Enter>

  " アンコメント化
  autocmd FileType python vmap <S-l> :s/\v^\# (.+)$/\1/g<Enter>::nohlsearch<Enter>
  autocmd FileType python inoremap { {}<LEFT>
  autocmd FileType python inoremap [ []<LEFT>
  autocmd FileType python inoremap ( ()<LEFT>
  autocmd FileType python inoremap " ""<LEFT>
  autocmd FileType python inoremap ' ''<LEFT>

  "構文ハイライトを有効にする
  autocmd FileType python syntax on
  " 括弧入力時の対応する括弧を表示
  set showmatch
  set matchtime=1

augroup END
"-----------------------------------------

"[YAML] -----------------------------------------
augroup yamlfile
  autocmd!
  autocmd FileType yaml setlocal smartindent
  autocmd FileType yaml setlocal cinwords={,[,:
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=0

  autocmd FileType yaml inoremap { {}<LEFT>
  autocmd FileType yaml inoremap [ []<LEFT>
  autocmd FileType yaml inoremap ( ()<LEFT>
  autocmd FileType yaml inoremap " ""<LEFT>
  autocmd FileType yaml inoremap ' ''<LEFT>

  "TAB文字をスペースにする
  autocmd FileType yaml setlocal expandtab

  "保存時、行末スペースを削除する
  autocmd BufWritePre *.yaml :%s/\s\+$//ge

  " 括弧入力時の対応する括弧を表示
  set showmatch
  set matchtime=1

augroup END
"-----------------------------------------

"[VBS/VB] -----------------------------------------
augroup vbfile
  autocmd!
  autocmd FileType vb setlocal smartindent
  autocmd FileType vb setlocal tabstop=2 shiftwidth=2 softtabstop=0

  " コメント化
  autocmd FileType vb vmap <S-k> :s/\v^(.+)$/' \1/<Enter>::nohlsearch<Enter>

  " アンコメント化
  autocmd FileType vb vmap <S-l> :s/\v^\' (.+)$/\1/g<Enter>::nohlsearch<Enter>
  autocmd FileType vb inoremap { {}<LEFT>
  autocmd FileType vb inoremap [ []<LEFT>
  autocmd FileType vb inoremap ( ()<LEFT>
  autocmd FileType vb inoremap " ""<LEFT>
  autocmd FileType vb inoremap ' ''<LEFT>

  "保存時、行末スペースを削除する
  autocmd BufWritePre *.vbs,*.vb :%s/\s\+$//ge

  "構文ハイライトを有効にする
  autocmd FileType vb syntax on

  " 括弧入力時の対応する括弧を表示
  set showmatch
  set matchtime=1

augroup END
"-----------------------------------------
