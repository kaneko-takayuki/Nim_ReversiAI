## 共通定数
const AI_INF*: int = 1000000000  # Infinity

## 中盤関連
const DEPTH*: int = 9            # 探索深さ

## 終盤関連
const FINAL*: int = 42           # 終盤に入るターン数
const FINAL_OPT*: int = 1        # 最終n手最適化
const FULL_SEARCH*: int = 6      # 全探索を開始する
const TRANSPOSITION_N*: uint64 = 0x100_0000'u64  # 置換表のサイズ(NOTE: -1したら、必ず繰り下がって下位ビットが1になるようにすること)
const BLANK_TABLE_N*: int = 24   # 空所表のリストサイズ

var benchmarkTestFlag*: bool = false  # ベンチマーク検証フラグ

# 石の場所による重み付け
const VALUE_TABLE*: array[0..63, int] = [ 30, -12,   0,  -1,  -1,   0, -12,  30,
                                         -12, -20,  -3,  -3,  -3,  -3, -20, -12,
                                           0,  -3,   0,  -1,  -1,   0,  -3,   0,
                                          -1,  -3,  -1,  -1,  -1,  -1,  -3,  -1,
                                          -1,  -3,  -1,  -1,  -1,  -1,  -3,  -1,
                                           0,  -3,   0,  -1,  -1,   0,  -3,   0,
                                         -12, -20,  -3,  -3,  -3,  -3, -20, -12,
                                          30, -12,   0,  -1,  -1,   0, -12,  30]
