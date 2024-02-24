" 色テーマを指定する
colorscheme desert

"ウィンドウサイズを指定する
set columns=120
set lines=25

if has("gui_win32")
    set guifont=ＭＳ_ゴシック:h12::cSHIFTJIS:qDRAFT
elseif has("gui_running")
    set guifont="Noto Mono 10"
endif

if has("multi_byte")
    set ambiwidth=double
endif


"IME状態に応じたカーソル色を設定
if has("multi_byte_ime") || has("xim")
    highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
    highlight CursorIM guifg=NONE guibg=#ecbcbc
endif


