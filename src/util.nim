## 石数のカウント
##
## @param x: uint64 bit-board
##
## result 石の数
proc count*(x: uint64): int =
  var t: uint64 = (x and 0x5555_5555_5555_5555'u) + ((x shr 1) and 0x5555_5555_5555_5555'u)  # 2bit単位
  t = (t and 0x3333_3333_3333_3333'u) + ((t shr 2) and 0x3333_3333_3333_3333'u)              # 4bit単位
  t = (t and 0x0F0F_0F0F_0F0F_0F0F'u) + ((t shr 4) and 0x0F0F_0F0F_0F0F_0F0F'u)              # 8bit単位
  t = (t and 0x00FF_00FF_00FF_00FF'u) + ((t shr 8) and 0x00FF_00FF_00FF_00FF'u)              # 16bit単位
  t = (t and 0x0000_FFFF_0000_FFFF'u) + ((t shr 16) and 0x0000_FFFF_0000_FFFF'u)             # 32bit単位
  t = (t and 0x0000_0000_FFFF_FFFF'u) + ((t shr 32) and 0x0000_0000_FFFF_FFFF'u)             # 64bit単位
  result = t.int


## 着手bit-boardを求める
##
## @param me: uint64 自分(着手する側)のbit-board
## @param op: uint64 相手(opposer)のbitboard
##
## result 着手bit-board(着手できる位置が立っているbit-board)
proc getPutBoard*(me: uint64, op: uint64): uint64 =
  result = 0                          # 着手可能bit-board
  let blank: uint64 = not (me or op)  # 空白bit-board
  var masked_op, tmp: uint64          # 計算に使う
  
  
  # 左右
  masked_op = op and 0x7e7e_7e7e_7e7e_7e7e'u  # 「左右0、それ以外1」でマスク掛け
  # 右方向に返せる位置を探す
  tmp = masked_op and (me shl 1)             # 自分の石があり、そこから連続して相手の石があるbit-boardを求める
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shl 1))
  result = result or (blank and (tmp shl 1))  # tmpの左側が空白なら、そこに着手可能
  
  # 左方向
  tmp = masked_op and (me shr 1)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shr 1))
  result = result or (blank and (tmp shr 1))
  
  
  # 上下
  masked_op = op and 0x7e7e_7e7e_7e7e_7e7e'u  # 「左右0、それ以外1」でマスク掛け
  # 上方向
  tmp = masked_op and (me shl 8)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shl 8))
  result = result or (blank and (tmp shl 8))
  
  # 下方向
  tmp = masked_op and (me shr 8)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shr 8))
  result = result or (blank and (tmp shr 8))
  
  
  # 斜め
  masked_op = op and 0x007e_7e7e_7e7e_7e00'u  # 「左右上下0、それ以外1」でマスク掛け
  # 右上方向
  tmp = masked_op and (me shl 7)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shl 7))
  result = result or (blank and (tmp shl 7))

  # 左上方向
  tmp = masked_op and (me shl 9)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shl 9))
  result = result or (blank and (tmp shl 9))

  # 右下方向
  tmp = masked_op and (me shr 9)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shr 9))
  result = result or (blank and (tmp shr 9))

  # 左下方向
  tmp = masked_op and (me shr 7)
  for _ in 0..<5:
    tmp = tmp or (masked_op and (tmp shr 7))
  result = result or (blank and (tmp shr 7))

