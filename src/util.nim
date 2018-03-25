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



