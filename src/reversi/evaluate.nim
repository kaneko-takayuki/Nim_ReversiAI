from constants.aiConfig import VALUE_TABLE
from reversi.core import getPutBoard, count

#[
  *概要:
    - 石の配置による評価を行う
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
  *返り値<int>:
    - 石の配置による評価値
]#
proc evaluateWithPosition*(me: uint64, op: uint64): int =
  # それぞれのマスについて見る
  var score: int = 0
  for i in 0..63:
    score += ((VALUE_TABLE[i] * ((me shr i) and 1'u).int) - (VALUE_TABLE[i] * ((op shr i) and 1'u).int))

  result = score


#[
  *概要:
    - 置ける数による評価を行う
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
  *返り値<int>:
    - 置ける数の差
]#
proc evaluateWithPutN*(me: uint64, op: uint64): int =
  # お互いの置ける位置
  let
    mePutBoard: uint64 = getPutBoard(me, op)
    opPutBoard: uint64 = getPutBoard(op, me)

  # {自分の置ける数} - {相手の置ける数}
  var score: int = 0
  for i in 0..63:
    score += (((mePutBoard shr i) and 1'u) - ((opPutBoard shr i) and 1'u)).int
  
  result = score

#[
  *概要:
    - 石の数による単純評価
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
  *返り値<int>:
    - 石の数の差
]#
proc evaluateWithStoneN*(me: uint64, op: uint64): int =
  result = count(me) - count(op)
