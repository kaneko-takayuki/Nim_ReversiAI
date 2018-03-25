from reversi_core import init_board
from command_line import display

## ゲームを開始する
proc start*(): void =
  var (black, white) = init_board()  # 黒白の盤面の状態
  var blackTrun: bool = true         # 手番(黒ならtrue)

  display(black, white, blackTrun)

