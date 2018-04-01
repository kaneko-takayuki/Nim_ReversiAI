from util.debug import debugBoard

## bit-boardの初期化
proc init_board*(): tuple[black: uint64, white: uint64] =
  const b: uint64 = (1 shl 28) or (1 shl 35)
  const w: uint64 = (1 shl 27) or (1 shl 36)
  const init_board: tuple[black: uint64, white: uint64] = (b, w)
  result = init_board


#[
  *概要:
    - 石数をカウント
  *パラメータ:
    - x<uint64>: カウントするbit-board
  *返り値<int>:
    - 石数
]#
proc count*(x: uint64): int =
  var t: uint64 = (x and 0x5555_5555_5555_5555'u) + ((x shr 1) and 0x5555_5555_5555_5555'u)  # 2bit単位
  t = (t and 0x3333_3333_3333_3333'u) + ((t shr 2) and 0x3333_3333_3333_3333'u)              # 4bit単位
  t = (t and 0x0f0f_0f0f_0f0f_0f0f'u) + ((t shr 4) and 0x0f0f_0f0f_0f0f_0f0f'u)              # 8bit単位
  t = (t and 0x00ff_00ff_00ff_00ff'u) + ((t shr 8) and 0x00ff_00ff_00ff_00ff'u)              # 16bit単位
  t = (t and 0x0000_ffff_0000_ffff'u) + ((t shr 16) and 0x0000_ffff_0000_ffff'u)             # 32bit単位
  t = (t and 0x0000_0000_ffff_ffff'u) + ((t shr 32) and 0x0000_0000_ffff_ffff'u)             # 64bit単位
  result = t.int


#[
  *概要:
    - 着手bit-boardを求める(着手できる位置が1のbit-board)
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
  *返り値<uint64>:
    - 着手bit-board
]#
proc getPutBoard*(me: uint64, op: uint64): uint64 =
  result = 0                          # 着手可能bit-board
  let blank: uint64 = not (me or op)  # 空白bit-board
  var masked_op, tmp: uint64          # 計算に使う
  
  # 左右
  masked_op = op and 0x7e7e_7e7e_7e7e_7e7e'u  # 「左右0、それ以外1」でマスク掛け
  # 右方向に返せる位置を探す
  tmp = masked_op and (me shl 1)              # 自分の石があり、そこから連続して相手の石があるbit-boardを求める
  tmp = tmp or (masked_op and (tmp shl 1))    # 4回分右にズラしつつ、ひっくり返る候補を求める(for文で回すより、直書きした方が速い？)
  tmp = tmp or (masked_op and (tmp shl 1))
  tmp = tmp or (masked_op and (tmp shl 1))
  tmp = tmp or (masked_op and (tmp shl 1))
  tmp = tmp or (masked_op and (tmp shl 1))
  result = result or (blank and (tmp shl 1))  # tmpの左側が空白なら、そこに着手可能
  
  # 左方向
  tmp = masked_op and (me shr 1)
  tmp = tmp or (masked_op and (tmp shr 1))
  tmp = tmp or (masked_op and (tmp shr 1))
  tmp = tmp or (masked_op and (tmp shr 1))
  tmp = tmp or (masked_op and (tmp shr 1))
  tmp = tmp or (masked_op and (tmp shr 1))
  result = result or (blank and (tmp shr 1))
  
  # 上下
  masked_op = op and 0x00ff_ffff_ffff_ff00'u  # 「左右0、それ以外1」でマスク掛け
  # 上方向
  tmp = masked_op and (me shl 8)
  tmp = tmp or (masked_op and (tmp shl 8))
  tmp = tmp or (masked_op and (tmp shl 8))
  tmp = tmp or (masked_op and (tmp shl 8))
  tmp = tmp or (masked_op and (tmp shl 8))
  tmp = tmp or (masked_op and (tmp shl 8))
  result = result or (blank and (tmp shl 8))
  
  # 下方向
  tmp = masked_op and (me shr 8)
  tmp = tmp or (masked_op and (tmp shr 8))
  tmp = tmp or (masked_op and (tmp shr 8))
  tmp = tmp or (masked_op and (tmp shr 8))
  tmp = tmp or (masked_op and (tmp shr 8))
  tmp = tmp or (masked_op and (tmp shr 8))
  result = result or (blank and (tmp shr 8))
  
  # 斜め
  masked_op = op and 0x007e_7e7e_7e7e_7e00'u  # 「左右上下0、それ以外1」でマスク掛け
  # 右上方向
  tmp = masked_op and (me shl 7)
  tmp = tmp or (masked_op and (tmp shl 7))
  tmp = tmp or (masked_op and (tmp shl 7))
  tmp = tmp or (masked_op and (tmp shl 7))
  tmp = tmp or (masked_op and (tmp shl 7))
  tmp = tmp or (masked_op and (tmp shl 7))
  result = result or (blank and (tmp shl 7))

  # 左上方向
  tmp = masked_op and (me shl 9)
  tmp = tmp or (masked_op and (tmp shl 9))
  tmp = tmp or (masked_op and (tmp shl 9))
  tmp = tmp or (masked_op and (tmp shl 9))
  tmp = tmp or (masked_op and (tmp shl 9))
  tmp = tmp or (masked_op and (tmp shl 9))
  result = result or (blank and (tmp shl 9))

  # 右下方向
  tmp = masked_op and (me shr 9)
  tmp = tmp or (masked_op and (tmp shr 9))
  tmp = tmp or (masked_op and (tmp shr 9))
  tmp = tmp or (masked_op and (tmp shr 9))
  tmp = tmp or (masked_op and (tmp shr 9))
  tmp = tmp or (masked_op and (tmp shr 9))
  result = result or (blank and (tmp shr 9))

  # 左下方向
  tmp = masked_op and (me shr 7)
  tmp = tmp or (masked_op and (tmp shr 7))
  tmp = tmp or (masked_op and (tmp shr 7))
  tmp = tmp or (masked_op and (tmp shr 7))
  tmp = tmp or (masked_op and (tmp shr 7))
  tmp = tmp or (masked_op and (tmp shr 7))
  result = result or (blank and (tmp shr 7))


