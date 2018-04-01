import times
import strformat
import strutils
import dto.searchResult
from core import getPutBoard, getRevBoard, count
from util.game import isEnd
from evaluate import evaluateWithStoneN
from constants.aiConfig import AI_INF, DEPTH, FULL_SEARCH, FINAL
from constants.config import CAPACITY_TEST_FILE
from util.file_io import write
import algorithm, critbits

const TRANSPOSITION_N*: uint64 = 0x100_0000'u64  # 置換表のサイズ

# 探索に使用する変数
var 
  nodeN: int = 0
  leafN: int = 0
  transPositionExistTable: array[TRANSPOSITION_N, bool]  # keyに対応する置換情報が存在するか
  transPositionLowerTable: array[TRANSPOSITION_N, int]   # 置換表(lower)
  transPositionUpperTable: array[TRANSPOSITION_N, int]   # 置換表(upper)
  transPositionMe: array[TRANSPOSITION_N, uint64]  # ハッシュ衝突時、Meを確認してMeも同じなら同一盤面と見なす
  collisionN: int # 衝突回数
  sumCollisionN*: int = 0
  sumTime*: float = 0
  blankN: int = 0
  blankPosN: array[60 - FINAL, int]     # 空所表

#[
  *概要:
    - ハッシュ関数
]#
proc hash(me: uint64, op: uint64): uint64 =
  let
    meHash1 = (me and 0x0000_0000_0000_ffff'u) * 17
    meHash2 = ((me and 0x0000_0000_ffff_0000'u) shr 16) * 289
    meHash3 = ((me and 0x0000_ffff_0000_0000'u) shr 32) * 4913
    mehash4 = ((me and 0xffff_0000_0000_0000'u) shr 48) * 83521
    opHash1 = (op and 0x0000_0000_0000_ffff'u) * 19
    opHash2 = ((op and 0x0000_0000_ffff_0000'u) shr 16) * 361
    opHash3 = ((op and 0x0000_ffff_0000_0000'u) shr 32) * 6859
    ophash4 = ((op and 0xffff_0000_0000_0000'u) shr 48) * 130321
  result = (meHash1 + meHash2 + meHash3 + mehash4 + opHash1 + opHash2 + opHash3 + opHash4) and 0xff_ffff

proc initTransPositionTable*(): void =
  for i in 0'u64..<TRANSPOSITION_N:
    transPositionExistTable[i] = false
    transPositionLowerTable[i] = -AI_INF
    transPositionUpperTable[i] = AI_INF
    transPositionMe[i] = 0

proc fastestFirst(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int

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
  blankN = 0
  collisionN = 0

  let
    start_time = cpuTime()
    depth = 60 - turn
    enablePut = getPutBoard(me, op)
    blank = not (me or op)
  
  # 空所表を作成する
  for posN in 0..63:
    let pos: uint64 = 1'u shl posN
    if (blank and pos) != 0:
      blankPosN[blankN] = posN
      inc(blankN)

  # 速さ優先探索を行うための配列
  var
    childN: int = 0
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
  for i in 0..<blankN:
    let
      posN: int = blankPosN[i]
      pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いてシミュレーション
    # 自分がposNに置いた後、相手の置ける数を計算する
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = count(getPutBoard(childOp, childMe))
    
    # 下6桁はposNの情報、それ以上は評価値情報(置ける石の数の差)
    # posNをインデックスとして、次の盤面の状態を保持しておく(後で使う)
    childNodes[childN] = (value shl 6) + posN
    childMes[posN] = childMe
    childOps[posN] = childOp
    inc(childN)

  # 「相手の置ける数」で昇順ソート -> 分岐数が少なくなる
  childNodes.sort(system.cmp[int])

  # -----------------------------
  # 本探索(実際に最後まで読み切っていく)
  # -----------------------------
  result = Inf.int  # 評価が最大になる手
  var maxValue: int = -AI_INF

  # 相手の置ける数が少ない順(速さ優先)探索
  for i in 0..<childN:
    let
      node: int = childNodes[i]
      posN: int = node and 0b11_1111  # 下6桁がposN
      value: int = -fastestFirst(childOps[posN], childMes[posN], -AI_INF, -maxValue, depth)
    echo posN

    # α値(最大値)の更新
    if maxValue < value:
      maxValue = value
      result = posN
      
  let end_time = cpuTime()
  write(CAPACITY_TEST_FILE, turn, nodeN, leafN, end_time - start_time, maxValue)
  
  # ハッシュ計測用
  sumCollisionN = sumCollisionN + collisionN
  sumTime = sumTime + (end_time - start_time)


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
proc fastestFirst(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int =
  # -----------------------------
  # 1. 両者が置けない状況になったらゲームは終了なので、石数で評価して返す(葉)
  # -----------------------------
  if depth == 0 or isEnd(me, op):
    inc(leafN)
    return evaluateWithStoneN(me, op)

  # INFO: 以下、葉ではない
  inc(nodeN)

  # -----------------------------
  # 2. 自分は石が置けない場合、そのまま交代
  # -----------------------------
  let enablePut = getPutBoard(me, op)
  if enablePut == 0:
    return -fastestFirst(op, me, -beta, -alpha, depth)

  result = -Inf.int

  # -----------------------------
  # 最終1手最適化(再帰しないで処理)
  # -----------------------------
  if depth <= 1:
    for i in 0..<blankN:
      let
        posN: int = blankPosN[i]
        pos: uint64 = 1'u shl posN
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
  # 3. 残り深さが一定未満の時、全探索した方が速い
  # -----------------------------
  if depth <= FULL_SEARCH:
    for i in 0..<blankN:
      let
        posN: int = blankPosN[i]
        pos: uint64 = 1'u shl posN
      # 置けない場所はスキップ
      if (enablePut and pos) == 0:
        continue
      
      # 置いてシミュレーション
      let
        rev: uint64 = getRevBoard(me, op, posN)
        childMe: uint64 = me xor (pos or rev)
        childOp: uint64 = op xor rev
        value: int = -fastestFirst(childOp, childMe, -beta, -alpha, depth - 1)
      
      # 枝刈り
      if beta <= value:
        return value

      if result < value:
        result = value
      
    return result

  # -----------------------------
  # 置換表
  # -----------------------------
  var lower, upper: int
  let tableKey = hash(me, op)

  # tableKey: uint64 = (me * op) and 0x0fff_ffff_ffff_ffff'u64
  if transPositionExistTable[tableKey] and transPositionMe[tableKey] == me:
    lower = transPositionLowerTable[tableKey]
    upper = transPositionUpperTable[tableKey]
    if lower >= beta:
      return lower
    if upper <= alpha:
      return upper
    if lower == upper:
      return lower
  else:
    transPositionExistTable[tableKey] = true
    transPositionMe[tableKey] = me
    lower = -AI_INF
    upper = AI_INF

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
  for i in 0..<blankN:
    let
      posN: int = blankPosN[i]
      pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いて検証
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = count(getPutBoard(childOp, childMe))
    
    # 下6桁はposNの情報、それ以上は評価値情報(置ける石の数の差)
    # 
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

  # -----------------------------
  # 1. 最も良いと思われる手について通常窓で読む
  # -----------------------------
  let
    probablyBestNode: int = childNodes[0]
    probablyBestPosN: int = probablyBestNode and 0b11_1111  # 下6桁がposN
  result = -fastestFirst(childOps[probablyBestPosN], childMes[probablyBestPosN], -beta, -childAlpha, depth - 1)
  
  # 枝刈り
  if beta <= result:
    return result
  
  # α値の更新
  if childAlpha < result:
    childAlpha = result

  # -----------------------------
  # 2. 2番手以降はNull Window Searchを挟んで探索を行う
  # -----------------------------
  # 相手の置ける数が少ない順(速さ優先)探索
  for i in 1..<n:
    # -----------------------------
    # 3. Null Window Search
    # -----------------------------
    let
      node: int = childNodes[i]
      posN: int = node and 0b11_1111  # 下6桁がposN
      nullWindowValue: int = -fastestFirst(childOps[posN], childMes[posN], -childAlpha-1, -childAlpha, depth - 1)

    # 枝刈り
    if beta <= nullWindowValue:
      result = nullWindowValue
      break

    # Null Window Searchを行なった結果、α値よりも小さい
    #   -> fail-lowが起きていて、実際のminmax値はこれより小さい
    if childAlpha >= nullWindowValue:
      if nullWindowValue > result:
        result = nullWindowValue
      continue
    
    # -----------------------------
    # 4. 通常窓探索
    #    (Null Window Searchの結果、fail-highが起きたので、より良いminmax値を求める)
    # -----------------------------
    
    # α値の更新
    childAlpha = nullWindowValue

    # 通常窓で探索
    let value: int = -fastestFirst(childOps[posN], childMes[posN], -beta, -childAlpha, depth - 1)

    # 枝刈り
    if beta <= value:
      result = value
      break
    
    # α値の更新
    if childAlpha < value:
      childAlpha = value
    
    # 最大値の更新
    if result < value:
      result = value

  # 置換表の更新
  if result <= alpha:
    transPositionUpperTable[tableKey] = result
  elif result >= beta:
    transPositionLowerTable[tableKey] = result
  else:
    transPositionUpperTable[tableKey] = result
    transPositionLowerTable[tableKey] = result