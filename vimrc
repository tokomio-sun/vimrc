" setting
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,utf-16le,iso-2022-jp,euc-jp
set fileformats=unix,dos,mac


" バックアップファイルを作らない
set nobackup
" バックアップファイルの出力先
"set backupdir=.

" スワップファイルを作らない
set noswapfile
" スワップファイルの出力先
"set directory=.


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
set ruler

" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest

" 全角幅で表示する
if has("multi_byte")
    set ambiwidth=double
endif

" 折り返し時に表示行単位での移動できるようにする
"nnoremap j gj
"nnoremap k gk

"シンタックスハイライトをオン
syntax on

" Tab系
" 不可視文字を可視化(タブが「?-」と表示される)
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%


" TAB文字を見た目上何文字で表示するか
set tabstop=4

" 自動インデントでのインデントの長さ
set shiftwidth=4

" TABキー押下時に挿入するスペースの数
" (設定'tabstop'に合わせる)
set softtabstop=0


" 
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

hi Comment ctermfg=DarkGreen

" ファイル拡張子別 キーボードショートカット
filetype on

"[other] -----------------------------------------
"[ビジュアルモード]
" 引用化
autocmd FileType * vmap <S-k> :s/\v^(.+)$/> \1/<Enter>::nohlsearch<Enter>

" 引用外し
autocmd FileType * vmap <S-l> :s/\v^\> (.+)$/\1/g<Enter>::nohlsearch<Enter>


"[C/C++] -----------------------------------------
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
autocmd FileType c,cpp vmap <S-k> :s/\v^(.+)$/\/\/ \1/<Enter>::nohlsearch<Enter>

" アンコメント化
autocmd FileType c,cpp vmap <S-l> :s/\v^\/\/ (.+)$/\1/g<Enter>::nohlsearch<Enter>

"-----------------------------------------

"[Python] -----------------------------------------
autocmd FileType python setlocal smartindent
autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=0

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

"-----------------------------------------