#[
  *概要:
    - 反転bit-boardを求める(石を置いた結果、反転する箇所が1のbit-board)
  *パラメータ:
    - me<uint64>: 自分のbit-board
    - op<uint64>: 相手のbit-board
    - pos<int>:   石を置くマスbit-board
  *返り値<uint64>:
    - 反転bit-board
]#
proc getRevBoard*(me: uint64, op: uint64, posN: int): uint64 =
  let pos: uint64 = 1'u shl posN

  result = 0  # 反転bit-board
  var masked_op, rev_cand, range_mask, interpose: uint64

  # 左右
  masked_op = op and 0x7e7e_7e7e_7e7e_7e7e'u  # 「左右0、それ以外1」でマスク掛け
  # 右方向
  range_mask = 0x0000_0000_0000_00fe'u shl posN
  interpose = ((masked_op or (not range_mask)) + 1) and (range_mask and me)
  if interpose != 0:
    result = result or ((interpose - 1) and range_mask)

  # 左方向
  rev_cand = pos shr 1 and masked_op
  rev_cand = rev_cand or (masked_op and (rev_cand shr 1))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 1))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 1))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 1))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 1))
  result = result or rev_cand and (not (rev_cand shr 1 and me) + 1)
  
  # 上下
  masked_op = op and 0x00ff_ffff_ffff_ff00'u  # 「上下0、それ以外1」でマスク掛け
  # 上方向
  rev_cand = pos shr 8 and masked_op
  rev_cand = rev_cand or (masked_op and (rev_cand shr 8))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 8))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 8))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 8))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 8))
  result = result or rev_cand and (not (rev_cand shr 8 and me) + 1)

  # 下方向
  range_mask = 0x0101_0101_0101_0100'u shl posN
  interpose = ((masked_op or (not range_mask)) + 1) and (range_mask and me)
  if interpose != 0:
    result = result or ((interpose - 1) and range_mask)

  # 斜め
  masked_op = op and 0x007e_7e7e_7e7e_7e00'u  # 「上下左右0、それ以外1」でマスク掛け
  # 右上方向
  rev_cand = pos shr 7 and masked_op
  rev_cand = rev_cand or (masked_op and (rev_cand shr 7))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 7))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 7))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 7))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 7))
  result = result or rev_cand and (not (rev_cand shr 7 and me) + 1)
  
  # 左上方向
  rev_cand = pos shr 9 and masked_op
  rev_cand = rev_cand or (masked_op and (rev_cand shr 9))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 9))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 9))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 9))
  rev_cand = rev_cand or (masked_op and (rev_cand shr 9))
  result = result or rev_cand and (not (rev_cand shr 9 and me) + 1)
  
  # 右下方向
  range_mask = 0x8040_2010_0804_0200'u shl posN
  interpose = ((masked_op or (not range_mask)) + 1) and (range_mask and me)
  if interpose != 0:
    result = result or ((interpose - 1) and range_mask)

  # 左下方向
  range_mask = 0x0102_0408_1020_4080'u shl posN
  interpose = ((masked_op or (not range_mask)) + 1) and (range_mask and me)
  if interpose != 0:
    result = result or ((interpose - 1) and range_mask)


#[
  *概要:
    - 石を置く
  *パラメータ:
    - black<uint64>:   黒bit-board
    - white<uint64>:   白bit-board
    - blackTurn<bool>: 黒番ならtrue
    - pos_n<int>:      石を置くマス番号
  *返り値<tuple[black: uint64, white: uint64]>:
    - 石を置いた結果の新しいbit-board
]#
proc putStone*(black: uint64, white: uint64, posN: int, blackTurn: bool): tuple[black: uint64, white: uint64] =
  var rev: uint64
  let pos: uint64 = 1'u shl posN
  
  # 反転bit-boardを求める
  if blackTurn:
    # 黒番
    rev = getRevBoard(black, white, posN)
    let new_black = black xor (pos or rev)
    let new_white = white xor rev
    result = (black: new_black, white: new_white)
  else:
    # 白番
    rev = getRevBoard(white, black, posN)
    let new_white = white xor (pos or rev)
    let new_black = black xor rev
    result = (black: new_black, white: new_white)
