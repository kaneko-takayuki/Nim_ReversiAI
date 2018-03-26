from reversi.core import init_board
from reversi.core import getPutBoard
from reversi.core import putStone
from command_line import display
from command_line import inputPos
from command_line import outputSkip
from command_line import outputEnd

proc enablePut*(black: uint64, white: uint64, blackTurn: bool, pos_n: int): bool
proc skipTurn(black: uint64, white: uint64, blackTurn: bool): bool
proc isEnd*(black: uint64, white: uint64): bool

## ゲームを開始する
proc gameStart*(): void =
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

    # 有効な場所が入力されるまで、石を置く場所を標準入力で受け取る
    var x, y, pos_n: int
    while true:
      (x, y) = inputPos()
      pos_n = (x - 1) + ((y - 1) * 8)
      if enablePut(black, white, blackTurn, pos_n):
        break
      echo "【!入力された場所は有効ではありません!】"

    # 石を置く
    (black, white) = putStone(black, white, pos_n, blackTurn)

    # ターンを交代する
    blackTurn = not blackTurn


## posに石が置けるかどうか判定
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
## @param blackTurn: bool 黒番ならtrue
## @param pos: uint64 石を置くbit-board
##
## result: bool 石が置けるならtrue
proc enablePut*(black: uint64, white: uint64, blackTurn: bool, pos_n: int): bool =
  let pos: uint64 = (1'u shl pos_n)
  if blackTurn:
    result = ((getPutBoard(black, white) and pos) != 0)
  else:
    result = ((getPutBoard(white, black) and pos) != 0)


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
proc isEnd*(black: uint64, white: uint64): bool =
  result = (getPutBoard(black, white) == 0) and (getPutBoard(white, black) == 0)
