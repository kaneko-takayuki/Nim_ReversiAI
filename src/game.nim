from reversi_core import init_board
from reversi_core import getPutBoard
from reversi_core import putStone
from command_line import display
from command_line import inputPos
from command_line import outputSkip
from command_line import outputEnd

proc skipTurn(black: uint64, white: uint64, blackTurn: bool): bool
proc isEnd(black: uint64, white: uint64): bool

## ゲームを開始する
proc start*(): void =
  var (black, white) = init_board()  # 黒白の盤面の状態
  var blackTurn: bool = true         # 手番(黒ならtrue)

  while true:
    # 盤面の状態を出力
    display(black, white, blackTurn)

    # 両者共置けない時、ゲームを終了
    if isEnd(black, white):
      outputEnd(black, white)
      break
    
    # 手番の人が石が置けない時、ターンを交代してスキップ処理
    if skipTurn(black, white, blackTurn):
      outputSkip(blackTurn)
      blackTurn = not blackTurn
      continue

    # 石を置く場所を標準入力で受け取る
    let (x, y) = inputPos()

    # 石を置く
    let pos_n = (x - 1) + ((y - 1) * 8)
    (black, white) = putStone(black, white, pos_n, blackTurn)

    # ターンを交代する
    blackTurn = not blackTurn


## 手番をスキップするかどうか判定(置ける場所が無い時、手番をスキップする)
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
## @param blackTurn: bool 黒番ならtrue、白番ならfalse
##
## result: bool スキップするならtrue
proc skipTurn(black: uint64, white: uint64, blackTurn: bool): bool =
  if blackTurn:
    result = (getPutBoard(black, white) == 0)
  else:
    result = (getPutBoard(white, black) == 0)

## ゲームが終わるかどうか判定
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
##
## result ゲームが終わる時はtrue
proc isEnd(black: uint64, white: uint64): bool =
  result = (getPutBoard(black, white) == 0) and (getPutBoard(white, black) == 0)
