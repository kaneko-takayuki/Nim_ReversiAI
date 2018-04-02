import os
import strutils
import strformat
import parseopt2
from reversi.ai import choosePosN
from reversi.finalPhaseAI import sumCollisionN, initTransPositionTable, sumTime
from constants.config import CAPACITY_TEST_FILE
from constants.aiConfig import TRANSPOSITION_N, benchmarkTestFlag
from util.game import gameStart
from util.command_line import inputPosN, outputFinalSearchResult
from util.file_io import writeHeaders
from constants.aiConfig import TRANSPOSITION_N
from reversi.finalPhaseAI import sumNodeN, sumLeafN, sumTime, sumCollisionN

## メイン関数
when isMainModule:
  var
    blackInput: proc(black: uint64, white: uint64, blackTurn: bool, turn: int): int = choosePosN  # 黒用入力関数
    whiteInput: proc(black: uint64, white: uint64, blackTurn: bool, turn: int): int = choosePosN  # 白用入力関数
    initBenchmarkFFO: int = -1
  
  # プログラム引数をパース
  for kind, key, val in getopt():
    case kind
    of cmdLongOption:
      if key == "black" and val == "person": blackInput = inputPosN
      if key == "black" and val == "ai": blackInput = choosePosN
      if key == "white" and val == "person": whiteInput = inputPosN
      if key == "white" and val == "ai": whiteInput = choosePosN
      if key == "benchmark":
        initBenchmarkFFO = ($val).parseInt
        benchmarktestFlag = true
    of cmdShortOption:
      if key == "b" and val == "person": blackInput = inputPosN
      if key == "b" and val == "ai": blackInput = choosePosN
      if key == "w" and val == "person": whiteInput = inputPosN
      if key == "w" and val == "ai": whiteInput = choosePosN
      if key == "t": initBenchmarkFFO = ($val).parseInt
    of cmdArgument, cmdEnd:
      discard

  # ヘッダをファイルに出力
  writeHeaders(CAPACITY_TEST_FILE, "turn", "nodeN", "leafN", "nodeN+leafN", "time", "nps", "value")

  # 置換表を初期化
  initTransPositionTable()

  # ゲームを開始
  gameStart(blackInput, whiteInput, initBenchmarkFFO)

  outputFinalSearchResult(sumNodeN, sumLeafN, sumTime, TRANSPOSITION_N, sumCollisionN)