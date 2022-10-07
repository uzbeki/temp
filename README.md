初めてTalk Withのon-premise版をパソコンで動くようにするには必要なプログラムをインストールしないといけないです。必要なプログラムのインストールは最初の一回だけ行います。[PCの初期セットアップ（１回のみ）](#pcの初期セットアップ１回のみ)をご覧ください。  
👆必要なプログラムのインストールが終わったら、Talk WithのソースをPCに入れて動かします。[ソースコードの導入（１回のみ）](#ソースコードの導入（１回のみ）)をご覧ください

# PCの初期セットアップ（今回は必要がない）
- `NodeJS` のインストール => [NodeJSのインストール方法](./how_to_install_node.md) に従ってください。
- `Git` のインストール => [Gitのインストール方法](./how_to_install_git.md) に従ってください。  
- `PostgreSQL`データーベースのインストール => [PostgreSQLのインストール方法](./how_to_install_pg.md) に従ってください。
  - インストールが終わったら、`talk_with`データーベースを作成してください。作成方法は[データーベースの作り方](./how_to_install_pg.md/#データーベースの作り方)に従ってください。
- `OpenSSH` セットアップ => [OpenSSHの方法](./how_to_setup_openssh.md#OpenSSH) に従ってください。
  - セットアップが終わりましたら、提供されたSSHキーペアーをセットアップしてください。 => [既に存在するSSHキーペアーのセットアップ](./how_to_setup_openssh.md#既に存在するsshキーペアーのセットアップ) に従ってください。
- `FFMPEG` セットアップ => [ffmpegの方法](./how_to_install_ffmpeg.md) に従ってください。
- 上の全部インストール終わったら、PC再起動してください。
> ダウンロードリンクが動かない場合は、開発者からダウンロードファイルを問い合わせください。

# ソースコードの導入（１回のみ）
1. `init_talk_with.bat`ファイルを実行してください。
2. `init_talk_with.bat`のプロセスが一時的に中止し、`notepad`アプリが開かれます。そこに、
   1. `PGSQL_PASSWORD` => PostgreSQLをインストールした時に設定した`マスターパスワード`
   2. `SPJ_API_KEY` => SPJのAPIキー
   3. `SPJ_API_URL` => SPJのAPIのURL
   4. `SPJ_CATEGORY_ID` => SPJのカテゴリーIDを入力してください（必要なかったらそのまま）。
3. `notepad`で入力終わったら`Ctrl+S`で保存し、`notepad`を閉じてください。（バッチが次のステップに行きます。行かない場合は`Enter`キーを押してください。）
4. ファイルエクスプローラーが開かれます。そちらに「鈴木先生」の動画ファイルを全てコピーしてもってきて、エクスプローラー閉じてください。（バッチが次のステップに行きます。行かない場合は`Enter`キーを押してください。）
5. `notepad`でGoogle CloudのSpeech to Text用のキーを保存するファイルが開かれます。そちらに、Googleのキーを入力し、`Ctrl+S`で保存し、`notepad`を閉じてください。（バッチが次のステップに行きます。行かない場合は`Enter`キーを押してください。）
6. `init_talk_with.bat`のプロセスが再開されます。終了までお待ちください。
7. Windows Security Alert画面が出ます。`Allow Access`というボタンを押してください。  
  ![Windows Security Alert](images/win_security_alert.png)
7. バッチが終了するまで、しばらくお待ちしてください。終了したらブラウザでtalk_withアプリが開かれます。

# キャラクターの設定（今回は必要がない）
- `pgAdmin`からユーザー (話す相手・芸能人)の情報をDBに入れて、結果のIDをコピーする。（管理画面ができるまで）
  ```sql
  INSERT INTO characters(name, owner_id) VALUES('Suzuki Sensei', (SELECT id FROM users WHERE is_admin=true));
  ```
## 動画ファイル
- *コピーしたID名*で`talk_with/app/public/videos/source`の中にフォルダーを作成し、そのフォルダーにユーザーの動画を置く

## キャラクターの動画設定（csv）
- 設定ファイルの名前を`videoSettingFile.csv`にする
- コピーしたIDを`videoSettingFile.csv`の`user_id`に設定
- `videoSettingFile.csv`の２行目に以下を無ければ追加
  ```txt
  original_id, character_id, title, action, loop_count, original_next_id, mic_on, play_now, mic_on_millisecond, question, comment
  ```
- ソースコードのパスの`docs/`フォルダーに`videoSettingFile.csv`を保存。（後で管理画面からアップロードできるようになる）
- ターミナルで`insertData.bat`を実行。





# videoSettingFile.csvについて（今回は必要がない）
## データーの形（必須）
1. ２行目に以下であること
  ```txt
  original_id, character_id, title, action, loop_count, original_next_id, mic_on, play_now, mic_on_millisecond, question, comment
  ```
2. ファイル名が`videoSettingFile.csv`であること
3. 患者ID（character_id）にデータベースに登録したユーザーのIDを設定すること

## 自動初期設定のため（必須ではない）
1. スタート動画のタイトルは`start.mp4`であること、かつ、character_idが設定されていること
2. うなずき動画のタイトルは`listen.mp4`であること、かつ、character_idが設定されていること
3. 無言時に再生する動画のタイトルは`silence.mp4`であること、かつ、character_idが設定されていること
4. 連続無言時に再生する動画のタイトルは`out.mp4`であること、かつ、character_idが設定されていること
5. SPJ判定スコアが低い時に再生する動画のタイトルは`spjlow.mp4`であること、かつ、character_idが設定されていること
6. 認識できない音の動画のタイトルは`unrecognized.mp4`であること、かつ、character_idが設定されていること
7.  

# SPJの設定について
`talk_with/app`の中に`.env.local`ファイルがあります。
`.env.local`ファイルに以下を設定する：
```bash
SPJ_API_KEY = SPJのAPIキー
SPJ_CATEGORY_ID = カテゴリ別で検索する場合のカテゴリID、検索しない場合は空白
SPJ_API_URL = SPJのAPIのURL(最後の部分は/retrieve?で終わること)
```

# 機能の一覧  
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
* [on-promiseモード](./how_to_switch_on-promise_mode.md)