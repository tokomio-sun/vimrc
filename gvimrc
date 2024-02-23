" 色テーマを指定する
colorscheme desert

"ウィンドウサイズを指定する
set columns=120
set lines=25

if has("gui_win32")
    set guifont="ＭＳ_ゴシック:h10::cSHIFTJIS"
    set printfont="ＭＳ_ゴシック:h22:cSHIFTJIS"
elseif has("gui_running")
    set guifont="Noto Mono 10"
endif

if has("multi_byte")
    set ambiwidth=double
endif

