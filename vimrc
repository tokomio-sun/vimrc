" setting
"文字コードをUFT-8に設定
set encoding=utf-8
set fenc=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp
set fileformats=unix,dos,mac
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
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
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest

" 折り返し時に表示行単位での移動できるようにする
"nnoremap j gj
"nnoremap k gk

"シンタックスハイライトをオン
syntax on


" Tab系
" 不可視文字を可視化(タブが「?-」と表示される)
set list
set listchars=tab:>-,trail:-,eol:$,extends:≫,precedes:≪,nbsp:%

" Tab文字を半角スペースにする
"set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4
" オートインデント
set autoindent

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

set guifont=Noto\ Mono\ Regular\ 10
set guifontwide=\Noto\ Mono\ Regular\ 10

autocmd FileType c,cpp noremap <C-f> :%!clang-format --style Microsoft<Enter>

" C/CPP コメント化
autocmd FileType c,cpp vmap <C-k> :s/\v^(.+)$/\/\/ \1/<Enter>::nohlsearch<Enter>

" C/CPP アンコメント化
autocmd FileType c,cpp vmap <C-l> :s/\v^\/\/ (.+)$/\1/g<Enter>::nohlsearch<Enter>



