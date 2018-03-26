import strformat
from reversi.core import getPutBoard
from reversi.core import count

proc convert_input(c: char): int

## コマンドラインに盤面の状態を標準出力する
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
## @param blackTurn: bool 黒のターンならtrue
##
## result なし
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
    i_row = fmt"{i+1}|.|.|.|.|.|.|.|.|"
    # 下位8桁にi行目のbit列が入る
    tmpBlack = black shr (i * 8)
    tmpWhite = white shr (i * 8)
    tmpPutBoard = putBoard shr (i * 8)

    # i行目のbit列を参照しつつ、黒がいたら'b'、白がいたら'w'を入れる
    for j in 0..<8:
      if ((tmpBlack shr j) and 1'u) != 0: i_row[j * 2 + 2] = 'b'  # 黒が置かれている
      if ((tmpWhite shr j) and 1'u) != 0: i_row[j * 2 + 2] = 'w'  # 白が置かれている
      if ((tmpputBoard shr j) and 1'u) != 0: i_row[j * 2 + 2] = '#'  # 着手可能
    
    echo i_row
    echo "- - - - - - - - - "

## コマンドラインから入力を受け付ける
##
## result tuple(x座標, y座標)
proc inputPos*(): tuple[x: int, y: int] =
  echo "入力: "
  let line: string = readLine(stdin)
  let x: int = convert_input(line[0])
  let y: int = convert_input(line[1])
  result = (x: x, y: y)


## スキップした旨を標準出力で表示
##
## @param blackTurn: bool 黒番ならtrue
proc outputSkip*(blackTurn: bool): void =
  if blackTurn:
    echo "【黒番がスキップされました】"
  else:
    echo "【白番がスキップされました】"

## ゲームの結果を標準出力で表示
##
## @param black: uint64 黒bit-board
## @param white: uint64 白bit-board
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


## 入力の座標を変換
##
## @param c: char x座標かy座標
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