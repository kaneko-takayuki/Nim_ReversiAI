from reversi_core import getPutBoard
from reversi_core import getRevBoard
from game import isEnd

proc evaluate(): int

## NegaScout法で先読みした最大値を求める
## TODO: まだ今の所、NegaMaxになっている
##
## @param me: uint64 自分bit-board
## @param op: uint64 相手bit-board
## @param alpha: uint64 枝刈り用1
## @param beta: uint64 枝刈り用2
## @param depth: 先読みする深さ
##
## result: int 現盤面から先読みした最大値
proc negaScout(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int =
  # 先読み深さが規定値に到達したので評価して返す
  if depth == 0:
    return evaluate()
  
  # 両者が置けない状況になったらゲームは終了なので、石数で評価して返す
  if isEnd(me, op):
    return evaluate()
  
  # 石が置けない時、パスして探索を続ける
  let enablePut = getPutBoard(me, op)
  if enablePut == 0:
    return -negaScout(op, me, -beta, -alpha, depth)
  
  # 探索で使う
  result = -Inf.int              # 先読みした結果、最大の値を返すようにしたい
  var childAlpha: int = alpha

  # 置ける場所について順番にシミュレーション
  for i in 0..63:
    # 置けない場所はスキップ
    if (enablePut and (1'u shl i)) == 0:
      continue
    
    # i番目のポジションに置いて検証
    let 
      pos: uint64 = 1'u shl i
      rev: uint64 = getRevBoard(me, op, pos)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = -negaScout(childOp, childMe, -beta, -childAlpha, depth - 1)

    # 枝刈り
    if beta <= value:
      return value
    
    # α値の更新
    if childAlpha < value:
      childAlpha = value
    
    # 最大値の更新
    if result < value:
      result = value




## TODO: 評価関数はまだ仮
proc evaluate(): int =
  result = 1