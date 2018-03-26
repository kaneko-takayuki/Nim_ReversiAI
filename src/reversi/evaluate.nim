# 石の場所による重み付け
const VALUE_TABLE*: array[0..63, int] = [ 30, -12,   0,  -1,  -1,   0, -12,  30,
                                         -12, -20,  -3,  -3,  -3,  -3, -20, -12,
                                           0,  -3,   0,  -1,  -1,   0,  -3,   0,
                                          -1,  -3,  -1,  -1,  -1,  -1,  -3,  -1,
                                          -1,  -3,  -1,  -1,  -1,  -1,  -3,  -1,
                                           0,  -3,   0,  -1,  -1,   0,  -3,   0,
                                         -12, -20,  -3,  -3,  -3,  -3, -20, -12,
                                          30, -12,   0,  -1,  -1,   0, -12,  30]

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