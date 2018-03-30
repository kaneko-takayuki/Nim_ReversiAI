import os

#[
  *概要:
    - file_pathのファイルを開いて、outputを出力する
  *パラメータ:
    - file_path<string>: 書き出すファイルパス
    - output<string>:    書き出す文字列
  *返り値<void>:
    - なし
]#
proc write*(file_path: string, output: string): void =
  block:
    var f: File = open(file_path, FileMode.fmAppend)
    defer: close(f)
    f.writeLine output

