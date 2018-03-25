## コマンドラインに盤面の状態を標準出力する
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
##
## result なし
proc display*(black: uint64, white: uint64): void =
  var 
    i_row: string
    tmp_black, tmp_white: uint64

  # 行毎に出力を行う
  for i in 0..<8:
    i_row = "........"
    # 下位8桁にi行目のbit列が入る
    tmp_black = black shr (i * 8)
    tmp_white = white shr (i * 8)

    # i行目のbit列を参照しつつ、黒がいたら'b'、白がいたら'w'を入れる
    for j in 0..<8:
      if ((tmp_black shr j) and 1'u) != 0: i_row[j] = 'b'
      if ((tmp_white shr j) and 1'u) != 0: i_row[j] = 'w'
    
    echo i_row
    