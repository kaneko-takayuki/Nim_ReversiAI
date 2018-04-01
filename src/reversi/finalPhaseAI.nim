import times
import strformat
import strutils
import algorithm
from core import getPutBoard, getRevBoard, count
from evaluate import evaluateWithStoneN
from constants.config import CAPACITY_TEST_FILE
from constants.aiConfig import AI_INF, DEPTH, FULL_SEARCH, FINAL, TRANSPOSITION_N
from util.game import isEnd
from util.file_io import write

proc fastestFirst(me: uint64, op: uint64, alpha: int, beta: int, depth: int): int

# 探索に使用する変数
var 
  nodeN: int = 0           # 探索したノードの数(検証用)
  leafN: int = 0           # 探索した葉の数(検証用)
  collisionN: int          # 衝突回数(検証用)
  sumCollisionN*: int = 0  # 合計衝突回数(検証用)
  sumTime*: float = 0      # 探索の合計時間(検証用)
  transPositionTableMask: uint64 = (TRANSPOSITION_N - 1)
  transPositionExistTable: array[TRANSPOSITION_N, bool]  # keyに対応する置換情報が存在するか
  transPositionLowerTable: array[TRANSPOSITION_N, int]   # 置換表(lower)
  transPositionUpperTable: array[TRANSPOSITION_N, int]   # 置換表(upper)
  transPositionMe: array[TRANSPOSITION_N, uint64]        # ハッシュ衝突時、meを確認してmeも同じなら同一盤面と見なす
  transPositionOp: array[TRANSPOSITION_N, uint64]        # ハッシュ衝突時、opを確認してopも同じなら同一盤面と見なす
  blankN: int = 0            # 空所の数
  blankPosN: array[60, int]  # 空所表

#[
  *概要:
    - ハッシュ関数
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
  *返り値<uint64>:
    - 盤面のハッシュ値
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
  result = (meHash1 + meHash2 + meHash3 + mehash4 + opHash1 + opHash2 + opHash3 + opHash4) and transPositionTableMask


