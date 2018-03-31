import times
import dto.searchResult
from core import getPutBoard, getRevBoard, count
from util.game import isEnd
from evaluate import evaluateWithStoneN
from constants.aiConfig import AI_INF, DEPTH
from constants.config import CAPACITY_TEST_FILE
from util.file_io import write
import algorithm

type
  ChildNode = tuple[childEnablePutN: int, childMe: uint64, childOp: uint64, posN: int]

var nodeN: int = 0
var leafN: int = 0

proc firstestFirst(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int

#[
  *概要
    - 終盤探索、全て読み切る
  *パラメータ
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
    - blackTurn<bool>: 黒番ならtrue
  *返り値<int>:
    - コンピュータが選択したマス番号
]#
proc finalSearch*(me: uint64, op: uint64, turn: int): int =
  nodeN = 0
  leafN = 0

  let
    depth = 60 - turn
    enablePut = getPutBoard(me, op)
    start_time = cpuTime()

  # 速さ優先探索を行うための配列
  var
    childNodes: seq[ChildNode] = @[]

  # 置ける場所について順番にシミュレーション
  for posN in 0..63:
    let pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いて検証
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      childEnablePutN: int = count(getPutBoard(op, me))
    
    # 次の状態を追加(次のノードの情報なので、自分と相手が逆になる)
    childNodes.add((childEnablePutN: childEnablePutN, childMe: childOp, childOp: childMe, posN: posN))

  # 相手の置ける数(childEnablePutN)で昇順ソート
  childNodes.sort(proc (x,y:ChildNode) : int = cmp(x.childEnablePutN, y.childEnablePutN))

  # 探索で使う
  result = Inf.int  # 先読みした結果、評価の最大値とその時の手を返す
  var 
    childAlpha: int = -AI_INF
    maxPosN: int = -1

  # 相手の置ける数が少ない順(速さ優先)探索
  for node in childNodes:
    let value: int = -firstestFirst(node.childMe, node.childOp, -AI_INF, -childAlpha, depth)
    
    # α値(最大値)の更新
    if childAlpha < value:
      childAlpha = value
      maxPosN = node.posN
      
  let end_time = cpuTime()
  write(CAPACITY_TEST_FILE, turn, nodeN, leafN, end_time - start_time)

  result = maxPosN


#[
  *概要
    - 速さ優先探索で手筋を読み切る
  *パラメータ
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
    - alpha<int>: 枝刈り用1
    - beta<int>:  枝刈り用2
    - depth<int>: 先読みする深さ
]#
proc firstestFirst(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int =
  # 両者が置けない状況になったらゲームは終了なので、石数で評価して返す(葉)
  if depth == 0 or isEnd(me, op):
    inc(leafN)
    return evaluateWithStoneN(me, op)

  # --- 以下、ノード ---
  inc(nodeN)

  # 石が置けない時、パスして探索を続ける
  let enablePut = getPutBoard(me, op)
  if enablePut == 0:
    return -firstestFirst(op, me, -beta, -alpha, depth)

  # 速さ優先探索を行うための配列
  var
    childNodes: seq[ChildNode] = @[]

  # 置ける場所について順番にシミュレーション
  for posN in 0..63:
    let pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いて検証
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      childEnablePutN: int = count(getPutBoard(op, me))
    
    # 次の状態を追加(次のノードの情報なので、自分と相手が逆になる)
    childNodes.add((childEnablePutN: childEnablePutN, childMe: childOp, childOp: childMe, posN: posN))

  # 相手の置ける数(childEnablePutN)で昇順ソート
  childNodes.sort(proc (x,y:ChildNode) : int = cmp(x.childEnablePutN, y.childEnablePutN))

  # 探索で使う変数
  result = Inf.int
  var childAlpha: int = alpha

  # 相手の置ける数が少ない順(速さ優先)探索
  for node in childNodes:
    let value: int = -firstestFirst(node.childMe, node.childOp, -beta, -childAlpha, depth - 1)

    # 枝刈り
    if beta <= value:
      return value
    
    # α値の更新
    if childAlpha < value:
      childAlpha = value
    
    # 最大値の更新
    if result < value:
      result = value