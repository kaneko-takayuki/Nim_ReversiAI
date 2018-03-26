import os
from util.game import gameStart
from util.command_line import inputPosN

## メイン関数
when isMainModule:
  let params = os.commandLineParams()

  # ゲームを開始
  gameStart(inputPosN, inputPosN)
