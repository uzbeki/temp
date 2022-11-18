# クラウド版（開発用）

11/15 現在、アプリ画面は開発用にユーザーネームとパスワードで認証を設けている。

# Chrome の設定でマイクをオンにする

http 通信をしているので以下が必要である。

1. Chrome のアドレスバーに次の URL を入力し設定画面に行く。`chrome://flags/#unsafely-treat-insecure-origin-as-secure`
2. `Insecure origins treated as secure`の欄にサーバーの IP アドレス(http://43.128.227.10)を入力する。
   サーバーの IP アドレスは、サーバーを再起動する度に変わる。
3. Enabled -> Relaunch を押す。
4. アプリ画面を再起動し、マイクを許可のポップアップで許可する。

# Chrome の設定で自動再生を許可する

[README.md を参照](README.md)
音声の再生を許可するサイト：http://43.128.227.10

# 注意

11/15 現在では、SPJ の category_id を設定する処理が未完成で、鈴木先生の 109 を登録している。
新たにキャラクターを追加しても category_id が空になるので会話はできない。
