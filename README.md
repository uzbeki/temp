初めてTalk Withのon-premise版をパソコンで動くようにするには必要なプログラムをインストールしないといけないです。必要なプログラムのインストールは最初の一回だけ行います。[PCの初期セットアップ（１回のみ）](#pcの初期セットアップ１回のみ)をご覧ください。  
👆必要なプログラムのインストールが終わったら、Talk WithのソースをPCに入れて動かします。[ソースコードの導入（１回のみ）](#ソースコードの導入（１回のみ）)をご覧ください

# PCの初期セットアップ（１回のみ）
- `nodejs` のインストール => [NodeJSのインストール方法](./how_to_install_node.md) に従ってください。
  
- `git` のインストール => [Gitのインストール方法](./how_to_install_git.md) に従ってください。
  
- PostgreSQLデーターベースのインストール => [PostgreSQLのインストール方法](./how_to_install_pg.md) に従ってください。
  - インストールが終わったら、`talk_with`データーベースを作成してください。作成方法は[データーベースの作り方](./how_to_install_pg.md/#データーベースの作り方)に従ってください。
- OpenSSH セットアップ => [OpenSSHの方法](./how_to_setup_openssh.md#OpenSSH) に従ってください。
  - セットアップが終わりましたら、提供されたSSHキーペアーをセットアップしてください。 => [既に存在するSSHキーペアーのセットアップ](./how_to_setup_openssh.md#既に存在するsshキーペアーのセットアップ) に従ってください。
- FFMPEG セットアップ => [ffmpegの方法](./how_to_install_ffmpeg.md) に従ってください。


# ソースコードの導入（１回のみ）
- ソースコードを取得する。コマンドで以下を実行。
  ```bash
  git clone -b main git@github.com:uzbeki/talk_with.git
  ```
- `app/`フォルダー内に`.env.local`ファイル作成。中身は `.env.sample` からコピーし、データベースパスワードを入力
- ターミナルで`setup.bat`を実行
- `localhost:3000`にアクセスする

# 新規ユーザー（パートナー・芸能人）の設定
- `pgAdmin`からユーザー (話す相手・芸能人)の情報をDBに入れて、結果のIDをコピーする。
  ```sql
  INSERT INTO users(name, email, password)
    VALUES ('鈴木先生', 'suzuki@byouin.co.jp', 'test')
    RETURNING id;
  ```
## 動画ファイル
- *コピーしたID名*で`talk_with/app/public/videos/source`の中にフォルダーを作成し、そのフォルダーにユーザーの動画を置く

## ユーザーの動画設定（csv）
- 設定ファイルの名前を`videoSettingFile.csv`にする
- コピーしたIDを`videoSettingFile.csv`の`user_id`に設定
- `videoSettingFile.csv`の２行目に以下を無ければ追加
  ```txt
  original_id, user_id, title, delay, action, loop_count, original_next_id, mic_on, play_now, mic_on_millisecond, question, comment
  ```
- ソースコードのパスの`docs/`フォルダーに`videoSettingFile.csv`を保存。（後で管理画面からアップロードできるようになる）
- ターミナルで`insertData.bat`を実行。





# videoSettingFile.csvについて
## データーの形（必須）
1. ２行目に以下であること
  ```txt
  original_id, user_id, title, delay, action, loop_count, original_next_id, mic_on, play_now, mic_on_millisecond, question, comment
  ```
2. ファイル名が`videoSettingFile.csv`であること
3. 患者ID（user_id）にデータベースに登録したユーザーのIDを設定すること

## 自動初期設定のため（必須ではない）
1. スタート動画のタイトルは`start.mp4`であること、かつ、user_idが設定されていること
2. うなずき動画のタイトルは`listen.mp4`であること、かつ、user_idが設定されていること
3. 無言時に再生する動画のタイトルは`silence.mp4`であること、かつ、user_idが設定されていること
4. 連続無言時に再生する動画のタイトルは`out.mp4`であること、かつ、user_idが設定されていること
5. SPJ判定スコアが低い時に再生する動画のタイトルは`spjlow.mp4`であること、かつ、user_idが設定されていること
6. 認識できない音の動画のタイトルは`unrecognized.mp4`であること、かつ、user_idが設定されていること
7.  

# SPJの設定について
`talk_with/app`の中に`.env.local`ファイルがあります。
`.env.local`ファイルに以下を設定する：
```bash
SPJ_API_KEY = SPJのAPIキー
SPJ_CATEGORY_ID = カテゴリ別で検索する場合のカテゴリID、検索しない場合は空白
SPJ_API_URL = SPJのAPIのURL(最後の部分は/retrieve?で終わること)
```