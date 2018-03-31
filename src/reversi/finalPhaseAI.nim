import times
import strutils
import dto.searchResult
from core import getPutBoard, getRevBoard, count, hashBoard
from util.game import isEnd
from evaluate import evaluateWithStoneN
from constants.aiConfig import AI_INF, DEPTH, FINAL_OPT, FULL_SEARCH, FINAL
from constants.config import CAPACITY_TEST_FILE
from util.file_io import write
import algorithm, critbits

# 探索に使用する変数
var 
  nodeN: int = 0
  leafN: int = 0
  transPositionTable: CritBitTree[int]   # 置換表
  blankTable: array[60 - FINAL, int]       # 空所表

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
    blank = not (me or op)
  
  # 空所表を作成する
  var n: int = 0
  for posN in 0..63:
    let pos: uint64 = 1'u shl posN
    if (blank and pos) != 0:
      blankTable[n] = posN
      inc(n)

  # 速さ優先探索を行うための配列
  n = 0  # childNodesの要素数
  var
    childNodes: array[20, int] = [AI_INF, AI_INF, AI_INF, AI_INF, AI_INF,
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF,
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF, 
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF]
    childMes: array[63, uint64]
    childOps: array[63, uint64]

  # -----------------------------
  # 事前探索(効率の良い探索順を求める)
  # -----------------------------

  # 置ける場所について順番にシミュレーション
  for posN in blankTable:
    let pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いてシミュレーション
    # 自分がposNに置いた後、相手の置ける数を計算する
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = count(getPutBoard(op, me))
    
    # 下6桁はposNの情報、それ以上は評価値情報(置ける石の数の差)
    # posNをインデックスとして、次の盤面の状態を保持しておく(後で使う)
    childNodes[n] = (value shl 6) + posN
    childMes[posN] = childMe
    childOps[posN] = childOp
    inc(n)

  # 「相手の置ける数」で昇順ソート -> 分岐数が少なくなる
  childNodes.sort(system.cmp[int])

  # -----------------------------
  # 本探索(実際に最後まで読み切っていく)
  # -----------------------------
  result = Inf.int  # 評価が最大になる手
  var childAlpha: int = -AI_INF

  # 相手の置ける数が少ない順(速さ優先)探索
  for i in 0..<n:
    let
      node: int = childNodes[i]
      posN: int = node and 0b11_1111  # 下6桁がposN
      value: int = -firstestFirst(childOps[posN], childMes[posN], -AI_INF, -childAlpha, depth)
    
    # α値(最大値)の更新
    if childAlpha < value:
      childAlpha = value
      result = posN
      
  let end_time = cpuTime()
  write(CAPACITY_TEST_FILE, turn, nodeN, leafN, end_time - start_time)


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

  # -----------------------------
  # 以下、ノード(葉ならここまで到達しない)
  # -----------------------------
  inc(nodeN)
  result = -Inf.int

  # 石が置けない時、パスして探索を続ける
  let enablePut = getPutBoard(me, op)
  if enablePut == 0:
    return -firstestFirst(op, me, -beta, -alpha, depth)
  
  # -----------------------------
  # 最終n手最適化(再帰しないで処理)
  # -----------------------------
  if depth <= FINAL_OPT:
    for posN in blankTable:
      let pos: uint64 = 1'u shl posN
      # 置けない場所はスキップ
      if (enablePut and pos) == 0:
        continue
      
      # 置いてシミュレーション
      let
        rev: uint64 = getRevBoard(me, op, posN)
        childMe: uint64 = me xor (pos or rev)
        childOp: uint64 = op xor rev
        value: int = evaluateWithStoneN(childOp, childMe)

      if result < value:
        result = value
      
    return result


  # -----------------------------
  # 残り深さが一定未満の時、全探索した方が速い
  # -----------------------------
  if depth <= FULL_SEARCH:
    for posN in blankTable:
      let pos: uint64 = 1'u shl posN
      # 置けない場所はスキップ
      if (enablePut and pos) == 0:
        continue
      
      # 置いてシミュレーション
      let
        rev: uint64 = getRevBoard(me, op, posN)
        childMe: uint64 = me xor (pos or rev)
        childOp: uint64 = op xor rev
        value: int = -firstestFirst(childOp, childMe, -beta, -alpha, depth - 1)
      
      # 枝刈り
      if beta <= value:
        return value

      if result < value:
        result = value
      
    return result

  # -----------------------------
  # 置換表による探索
  # -----------------------------
  let hash: string = hashBoard(me, op)
  if transPositionTable.contains(hash):
    return transPositionTable[hash]

  # -----------------------------
  # 事前探索(効率の良い探索順を求める)
  # -----------------------------
  # 速さ優先探索を行うための配列
  var
    n: int = 0  # childNodesの要素数
    childNodes: array[20, int] = [AI_INF, AI_INF, AI_INF, AI_INF, AI_INF,
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF,
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF, 
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF]
    childMes: array[63, uint64]
    childOps: array[63, uint64]

  # 置ける場所について順番にシミュレーション
  for posN in blankTable:
    let pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いて検証
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = count(getPutBoard(op, me))
    
    # 下6桁はposNの情報、それ以上は評価値情報(置ける石の数の差)
    # posNをインデックスとして、次の盤面の状態を保持しておく(後で使う)
    childNodes[n] = (value shl 6) + posN
    childMes[posN] = childMe
    childOps[posN] = childOp
    inc(n)

  # 相手の置ける数で昇順ソート
  childNodes.sort(system.cmp[int])

  # -----------------------------
  # 本探索(実際に最後まで読み切っていく)
  # -----------------------------

  # 探索で使う変数
  var childAlpha: int = alpha

  # 相手の置ける数が少ない順(速さ優先)探索
  for i in 0..<n:
    let
      node: int = childNodes[i]
      posN: int = node and 0b11_1111  # 下6桁がposN
      value: int = -firstestFirst(childOps[posN], childMes[posN], -beta, -childAlpha, depth - 1)

    # 枝刈り
    if beta <= value:
      return value
    
    # α値の更新
    if childAlpha < value:
      childAlpha = value
    
    # 最大値の更新
    if result < value:
      result = value

  transPositionTable[hash] = result