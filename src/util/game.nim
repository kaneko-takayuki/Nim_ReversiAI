from reversi.core import init_board
from reversi.core import getPutBoard
from reversi.core import putStone
from command_line import display
from command_line import inputPosN
from command_line import outputSkip
from command_line import outputEnd
import strformat

proc enablePut*(black: uint64, white: uint64, blackTurn: bool, posN: int): bool
proc skipTurn(black: uint64, white: uint64, blackTurn: bool): bool
proc isEnd*(black: uint64, white: uint64): bool

#[
  *概要:
    - ゲームを開始
]#
proc gameStart*(blackInput: proc(black: uint64, white: uint64, blackTurn: bool): int, 
                whiteInput: proc(black: uint64, white: uint64, blackTurn: bool): int): void {. procvar .} =
  var (black, white) = init_board()  # 黒白の盤面の状態
  var blackTurn: bool = true         # 手番(黒ならtrue)

  while true:
    # 盤面の状態を出力
    display(black, white, blackTurn)

    # 両者共置けない時、ゲームを終了
    if isEnd(black, white):
      outputEnd(black, white)
      break
    
    # 手番の人が石が置けない時、ターンを交代してスキップ処理
    if skipTurn(black, white, blackTurn):
      outputSkip(blackTurn)
      blackTurn = not blackTurn
      continue

    # 有効な場所が入力されるまで、石を置く場所を標準入力で受け取る
    var posN: int
    while true:
      # 黒番か白番かで入力関数が変わる(Player用とか、AI用とか)
      if blackTurn:
        posN = blackInput(black, white, blackTurn)
      else:
        posN = whiteInput(black, white, blackTurn)

      echo fmt"posN: {posN}"

      if enablePut(black, white, blackTurn, posN):
        break
      echo "【!入力された場所は有効ではありません!】"

    # 石を置く
    (black, white) = putStone(black, white, posN, blackTurn)

    # ターンを交代する
    blackTurn = not blackTurn


#[
  *概要:
    - マス番号{posN}に石が置けるか判定
  *パラメータ:
    - black<uint64>:   黒bit-board
    - white<uint64>:   白bit-board
    - blackTurn<bool>: 黒番ならtrue
    - posN<int>:      石を置くマス番号
  *返り値<bool>:
    - 石が置ければtrue、そうでなければfalse
]#
proc enablePut*(black: uint64, white: uint64, blackTurn: bool, posN: int): bool =
  let pos: uint64 = (1'u shl posN)
  if blackTurn:
    result = ((getPutBoard(black, white) and pos) != 0)
  else:
    result = ((getPutBoard(white, black) and pos) != 0)


#[
  *概要:
    - 手番のスキップ判定
  *パラメータ:
    - black<uint64>:   黒bit-board
    - white<uint64>:   白bit-board
    - blackTurn<bool>: 黒番ならtrue
  *返り値<bool>:
    - 置ける場所が無くてスキップするならtrue
]#
proc skipTurn(black: uint64, white: uint64, blackTurn: bool): bool =
  if blackTurn:
    result = (getPutBoard(black, white) == 0)
  else:
    result = (getPutBoard(white, black) == 0)


#[
  *概要:
    - ゲームの終了判定
  *パラメータ:
    - black<uint64>: 黒bit-board
    - white<uint64>: 白bit-board
  *返り値<bool>:
    - どちらも置けず、ゲームが終了する時はtrue、それ以外はfalse
]#
proc isEnd*(black: uint64, white: uint64): bool =
  result = (getPutBoard(black, white) == 0) and (getPutBoard(white, black) == 0)
