import os
from reversi_core import init_board
from command_line import display

## メイン関数
when isMainModule:
  let params = os.commandLineParams()
  var (black, white) = init_board()
  display(black, white)