#[
  *概要:
    - 置換表を初期化する
  *パラメータ:
    - なし
  *返り値<void>:
    - なし
]#
proc initTransPositionTable*(): void =
  for i in 0'u64..<TRANSPOSITION_N:
    transPositionExistTable[i] = false
    transPositionLowerTable[i] = -AI_INF
    transPositionUpperTable[i] = AI_INF
    transPositionMe[i] = 0
    transPositionOp[i] = 0


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
  if isEnd(me, op):
    inc(leafN)
    return evaluateWithStoneN(me, op)

  # -----------------------------
  # 以下、ノードとして扱う
  # -----------------------------
  inc(nodeN)
  result = -Inf.int                    # 探索結果
  let enablePut = getPutBoard(me, op)  # 着手可能位置

  # -----------------------------
  # 2. 石が置けない場合、そのまま交代
  # -----------------------------
  if enablePut == 0:
    return -fastestFirst(op, me, -beta, -alpha, depth)

  # -----------------------------
  # 3. 最終1手最適化(再帰しないで処理)
  # -----------------------------
  if depth <= 1:
    for i in 0..<blankN:
      # 位置の計算
      let
        posN: int = blankPosN[i]
        pos: uint64 = 1'u shl posN
      # 置けない場所はスキップ
      if (enablePut and pos) == 0:
        continue
      
      # 反転処理をシミュレーション
      let
        rev: uint64 = getRevBoard(me, op, posN)
        childMe: uint64 = me xor (pos or rev)
        childOp: uint64 = op xor rev
      
      # 再帰関数を呼ばないで、この場で評価して即返す
      return evaluateWithStoneN(childOp, childMe)

  # -----------------------------
  # 4. 残り深さが一定未満の時、全探索した方が速いらしい
  # -----------------------------
  if depth <= FULL_SEARCH:
    for i in 0..<blankN:
      # 位置の計算
      let
        posN: int = blankPosN[i]
        pos: uint64 = 1'u shl posN
      # 置けない場所はスキップ
      if (enablePut and pos) == 0:
        continue
      
      # 反転処理をシミュレーションし、子ノードを読みに行く
      let
        rev: uint64 = getRevBoard(me, op, posN)
        childMe: uint64 = me xor (pos or rev)
        childOp: uint64 = op xor rev
        value: int = -fastestFirst(childOp, childMe, -beta, -alpha, depth - 1)
      
      # 枝刈り
      if beta <= value:
        return value

      # 評価値の更新
      if result < value:
        result = value
      
    return result

  # -----------------------------
  # 以下、深さFULL_SEARCHより大きいノードの処理
  # -----------------------------

  # -----------------------------
  # 5. 置換表による重複盤面の探索
  # -----------------------------
  var lower, upper: int
  let tableKey = hash(me, op)  # 現在の盤面のハッシュ値

  # 盤面ハッシュ値と自分のボードが同じものは同一と見なす
  if transPositionExistTable[tableKey] and transPositionMe[tableKey] == me and transPositionOp[tableKey] == op:
    lower = transPositionLowerTable[tableKey]  # この盤面の下限値
    upper = transPositionUpperTable[tableKey]  # この盤面の上限値

    # 盤面評価値が少なくともβ以上なので、この盤面は選ばれない(枝刈り)
    if lower >= beta:
      return lower
    # 盤面評価値が少なくともα以上なので、この盤面も選ばれない(枝刈り)
    if upper <= alpha:
      return upper
    # 下限値と上限値が同じということは、この盤面の真の評価値が確定しているということ
    if lower == upper:
      return lower
  else:
    # この盤面のハッシュ値に該当するデータが無かったか、ハッシュが衝突した
    # -> 置換表を上書きする
    transPositionExistTable[tableKey] = true
    transPositionMe[tableKey] = me
    transPositionOp[tableKey] = op
    lower = -AI_INF
    upper = AI_INF
    transPositionLowerTable[tableKey] = lower
    transPositionUpperTable[tableKey] = upper

  # -----------------------------
  # 6. 事前探索(効率の良い探索順を求める)
  # -----------------------------
  # childNodesの要素の値は、「下6桁に置くマス番号情報(posN)、それより上には浅い探索の評価値情報(次番に置けるマス数)が入る」
  # 実際に値を代入する時は、childNodes[i] = ({浅い探索の評価値} shl 6) + posN となる
  # これを単純に数値として昇順ソートすると、自動的に浅い探索結果が先頭に来る
  # わざわざこうする理由は"速いから"。(タプルや構造体は重い)
  # NOTE: 制約としては、AI_INFを超えるような値を入れてはいけない
  var
    childN: int = 0  # childNodesの要素数
    childNodes: array[20, int] = [AI_INF, AI_INF, AI_INF, AI_INF, AI_INF,
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF,
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF, 
                                  AI_INF, AI_INF, AI_INF, AI_INF, AI_INF]
    childMes: array[63, uint64]  # posNに対応した次盤面の自分の状態のメモ
    childOps: array[63, uint64]  # posNに対応した次盤面の自分の状態のメモ

  # 置ける場所について順番にシミュレーション
  for i in 0..<blankN:
    # 位置の計算
    let
      posN: int = blankPosN[i]
      pos: uint64 = 1'u shl posN
    # 置けない場所はスキップ
    if (enablePut and pos) == 0:
      continue
    
    # posN番目のポジションに置いて検証
    # 評価値は、次相手が置ける場所の数とする
    let
      rev: uint64 = getRevBoard(me, op, posN)
      childMe: uint64 = me xor (pos or rev)
      childOp: uint64 = op xor rev
      value: int = count(getPutBoard(childOp, childMe))
    
    # 下6桁はposNの情報、それ以上は評価値情報(置ける石の数の差)
    # *** 制約としては、AI_INFを超えるような値を入れてはいけない ***
    childNodes[childN] = (value shl 6) + posN
    childMes[posN] = childMe  # posNにおいた時の次の自分盤面の状態をメモ
    childOps[posN] = childOp  # posNにおいた時の次の相手盤面の状態をメモ
    inc(childN)

  # 相手の置ける数で昇順ソート
  childNodes.sort(system.cmp[int])

  # -----------------------------
  # 7. 本探索(実際にノードを展開する)
  # -----------------------------

  # 探索で使う変数
  var childAlpha: int = alpha

  # -----------------------------
  # 7.1. 最も良いと思われる手を通常窓で読み、resultに格納
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
  # 7.2. 2番手以降はNull Window Searchを挟んで探索を行う
  # -----------------------------
  # 事前の浅い探索の結果から、置ける場所数がchildN個ということが分かっているので、
  # ソート済みchildNodesについて、1〜(childN-1)まで見れば良い
  for i in 1..<childN:
    let
      node: int = childNodes[i]
      posN: int = node and 0b11_1111  # 下6桁がposN
      nullWindowValue: int = -fastestFirst(childOps[posN], childMes[posN], -childAlpha-1, -childAlpha, depth - 1)

    # fail-high
    # つまり、beta <= nullWindowValue <= {探索先の真の値}
    # 探索先の真の値は、少なくともβより大きいので枝刈り
    if beta <= nullWindowValue:
      result = nullWindowValue
      break

    # fail-low
    # つまり、{探索先の真の値} <= nullWindowValue <= childAlpha
    # 探索先の真の値は、少なくともchild-αより小さく、この手が選ばれることはない
    # -> 決して選ばれることのない手と分かったので、通常窓で探索する必要が無い
    if nullWindowValue <= childAlpha:
      if result < nullWindowValue:
        result = nullWindowValue
      continue
    
    # -----------------------------
    # 7.3. 通常窓探索(盤面の真の評価値を求める)
    # -----------------------------
    
    # 7.2の探索の結果、「childAlpha < nullWindowVallue」が保証されている
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

  # -----------------------------
  # 8. 置換表の更新
  # -----------------------------
  if result <= alpha:
    transPositionUpperTable[tableKey] = result
  elif result >= beta:
    transPositionLowerTable[tableKey] = result
  else:
    transPositionUpperTable[tableKey] = result
    transPositionLowerTable[tableKey] = result