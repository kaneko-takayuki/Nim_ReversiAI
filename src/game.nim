from reversi_core import init_board
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

    # 石を置く座標を入力
    let (x, y) = inputPos()

    # 何番に石を置くか
    let pos_n = (x - 1) + ((y - 1) * 8)

    # 実際に石を置く
    (black, white) = putStone(black, white, pos_n, blackTurn)

    # ターンを交代する
    blackTurn = not blackTurn
