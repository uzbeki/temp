初めてTalk Withのon-premise版をパソコンで動くようにするには必要なプログラムをインストールしないといけないです。必要なプログラムのインストールは最初の一回だけ行います。[PCの初期セットアップ（新しいPCに入れる場合のみ）](#PCの初期セットアップ（新しいPCに入れる場合のみ）)をご覧ください。  
👆必要なプログラムのインストールが終わったら、Talk WithのソースをPCに入れて動かします。[ソースコードの導入（talk-withシステムのソースのアップデート方法）](#ソースコードの導入（talk-withシステムのソースのアップデート方法）)をご覧ください

# PCの初期セットアップ（新しいPCに入れる場合のみ）
- `NodeJS` のインストール => [NodeJSのインストール方法](./how_to_install_node.md) に従ってください。
- `Git` のインストール => [Gitのインストール方法](./how_to_install_git.md) に従ってください。  
- `PostgreSQL`データーベースのインストール => [PostgreSQLのインストール方法](./how_to_install_pg.md) に従ってください。
  - インストールが終わったら、`talk_with`データーベースを作成してください。作成方法は[データーベースの作り方](./how_to_install_pg.md/#データーベースの作り方)に従ってください。
- `OpenSSH` セットアップ => [OpenSSHの方法](./how_to_setup_openssh.md#OpenSSH) に従ってください。
  - セットアップが終わりましたら、提供されたSSHキーペアーをセットアップしてください。 => [既に存在するSSHキーペアーのセットアップ](./how_to_setup_openssh.md#既に存在するsshキーペアーのセットアップ) に従ってください。
- `FFMPEG` セットアップ => [ffmpegの方法](./how_to_install_ffmpeg.md) に従ってください。
- 上の全部インストール終わったら、PC再起動してください。

> ダウンロードリンクが動かない場合は、開発者からダウンロードファイルを問い合わせください。

# ソースコードの導入（talk-withシステムのソースのアップデート方法）
## STEP 1 - postgresqlの接続設定とインストール
> ⚠ このステップにはソースコードアクセス用のsshキーの設定が必要です。[既に存在するSSHキーペアーのセットアップ](./how_to_setup_openssh.md#既に存在するsshキーペアーのセットアップ) に従ってください。
1. `init_talk_with.bat`ファイルを実行してください。
2. `init_talk_with.bat`のプロセスが一時的に中止し、`notepad`アプリが開かれます。そこに、
   1. `PGSQL_PASSWORD` => PostgreSQLをインストールした時に設定した`マスターパスワード`
3. `notepad`で入力終わったら`Ctrl+S`で保存し、`notepad`を閉じてください。（バッチが次のステップに行きます。行かない場合は`Enter`キーを押してください。）
4. `init_talk_with.bat`のプロセスが再開されます。終了までお待ちください。  
    (終わったらブラウザが自動で開かれますので、そのページでキャラクターを追加してください。)
> キャラクターを追加しないと動かないため、管理画面から [キャラクターの追加方法](./how_to_add_character.md) に従ってください。
## Step 2 - Windows Firewallの許可（もし出たら）
1. Windows Security Alert画面が出ます。`Allow Access`というボタンを押してください。  
  ![Windows Security Alert](images/win_security_alert.png)
2. バッチが終了するまで、しばらくお待ちしてください。終了したらブラウザでtalk_withアプリが開かれます。

> 注意点：スタートを押したら、自動再生するには、`chrome`の設定で`localhost`に許可を与えないといけないです。[自動再生許可の設定](#自動再生許可の設定)に従ってください。

# SPJとGoogle Cloudの設定について
キャラクター別で設定できます。
管理画面からキャラクター詳細ページへ移動し、`キャラクター設定`から以下のように設定を行ってください：
|カラム|型|説明|
|---|---|---|
|spj_url|VARCHAR(100)|SPJへのアクセス用のURL。後ろに`\retrieve?`は不要|
|spj_api_key|VARCHAR(100)|SPJへのアクセス用APIキー|
|google_key|JSON|Googleへのアクセス用のAPIキー。JSON式です。|


# 機能の一覧  
* [管理画面：キャラクター追加](./how_to_add_character.md)
* [DB構成](./DB.md)
* [管理画面の説明](./admin_page.md)  
* [[ β-2 ] 無言の設定](./how_to_setup_silence_limit.md)
* [[ β-10 ] conversation_countの設定](./how_to_setup_conversation_count.md)
* [[ β-29 ] pattern](./how_to_setup_pattern.md)
* [自動認証機能](./LogDB_with_Authentication.md)
* [replacement_list 動画ID/変換ID](./how_to_setup_alternative_list.md)
* [fullscreen](./how_to_setup_fullscreen.md)
* [google音声認識](./About_GoogleSpeechToText.md)
* [hide_cursor](./how_to_setup_hide_cursor.md)
* [hit_words](./how_to_setup_hit_words.md)
* [landscape_mode (縦横設定）](./how_to_setup_landscape_mode.md)
* [max_recognition_time](./how_to_setup_max_recognition_time.md)
* [show_speech_recognition_result](./how_to_setup_show_speech_recognition_result.md)
* [spj_category](./how_to_setup_spj_category.md)
* [tag（回答タグ）](./how_to_setup_tag.md)
* [管理者画面のSTOPボタン](./admin_stop_button.md)
* [チャットボットスコア判定について](./About_chatbotScore.md)
* [ランダム再生](./how_to_setup_random.md)
* [まとめモード](./how_to_setup_matome.md)
* [聞き忘れモード](./how_to_setup_kikiwasure.md)
* [強制再生](./how_to_setup_force_video.md)
* [on-premiseモード](./how_to_switch_on-premise_mode.md)


# 自動再生許可の設定
ブラウザはセキュリティー上で、動画の自動再生するにはユーザーが先に操作しないと再生しないです。自動再生がうまくいくためには、`talk with`が動いているドメインの許可を入れないといけないです。いかに従ってください。
1. chromeの設定ページを開いてください。  
   ![Chromeの設定の開き方](./images/chrome/open_settings.png)
2. `プライバシーとセキュリティー`を選択してください。
3. `サイトの設定`をクリックしてください。
4. 一番下の`その他のコンテンツの設定`をクリックしてください。
5. `音声`を選択してください。
6. 音声の再生を許可するサイトの「`追加`」ボタンをクリックしてください。
7. `http://localhost`を入れて、「`追加`」をしてください。
   ![追加の例](./images/chrome/save_settings.png)
8. ブラウザを再起動してください。