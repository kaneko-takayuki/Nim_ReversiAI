import strformat
from reversi.core import getPutBoard
from reversi.core import count

proc convert_input(c: char): int


#[
  *概要:
    - 盤面状態を標準出力
  *パラメータ:
    - black<uint64>:   黒bit-board
    - white<uint64>:   白bit-board
    - blackTurn<bool>: 黒番ならtrue
  *返り値<void>:
    - なし
]#
proc display*(black: uint64, white: uint64, blackTurn: bool): void =
  var 
    i_row: string
    putBoard, tmpBlack, tmpWhite, tmpPutBoard: uint64

  # 着手可能位置を求める
  if blackTurn:
    putBoard = getPutBoard(black, white)
  else:
    putBoard = getPutBoard(white, black)

  # ヘッダを出力
  echo " |A|B|C|D|E|F|G|H|"
  echo "- - - - - - - - - "
  # 行毎に出力を行う
  for i in 0..<8:
    i_row = fmt"{i+1}| | | | | | | | |"
    # 下位8桁にi行目のbit列が入る
    tmpBlack = black shr (i * 8)
    tmpWhite = white shr (i * 8)
    tmpPutBoard = putBoard shr (i * 8)

    # i行目のbit列を参照しつつ、黒がいたら'b'、白がいたら'w'を入れる
    for j in 0..<8:
      if ((tmpBlack shr j) and 1'u) != 0: i_row[j * 2 + 2] = 'b'  # 黒が置かれている
      if ((tmpWhite shr j) and 1'u) != 0: i_row[j * 2 + 2] = 'w'  # 白が置かれている
      if ((tmpputBoard shr j) and 1'u) != 0: i_row[j * 2 + 2] = '.'  # 着手可能
    
    echo i_row
    echo "- - - - - - - - - "


#[
  *概要:
    - 置く場所を標準入力で受け付ける
  *パラメータ:
    - 
  *返り値<int>:
    - 入力されたマス番号を返す
]#
proc inputPosN*(black: uint64, white: uint64, blackTurn: bool): int =
  echo "入力: "
  let line: string = readLine(stdin)
  let x: int = convert_input(line[0])
  let y: int = convert_input(line[1])
  result = ((y - 1) * 8) + (x - 1)


#[
  *概要:
    - 標準出力でスキップした旨を表示
  *パラメータ:
    - blackTurn<bool>: 黒番ならtrue
  *返り値<void>:
    - なし
]#
proc outputSkip*(blackTurn: bool): void =
  if blackTurn:
    echo "【黒番がスキップされました】"
  else:
    echo "【白番がスキップされました】"


#[
  *概要:
    - 標準出力でゲーム結果を表示
  *パラメータ:
    - black<uint64>: 黒bit-board
    - white<uint64>: 白bit-board
  *返り値<void>:
    - なし
]#
proc outputEnd*(black: uint64, white: uint64): void =
  # 黒、白それぞれの石数をカウント
  let
    black_n: int = count(black)
    white_n: int = count(white)

  # 結果を出力
  echo fmt"【{black_n} - {white_n}】"
  if black_n > white_n:
    echo "黒の勝ち!!"
  elif black_n < white_n:
    echo "白の勝ち!!"
  else:
    echo "引き分け!!"


#[
  *概要:
    - 入力された座標を変換
  *パラメータ:
    - c<char>: 変換元も文字
  *返り値<int>:
    - 変換後の数値
    - 例
      - 'A' -> 1
      - 'f' -> 6
      - '8' -> 8
]#
proc convert_input(c: char): int =
  case c
  of 'A', 'a', '1':
    result = 1
  of 'B', 'b', '2':
    result = 2
  of 'C', 'c', '3':
    result = 3
  of 'D', 'd', '4':
    result = 4
  of 'E', 'e', '5':
    result = 5
  of 'F', 'f', '6':
    result = 6
  of 'G', 'g', '7':
    result = 7
  of 'H', 'h', '8':
    result = 8
  else:
    discard