import os
from util.game import gameStart

## メイン関数
when isMainModule:
  let params = os.commandLineParams()

  # ゲームを開始
  gameStart()
