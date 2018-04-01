# ハッシュリストサイズ: 134,217,728
# 合計衝突回数: 383,130
# 合計探索時間(s): 10.53643800000001
proc hash1(me: uint64, op: uint64): uint =
  let
    meCompress: uint64 = (((me shr 32) and 0xffff_ffff'u) * 2) + ((me and 0xffff_ffff'u) * 3)
    opCompress: uint64 = (((op shr 32) and 0xffff_ffff'u) * 5) + ((op and 0xffff_ffff'u) * 7)
  result = ((meCompress + opCompress) shr 7).uint and 0xff_ffff

# ハッシュリストサイズ: 134,217,728
# 合計衝突回数: 3,321,215
# 合計探索時間(s): 10.504868
proc hash2(me: uint64, op: uint64): uint64 =
  let
    meHash1 = (me and 0x0000_0000_0000_ffff'u) * 17
    meHash2 = ((me and 0x0000_0000_ffff_0000'u) shr 16) * 289
    meHash3 = ((me and 0x0000_ffff_0000_0000'u) shr 32) * 4913
    mehash4 = ((me and 0xffff_0000_0000_0000'u) shr 48) * 83521
    opHash1 = (op and 0x0000_0000_0000_ffff'u) * 17
    opHash2 = ((op and 0x0000_0000_ffff_0000'u) shr 16) * 289
    opHash3 = ((op and 0x0000_ffff_0000_0000'u) shr 32) * 4913
    ophash4 = ((op and 0xffff_0000_0000_0000'u) shr 48) * 83521
  result = (meHash1 + meHash2 + meHash3 + mehash4 + opHash1 + opHash2 + opHash3 + opHash4) and 0xff_ffff

# ハッシュリストサイズ: 134,217,728
# 合計衝突回数: 1,348,775
# 合計探索時間(s): 10.167328
proc hash3(me: uint64, op: uint64): uint64 =
  let
    meHash1 = (me and 0x0000_0000_0000_ffff'u) * 2
    meHash2 = ((me and 0x0000_0000_ffff_0000'u) shr 16) * 3
    meHash3 = ((me and 0x0000_ffff_0000_0000'u) shr 32) * 5
    mehash4 = ((me and 0xffff_0000_0000_0000'u) shr 48) * 7
    opHash1 = (op and 0x0000_0000_0000_ffff'u) * 9
    opHash2 = ((op and 0x0000_0000_ffff_0000'u) shr 16) * 11
    opHash3 = ((op and 0x0000_ffff_0000_0000'u) shr 32) * 13
    ophash4 = ((op and 0xffff_0000_0000_0000'u) shr 48) * 17
  result = (meHash1 + meHash2 + meHash3 + mehash4 + opHash1 + opHash2 + opHash3 + opHash4) and 0xff_ffff

# これ採用してる
# ハッシュリストサイズ: 134217728
# 合計衝突回数: 164,569
# 合計探索時間(s): 11.844424
proc hash4(me: uint64, op: uint64): uint64 =
  let
    meHash1 = (me and 0x0000_0000_0000_ffff'u) * 17
    meHash2 = ((me and 0x0000_0000_ffff_0000'u) shr 16) * 289
    meHash3 = ((me and 0x0000_ffff_0000_0000'u) shr 32) * 4913
    mehash4 = ((me and 0xffff_0000_0000_0000'u) shr 48) * 83521
    opHash1 = (op and 0x0000_0000_0000_ffff'u) * 19
    opHash2 = ((op and 0x0000_0000_ffff_0000'u) shr 16) * 361
    opHash3 = ((op and 0x0000_ffff_0000_0000'u) shr 32) * 6859
    ophash4 = ((op and 0xffff_0000_0000_0000'u) shr 48) * 130321
  result = (meHash1 + meHash2 + meHash3 + mehash4 + opHash1 + opHash2 + opHash3 + opHash4) and 0xff_ffff

# ハッシュリストサイズ: 134217728
# 合計衝突回数: 729,921
# 合計探索時間(s): 10.858909
proc hash5(me: uint64, op: uint64): uint64 =
  let
    meHash1 = (me and 0x0000_0000_0000_ffff'u) * 13
    meHash2 = ((me and 0x0000_0000_ffff_0000'u) shr 16) * 17
    meHash3 = ((me and 0x0000_ffff_0000_0000'u) shr 32) * 19
    mehash4 = ((me and 0xffff_0000_0000_0000'u) shr 48) * 23
    opHash1 = (op and 0x0000_0000_0000_ffff'u) * 29
    opHash2 = ((op and 0x0000_0000_ffff_0000'u) shr 16) * 31
    opHash3 = ((op and 0x0000_ffff_0000_0000'u) shr 32) * 37
    ophash4 = ((op and 0xffff_0000_0000_0000'u) shr 48) * 41
  result = (meHash1 + meHash2 + meHash3 + mehash4 + opHash1 + opHash2 + opHash3 + opHash4) and 0xff_ffff

proc hash6(me: uint64, op: uint64): uint64 =
  let
    maskedMe1: uint64 = me and 0x254c_2284_5181_2490'u
    maskedMe2: uint64 = me and 0x5182_a902_52c1_1221'u
    maskedOp1: uint64 = op and 0x254c_2284_5181_2490'u
    maskedOp2: uint64 = op and 0x5182_a902_52c1_1221'u
    tmpMe1: uint64 = ((maskedMe1 and 0x0000_0000_ffff_ffff'u) + ((maskedMe1 and 0xffff_ffff_0000_0000'u) shr 32)) * 5
    tmpMe2: uint64 = ((maskedMe2 and 0x0000_0000_ffff_ffff'u) + ((maskedMe2 and 0xffff_ffff_0000_0000'u) shr 32)) * 13
    tmpOp1: uint64 = ((maskedOp1 and 0x0000_0000_ffff_ffff'u) + ((maskedOp1 and 0xffff_ffff_0000_0000'u) shr 32)) * 7
    tmpOp2: uint64 = ((maskedOp2 and 0x0000_0000_ffff_ffff'u) + ((maskedOp2 and 0xffff_ffff_0000_0000'u) shr 32)) * 17
  result = (tmpMe1 + tmpMe2 + tmpOp1 + tmpOp2) and 0xff_ffff'u

# 254C_2284_5181_2490
# 00100101
# 01001100
# 00100010
# 10000100
# 01010001
# 10000001
# 00100100
# 10010000


# 5182_A902_52C1_1221
# 01010001
# 10000010
# 10101001
# 00000010
# 01010010
# 11000001
# 00010010
# 00100001