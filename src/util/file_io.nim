import os
import strformat
import strutils

proc writeHeaders*(file_path: string, headers: varargs[string]): void =
  block:
    var f: File = open(file_path, FileMode.fmWrite)
    defer: close(f)
    f.writeLine join(@headers, ",")

#[
  *概要:
    - file_pathのファイルを開いて、outputを出力する
  *パラメータ:
    - file_path<string>: 書き出すファイルパス
    - output<string>:    書き出す文字列
  *返り値<void>:
    - なし
]#
proc write*(file_path: string, turn: int, leafN: int, nodeN: int, time: float): void =
  let nps: int = int((leafN.float + nodeN.float) / time)
  block:
    var f: File = open(file_path, FileMode.fmAppend)
    defer: close(f)
    f.writeLine fmt"{turn},{leafN},{nodeN},{leafN+nodeN},{time},{nps}"

