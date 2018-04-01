from reversi.middlePhaseAI import middleSearch
from reversi.finalPhaseAI import finalSearch
from constants.aiConfig import FINAL, benchmarkTestFlag

#[
  *概要:
    - コンピュータの指す手を選択する
  *パラメータ:
    - black<uint64>: 黒bit-board
    - white<uint64>: 白bit-board
    - blackTurn<bool>: 黒番ならtrue
    - turn<int>: 現在のターン数
  *返り値<int>:
    - コンピュータが指すマス番号
]#
proc choosePosN*(black: uint64, white: uint64, blackTurn: bool, turn: int): int =
  let
    me: uint64 = if blackTurn: black else: white
    op: uint64 = if blackTurn: white else: black

  if (not benchmarkTestFlag) and turn < FINAL:
    result = middleSearch(me, op, turn)
  else:
    result = finalSearch(me, op, turn)