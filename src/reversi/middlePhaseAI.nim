import times
import dto.searchResult
from core import getPutBoard, getRevBoard
from util.game import isEnd
from evaluate import evaluateWithPosition, evaluateWithPutN
from constants.aiConfig import AI_INF, DEPTH
from util.file_io import write
from constants.config import CAPACITY_TEST_FILE

proc evaluate(me: uint64, op: uint64): int
proc negaScout(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int

var 
  nodeN: int = 0
  leafN: int = 0


#[
  *概要:
    - 中盤探索
  *パラメータ:
    - me<uint64>:   自分のbit-board
    - op<uint64>:   相手のbit-board
    - blackTurn<bool>: 黒番ならtrue
  *返り値<int>:
    - コンピュータが選択したマス番号
]#
proc middleSearch*(me: uint64, op: uint64, turn: int): int =
  nodeN = 0
  leafN = 0
  let
    enablePut = getPutBoard(me, op)
    start_time = cpuTime()
  
  # 探索で使う
  result = Inf.int  # 先読みした結果、評価の最大値とその時の手を返す
  var 
    childAlpha: int = -AI_INF
    maxPosN: int = -1

  # 置ける場所について順番にシミュレーション
  for posN in 0..63:
    let pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # i番目のポジションに置いて検証
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = -negaScout(childOp, childMe, -AI_INF, -childAlpha, DEPTH - 1)
    
    # α値(最大値0の更新
    if childAlpha < value:
      childAlpha = value
      maxPosN = posN

  let end_time = cpuTime()
  write(CAPACITY_TEST_FILE, turn, nodeN, leafN, end_time - start_time)
   
  result = maxPosN


#[
  *概要:
    - NegaScout法で先読みし、次の手を決める
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
    - alpha<int>: 枝刈り用1
    - beta<int>:  枝刈り用2
    - depth<int>: 先読みする深さ
  *返り値<int>:
    - 探索した結果
    - 先読みした結果の最大評価値(value)、最適な手(posN)の2つのフィールドがある
]#
proc negaScout(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int =
  # 先読み深さが規定値に到達したので評価して返す(葉)
  if depth == 0:
    inc(leafN)
    return evaluate(me, op)
  
  # 両者が置けない状況になったらゲームは終了なので、石数で評価して返す(葉)
  if isEnd(me, op):
    inc(leafN)
    return evaluate(me, op)
  
  # --- 以下、ノード ---
  inc(nodeN)
  
  # 石が置けない時、パスして探索を続ける
  let enablePut = getPutBoard(me, op)
  if enablePut == 0:
    return -negaScout(op, me, -beta, -alpha, depth)
  
  # 探索で使う
  result = Inf.int  # 先読みした結果、評価の最大値とその時の手を返す
  var childAlpha: int = alpha

  # 置ける場所について順番にシミュレーション
  for posN in 0..63:
    let pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # i番目のポジションに置いて検証
    let
      rev: uint64 = getRevBoard(me, op, posN)
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
#[
  *概要:
    - 盤面の評価値を計算
]#
proc evaluate(me: uint64, op: uint64): int =
  result = evaluateWithPosition(me, op) + 10 * evaluateWithPutN(me, op)