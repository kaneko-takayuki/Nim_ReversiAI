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
