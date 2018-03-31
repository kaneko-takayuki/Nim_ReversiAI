import times
import dto.searchResult
from core import getPutBoard, getRevBoard
from util.game import isEnd
from evaluate import evaluateWithPosition, evaluateWithPutN
from constants.aiConfig import AI_INF, DEPTH
from util.file_io import write

var nodeN: int = 0

#[
  *概要
    - 終盤ソルバー、残りの手筋を読み切る
  *パラメータ
    - black<uint64>: 黒bit-board
    - white<uint64>: 白bit-board
    - blackTurn<bool>: 黒番ならtrue
  *返り値<int>:
    - コンピュータが選択したマス番号
]#
proc finalSolvePosN(black: uint64, op: uint64, blackTurn: bool): int =
  result = 0

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
  var candidate: seq[tuple[posN: int, canPutN: int]]

  

