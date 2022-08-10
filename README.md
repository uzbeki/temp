# PCの初期セットアップ（１回のみ）
- `nodejs` と `npm` のインストール
  [NodeJS version: v16.16.0 LTS, npm version: 8.11.0](https://nodejs.org/dist/v16.16.0/node-v16.16.0-x64.msi)
- `git` のインストール
  [Git 2.37.1](https://github.com/git-for-windows/git/releases/download/v2.37.1.windows.1/Git-2.37.1-64-bit.exe)
- PostgreSQLのセットアップ
  1. [Postgresql 14.4 インストールリンク](https://sbp.enterprisedb.com/getfile.jsp?fileid=1258118)
  2. `pgAdmin`を開いて、以下のコマンドで`talk_with`データベースの作成
    ```sql
    CREATE DATABASE talk_with;
    ```
- OpenSSH　セットアップ
  1. [Install ](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui#install-openssh-for-windows)  
    `Settings` => `Apps` => `Optional Features` => `OpenSSH Client`をインストール
  2. Powershellで管理者になって以下のコマンドを実行し、`OpenSSH-Client`を自動起動するように設定する：
    ```powershell
    # Set the sshd service to be started automatically
    Get-Service -Name sshd | Set-Service -StartupType Automatic

    # Now start the sshd service
    Start-Service sshd
    ```
  3. [新しいSSHキーの作成](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement#host-key-generation)  コマンドで以下を実行
    ```powershell
    ssh-keygen -t ed25519
    ```
  4. Give public key to `beki@asterone.co.jp` to set up ssh read access to source code
- FFMPEG セットアップ
  1. [FFMPEGのインストール](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z)
  2. ダウンロードしたファイルを`C:\Program Files\`に解凍する
  3. `C:\Program Files\ffmpeg\bin\`を`PATH`に追加する

# ソースコードの準備
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
