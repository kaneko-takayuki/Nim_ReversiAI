<h1><b>Nim_ReversiAI</b></h1>

コマンドライン上で動くリバーシアプリです。Nim言語で動きます。

## インストール方法
コマンド上で動かす場合、Nim言語を実行できる環境が必要になります。
以下のサイトは、Nimのインストールガイドです。

[Install | Nim](https://nim-lang.org/install.html)

Nimのインストールが完了したら、このリポジトリをクローンします。

`git clone https://github.com/kaneko-takayuki/Nim_ReversiAI.git`

## 使い方
クローンが完了したらディレクトリに移動します。

`cd Nim_ReversiAI/`

クローンしたディレクトリに入ったら、以下のコマンドを叩くと実行されます。

`nim c --run src/main {オプション}`

オプションについては、以下を参照してください。

| オプション名 | 概要 | 値 | デフォルト値 |
|:---------:|:---:|:--:|:--------:|
| --black | 黒番の時の手の選び方を設定する | "person"か"ai"のどちらか | "person" |
| --white | 白番の時の手の選び方を設定する | "person"か"ai"のどちらか | "person" |

例えば、AI同士で対戦させたい時は、次のようにコマンドを叩いてください。

`nim c --run src/main --black:ai --white:ai`

また、コンパイル時に最適化処理を掛けたい時は、nimコンパイラの`-d:release`オプションを追加してください。

`nim c -d:release --run src/main --black:ai --white:ai`

## 実行画面
ゲームが始まると、以下のような画面が表示されます。
(黒も白も手の選び方に"AI"を選んだ場合は、自動で対局終了まで進んでいきます。)

<image src="https://github.com/kaneko-takayuki/Nim_ReversiAI/blob/images/images/demo.png" width="200">

この時、それぞれのマスは以下のような意味を持っています。

| マス目の文字 | 概要 |
|:---------:|:---:|
| 'B' | 黒石が存在している |
| 'W' | 白石が存在している　 |
| '.' | 空白マスで現在置ける状態に<b>ある</b> |
| 空白マス | 空白マスで現在置ける状態に<b>ない</b> |

プレイヤーの番が回って来た時、図のように`"{横座標}{縦座標}"`の形式で入力してください。
例えば、図の局面だと`E7`や`C5`、`G4`が選択できます。

## 終盤ソルバー ベンチマーク
以下のサイトにあるベンチマークテスト計測結果です。
http://www.radagast.se/othello/ffotest.html


【2018年4月2日 計測】

| 問題番号 | 合計探索ノード数 | 合計探索葉数 | 合計探索数(ノード+葉数) | 合計探索時間(s) | NPS | 盤面ハッシュ衝突回数 | 勝敗(黒-白) |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| #40 |    27,427,587 |    8,458,508 |    35,886,095 |   4.81 | 7,457,402 |       71,675 | 51-13(黒+38) |
| #41 |   313,841,545 |  101,771,688 |   415,613,233 |  57.78 | 7,193,561 |    6,478,663 | 32-32(引き分け) |
| #42 |   187,788,819 |   59,443,341 |   247,232,160 |  34.62 | 7,141,248 |    2,756,625 | 35-29(黒+6) |
| #43 |   284,722,797 |   78,941,874 |   363,664,671 |  58.85 | 6,179,491 |   11,983,621 | 38-26(黒+12) |
| #44 |   286,532,215 |   83,208,294 |   369,740,509 |  55.75 | 6,632,463 |    9,820,481 | 39-25(黒+14) |
| #45 | 2,680,321,887 |  826,315,357 | 3,506,637,244 | 492.84 | 7,115,191 |  153,288,509 | 35-29(黒+6) |
| #46 | 3,147,652,149 |  919,755,297 | 4,067,407,446 | 580.51 | 7,006,586 |  194,124,962 | 38-36(白+8) |