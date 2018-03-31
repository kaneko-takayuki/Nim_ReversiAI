import os
import parseopt2
from util.game import gameStart
from util.command_line import inputPosN
from reversi.ai import choosePosN
from constants.config import CAPACITY_TEST_FILE
from util.file_io import writeHeaders

## メイン関数
when isMainModule:
  var
    blackInput: proc(black: uint64, white: uint64, blackTurn: bool, turn: int): int = choosePosN  # 黒用入力関数
    whiteInput: proc(black: uint64, white: uint64, blackTurn: bool, turn: int): int = choosePosN  # 白用入力関数
  
  # プログラム引数をパース
  for kind, key, val in getopt():
    case kind
    of cmdLongOption:
      if key == "black" and val == "person": blackInput = inputPosN
      if key == "black" and val == "ai": blackInput = choosePosN
      if key == "white" and val == "person": whiteInput = inputPosN
      if key == "white" and val == "ai": whiteInput = choosePosN
    of cmdShortOption:
      if key == "b" and val == "person": blackInput = inputPosN
      if key == "b" and val == "ai": blackInput = choosePosN
      if key == "w" and val == "person": whiteInput = inputPosN
      if key == "w" and val == "ai": whiteInput = choosePosN
    of cmdArgument, cmdEnd:
      discard

  # ヘッダをファイルに出力
  writeHeaders(CAPACITY_TEST_FILE, "turn", "nodeN", "leafN", "nodeN+leafN", "time", "nps")

  # ゲームを開始
  gameStart(blackInput, whiteInput)
