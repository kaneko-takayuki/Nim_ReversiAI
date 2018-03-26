#[
  *概要:
    - 先読み探索を行なった結果のオブジェクト型
]#
type
  SearchResult* = ref object of RootObj
    value*: int     # 手の最大値
    lastPosN*: int  # 評価が最大になるマス番号

proc `-`* (x: SearchResult): SearchResult =
  result = SearchResult(value: -x.value, lastPosN: x.lastPosN)

proc `<`* (x: SearchResult, y: SearchResult): bool =
  result = x.value < y.value