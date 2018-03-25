from reversi_core import getPutBoard

## コマンドラインに盤面の状態を標準出力する
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
## @param blackTurn: bool 黒のターンならtrue
##
## result なし
proc display*(black: uint64, white: uint64, blackTurn: bool): void =
  var 
    i_row: string
    putBoard, tmpBlack, tmpWhite, tmpPutBoard: uint64

  # 着手可能位置を求める
  if blackTurn:
    putBoard = getPutBoard(black, white)
  else:
    putBoard = getPutBoard(white, black)

  # 行毎に出力を行う
  for i in 0..<8:
    i_row = "........"
    # 下位8桁にi行目のbit列が入る
    tmpBlack = black shr (i * 8)
    tmpWhite = white shr (i * 8)
    tmpPutBoard = putBoard shr (i * 8)

    # i行目のbit列を参照しつつ、黒がいたら'b'、白がいたら'w'を入れる
    for j in 0..<8:
      if ((tmpBlack shr j) and 1'u) != 0: i_row[j] = 'b'  # 黒が置かれている
      if ((tmpWhite shr j) and 1'u) != 0: i_row[j] = 'w'  # 白が置かれている
      if ((tmpputBoard shr j) and 1'u) != 0: i_row[j] = '#'  # 着手可能
    
    echo i_row
