from reversi_core import init_board
from command_line import display
from command_line import inputPos

## ゲームを開始する
proc start*(): void =
  var (black, white) = init_board()  # 黒白の盤面の状態
  var blackTrun: bool = true         # 手番(黒ならtrue)

  while true:
    # 盤面の状態を出力
    display(black, white, blackTrun)

    # 石を置く座標を入力
    let (x, y) = inputPos()