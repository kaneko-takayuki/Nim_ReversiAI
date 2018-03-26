import os
from util.game import gameStart
from util.command_line import inputPosN
from reversi.ai import choosePosN

## メイン関数
when isMainModule:
  let params = os.commandLineParams()

  # ゲームを開始
  gameStart(choosePosN, choosePosN)
