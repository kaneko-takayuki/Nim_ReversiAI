import strformat

proc debugBoard*(title: string, board: uint64): void =
  var 
    i_row: string
    tmp: uint64

  echo "================"
  echo fmt"={title}="
  echo "================"

  # ヘッダを出力
  echo " |A|B|C|D|E|F|G|H|"
  echo "- - - - - - - - - "
  # 行毎に出力を行う
  for i in 0..<8:
    i_row = fmt"{i+1}| | | | | | | | |"
    # 下位8桁にi行目のbit列が入る
    tmp = board shr (i * 8)

    # i行目のbit列を参照しつつ、黒がいたら'b'、白がいたら'w'を入れる
    for j in 0..<8:
      if ((tmp shr j) and 1'u) != 0: i_row[j * 2 + 2] = '*'  # 黒が置かれている
    
    echo i_row
    echo "- - - - - - - - - "
    echo ""