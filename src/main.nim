import os
from game import start

## メイン関数
when isMainModule:
  let params = os.commandLineParams()

  # ゲームを開始
  start()
