from reversi_core import init_board
from reversi_core import getPutBoard
from reversi_core import putStone
from command_line import display
from command_line import inputPos

## ゲームを開始する
proc start*(): void =
  var (black, white) = init_board()  # 黒白の盤面の状態
  var blackTurn: bool = true         # 手番(黒ならtrue)

  while true:
    # 盤面の状態を出力
    display(black, white, blackTurn)

    # 両者共置けない時、ゲームを終了
    if isEnd:
      

    # 石を置く座標を入力
    let (x, y) = inputPos()

    # 何番に石を置くか
    let pos_n = (x - 1) + ((y - 1) * 8)

    # 実際に石を置く
    (black, white) = putStone(black, white, pos_n, blackTurn)

    # ターンを交代する
    blackTurn = not blackTurn


## ゲームが終わるかどうかの判定
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
##
## result ゲームが終わる時はtrue
proc isEnd(black: uint64, white: uint64): bool =
  result = (getPutBoard(black, white) == 0) and (getPutBoard(white, black) == 0)
