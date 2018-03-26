#[
  *概要:
    - 先読み探索を行なった結果のオブジェクト型
]#
type
  SearchResult* = ref object of RootObj
    value*: int  # 手の最大値
    posN*: int   # 評価が最大になる手

proc `-`* (x: SearchResult): SearchResult =
  result = SearchResult(value: -x.value, posN: x.posN)

proc `<`* (x: SearchResult, y: SearchResult): bool =
  result = x.value < y.value