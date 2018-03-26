import dto.searchResult
from core import getPutBoard
from core import getRevBoard
from util.game import isEnd

proc evaluate(): int


#[
  *概要:
    - NegaScout法で先読みし、次の手を決める
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
    - alpha<int>: 枝刈り用1
    - beta<int>:  枝刈り用2
    - depth<int>: 先読みする深さ
  *返り値<SearchResult>:
    - 探索した結果
    - 先読みした結果の最大評価値(value)、最適な手(pos)の2つのフィールドがある
]#
proc negaScout(me: uint64, op: uint64, alpha: int, beta: int, depth: int): SearchResult =
  # 先読み深さが規定値に到達したので評価して返す
  if depth == 0:
    return SearchResult(value: evaluate(), pos: -1)
  
  # 両者が置けない状況になったらゲームは終了なので、石数で評価して返す
  if isEnd(me, op):
    return SearchResult(value: evaluate(), pos: -1)
  
  # 石が置けない時、パスして探索を続ける
  let enablePut = getPutBoard(me, op)
  if enablePut == 0:
    return -negaScout(op, me, -beta, -alpha, depth)
  
  # 探索で使う
  result = SearchResult(value: Inf.int, pos: -1)  # 先読みした結果、評価の最大値とその時の手を返す
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
      childResult: SearchResult = -negaScout(childOp, childMe, -beta, -childAlpha, depth - 1)

    # 枝刈り
    if beta <= childResult.value:
      return childResult
    
    # α値の更新
    if childAlpha < childResult.value:
      childAlpha = childResult.value
    
    # 最大値の更新
    if result < childResult:
      result = childResult


## TODO: 評価関数はまだ仮
#[
  *概要:
    - 盤面の評価値を計算
]#
proc evaluate(): int =
  result = 1