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
| --black | 黒番の選び方を設定する | "person"か"ai"のどちらか | "person" |
| --white | 白番の選び方を設定する | "person"か"ai"のどちらか | "person" |

例えば、AI同士で対戦させたい時は、次のようにコマンドを叩いてください。

`nim c --run src/main --black:ai --white:ai`

また、コンパイル時に最適化処理を掛けたい時は、nimコンパイラの`-d:release`オプションを追加してください。

`nim c -d:release --run src/main --black:ai --white:ai`
