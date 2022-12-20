# データベース構成

アプリで使用しているデータベースの一覧を説明する。

### 注意点

型が SMALLINT なっている項目は 32767 まで入力できませんので、注意してください。

# users テーブル

| カラム   | 型           | 説明                       |
| -------- | ------------ | -------------------------- |
| id       | UUID         | 主キー。自動で生成される。 |
| name     | VARCHAR(255) | 名前                       |
| email    | VARCHAR(255) | メールアドレス             |
| password | VARCHAR(255) | パスワード                 |
| is_admin | BOOLEAN      | 管理者かどうか             |

# characters テーブル

| カラム   | 型           | 説明                                          |
| -------- | ------------ | --------------------------------------------- |
| id       | SERIAL       | 主キー。自動で生成される。                    |
| name     | VARCHAR(255) | 名前                                          |
| owner_id | UUID         | users テーブルの id。キャラクターのオーナー。 |

# videos テーブル

| カラム                 | 型            | 説明                                                                       |
| ---------------------- | ------------- | -------------------------------------------------------------------------- |
| id                     | UUID          | 主キー。自動で生成される。                                                 |
| character_id           | SERIAL        | characters テーブルの id                                                   |
| path                   | VARCAHAR(255) | 動画があるディレクトリのパス                                               |
| original_id            | INTEGER       | α 版で使っている動画 ID                                                    |
| original_next_id       | INTEGER[]     | α 版で使っている動画 ID の next_id                                         |
| title                  | VARCHAR(255)  | 拡張子無しの動画のファイル名                                               |
| action                 | VARCHAR(10)   | jump, loop, end, skip                                                      |
| loop_count             | SMALLINT      | 何回ループするか                                                           |
| next_video_id          | UUID[]        | 次に再生する動画                                                           |
| mic_on                 | BOOLEAN       | 動画再生中にマイクをオンにするか                                           |
| play_now               | BOOLEAN       | すぐに再生するか                                                           |
| mic_on_millisecond     | SMALLINT      | マイクオンにするまでの時間(ミリ秒)                                         |
| comment                | VARCHAR(255)  | 分かりやすくするためのコメント                                             |
| play_again             | BOOLEAN       | 2 度再生するのを許可するか                                                 |
| nod_video_id           | UUID[]        | videos テーブルの id。うなずき動画                                         |
| force_video_id         | UUID[]        | 強制再生動画（SPJ から戻ってきた ID を無視し、これを再生させる。）         |
| silence_time_limit     | SMALLINT      | 無言時間,                                                                  |
| silence_video_id       | UUID[]        | videos テーブルの id。無言時間を超えた場合に流す動画。                     |
| silence_count          | SMALLINT      | 無言回数                                                                   |
| silence_final_video_id | UUID[]        | videos テーブルの id。無言回数を超えた場合に流す動画。                     |
| tag                    | VARCHAR(255)  | SPJ にタグを付けて送信する                                                 |
| spj_category           | SMALLINT      | SPJ のカテゴリー                                                           |
| hit_words              | JSON          | 認識された音声に特定単語がある場合、事前に用意した動画を流すための特定単語 |
| replacement_list       | JSON          | spj から来た動画の id を他の動画の id に変換する                           |
| max_recognition_time   | SMALLINT      | 設定した時間になったら認識した音声を強制的に SPJ へ送る                    |

# character_setting テーブル

| カラム                        | 型           | 説明                                                           |
| ----------------------------- | ------------ | -------------------------------------------------------------- |
| character_id                  | SERIAL       | 主キー。characters テーブルの id                               |
| start_video_id                | UUID[]       | videos テーブルの id。start 動画                               |
| listening_video_id            | UUID[]       | videos テーブルの id。listen 動画                              |
| speech_unrecognized_video_id: | UUID[]       | videos テーブルの id。言葉を認識できなかった場合に流す動画     |
| silence_time_limit            | SMALLINT     | 無言時間                                                       |
| silence_video_id              | UUID[]       | 無言時間を超えた場合に流す動画                                 |
| silence_count                 | SMALLINT     | 無言回数                                                       |
| silence_final_video_id        | UUID[]       | videos テーブルの id。無言回数を超えた場合に流す動画。         |
| silence_enabled               | BOOLEAN      | silence 機能を有効にするか                                     |
| chatbot_score                 | FLOAT(2)     | 0~1。                                                          |
| chatbot_score_video_id        | UUID         | videos テーブルの id                                           |
| spj_url                       | VARCHAR(100) | SPJ へのアクセス用の URL。後ろに `/retrieve?` は不要           |
| spj_api_key                   | VARCHAR(100) | SPJ へのアクセス用 API キー                                    |
| google_key                    | JSON         | Google へのアクセス用の API キー。JSON 式 (まだ機能しません。) |

# project_settings テーブル

| カラム                         | 型          | 説明                                                   |
| ------------------------------ | ----------- | ------------------------------------------------------ |
| id                             | smallserial | 主キー                                                 |
| use_web_speech_api             | BOOLEAN     | ブラウザの Speech-to-Text を使うか                     |
| landscape_mode                 | BOOLEAN     | ディスプレイが横型で使用するか                         |
| max_recognition_time           | INTEGER     | 音声認識が確定されない場合、強制的に送るための時間設定 |
| show_speech_recognition_result | BOOLEAN     | 音声認識の結果を画面に表示するか                       |
| hide_cursor                    | BOOLEAN     | カーソルを隠すか                                       |
| standby_video_id               | UUID        | videos テーブルの id。待機中に流す動画。               |

# conversations テーブル

| カラム               | 型          | 説明                                       |
| -------------------- | ----------- | ------------------------------------------ |
| character_id         | INTEGER     | characters テーブルの id                   |
| start_count_video_id | UUID        | 対話成立のカウンターを始める動画           |
| count                | SMALLSERIAL | 対話成立のカウンターする数                 |
| play_video_id        | UUID        | 対話成立のカウンターが終わった場合流す動画 |

# chatbot_scores テーブル

| カラム       | 型       | 説明                                               |
| ------------ | -------- | -------------------------------------------------- |
| id           | SERIAL   | 主キー                                             |
| video_id     | UUID     | videos テーブルの id。どの動画の score か。        |
| score        | FLOAT(2) | 0~1。                                              |
| low_video_id | UUID     | videos テーブルの id。score より低い場合に流す動画 |

# slots テーブル

| カラム        | 型     | 説明                                   |
| ------------- | ------ | -------------------------------------- |
| play_video_id | UUID   | check_ids が全部再生された場合流す動画 |
| check_ids     | UUID[] | チェックしたい動画の id                |
| character_id  | SERIAL | characters テーブルの id。             |

# play_logs テーブル

| カラム       | 型           | 説明                     |
| ------------ | ------------ | ------------------------ |
| id           | BIGSERIAL    | 主キー                   |
| character_id | SERIAL       | characters テーブルの id |
| video_id     | INTEGER      | videos テーブルの id     |
| start_time   | TIMESTAMP    | ログの時間               |
| title        | VARCHAR(255) | ログのタイトル           |
| comment      | TEXT         | ログのコメント           |

# connection_logs テーブル

| カラム       | 型          | 説明                     |
| ------------ | ----------- | ------------------------ |
| id           | BIGSERIAL   | 主キー                   |
| origin       | VARCHAR(50) | 接続元                   |
| destination  | VARCHAR(50) | 接続先                   |
| character_id | SERIAL      | characters テーブルの id |
| time         | TIMESTAMP   | ログの時間               |
| action       | VARCHAR(50) | socket 通信の有無        |
| payload      | TEXT        | ログの内容               |

# error_logs テーブル

| カラム       | 型           | 説明                     |
| ------------ | ------------ | ------------------------ |
| id           | BIGSERIAL    | 主キー                   |
| character_id | SERIAL       | characters テーブルの id |
| time         | TIMESTAMP    | エラーの時間             |
| origin       | VARCHAR(50)  | エラーの発生源           |
| code         | VARCHAR(255) | エラーコード             |
| message      | TEXT         | メッセージ               |
| stack        | TEXT         | エラースタック           |

# summary テーブル

| カラム               | 型       | 説明                                                   |
| -------------------- | -------- | ------------------------------------------------------ |
| id                   | SERIAL   | 主キー                                                 |
| character_id         | SERIAL   | characters テーブルの id                               |
| start_video_id       | UUID     | スタート動画。videos テーブルの id                     |
| end_video_id         | UUID     | end 動画。videos テーブルの id                         |
| high_score           | SMALLINT | 基準の高いスコア                                       |
| high_score_video_id  | UUID     | high_score 以上の場合に流す動画。videos テーブルの id  |
| low_score            | SMALLINT | 基準の低いスコア                                       |
| low_score_video_id   | UUID     | low_score 以下の場合に流す動画。videos テーブルの id   |
| other_score_video_id | UUID     | それ以外のスコアの場合に流す動画。videos テーブルの id |

# summary_keyword テーブル

| カラム     | 型       | 説明                                   |
| ---------- | -------- | -------------------------------------- |
| id         | SERIAL   | 主キー                                 |
| summary_id | SERIAL   | summary テーブルの id                  |
| keyword    | TEXT[]   | (例){痛い,痛む,痛く,痛かった}          |
| score      | SMALLINT | keyword に一致した場合に加算するスコア |

# kikiwasure テーブル

| カラム                 | 型        | 説明                                                                   |
| ---------------------- | --------- | ---------------------------------------------------------------------- |
| id                     | BIGSERIAL | 主キー                                                                 |
| character_id           | SERIAL    | characters テーブルの id                                               |
| start_video_id         | UUID      | スタート動画。videos テーブルの id                                     |
| connecting_video_id    | UUID      | 再生していない動画が複数ある場合に、間に流す動画。videos テーブルの id |
| kikiwasure_positive_id | UUID      | kikiwasure_check の check_played_id を全部再生していない場合に流す動画 |
| kikiwasure_negative_id | UUID      | kikiwasure_check の check_played_id を全部再生していた場合に流す動画   |

# kikiwasure_check テーブル

| カラム          | 型        | 説明                                                                |
| --------------- | --------- | ------------------------------------------------------------------- |
| id              | BIGSERIAL | 主キー                                                              |
| kikiwasure_id   | BIGSERIAL | kikiwasure テーブルの id                                            |
| check_played_id | UUID      | 再生していたか確認する動画。videos テーブルの id                    |
| play_video_id   | UUID      | check_played_id で再生していない場合に再生する videos テーブルの id |

# block テーブル

| カラム                  | 説明                                                          |
| ----------------------- | ------------------------------------------------------------- |
| title                   | ブロックの説明文                                              |
| trigger_video 　　      | ブロックの初めに流れる動画                                    |
| listen_video 　　       | 聞き待ち動画                                                  |
| valid_responses         | 飛ばしたいブロックの trigger_video                            |
| tag                     |                                                               |
| hit_words               | 特定のキーワードを含んでいたら、動画を流す                    |
| invalid_response_video  | 関係ないことを話したら流す動画                                |
| invalid_max_count       | 指定した番号を超えたらブロックから出る                        |
| skip_id                 | spj から返ってきた特定の動画 ID を無視する                    |
| play_again              | true:同じブロックに入る、false:同じブロックに入らない         |
| play_final_video        | ブロックに入らない時に流す動画                                |
| max_recognition_time    | 音声認識時間                                                  |
| replacement_list        | 特定の動画の変換 ID を流す                                    |
| nod_video               | うなずき動画                                                  |
| spj_category            |                                                               |
| spj_empty_video         | spj が何も返さなかったときに流す動画                          |
| chatbot_score_end       | true だったら、シナリオを出る、false だったら、聞く動画に戻る |
| chatbot_score_end_video | スコアが低かったら違うブロックの動画を流す                    |
| listen_video_number     | 聞く動画の何番目を流すかの番号                                |
| silence_time_limit      | 無言時間                                                      |
| silence_video           | 無言動画                                                      |
| silence_count           | 無言動画カウント                                              |
| silence_final_video     | 無言動画カウントを超えたらシナリオを出るときに流す動画        |
| force_next_video_id     | 強制再生動画                                                  |

# block_listen_videos テーブル

| カラム          | 説明                                  |
| --------------- | ------------------------------------- |
| id              |                                       |
| block_id        | 聞き待ち動画を追加したい blocks の ID |
| listen_video_id | 聞き待ち動画                          |
| play_order      | ブロックで流す聞き待ち動画の順番      |

# block_chatbot_scores テーブル

| カラム       | 説明                                                         |
| ------------ | ------------------------------------------------------------ |
| id           |                                                              |
| block_id     | 聞き待ち動画を追加したい blocks の ID                        |
| low_video_id | spj のスコアがチャットボットのスコアより低かった時に流す動画 |
| score        | チャットボットのスコア                                       |

# block_replacement_videos テーブル

| カラム             | 説明                                  |
| ------------------ | ------------------------------------- |
| id                 |                                       |
| block_id           | 聞き待ち動画を追加したい blocks の ID |
| video_id           | 変換前の動画                          |
| converted_video_id | 変換後の動画                          |

# character_start_buttons テーブル

| カラム       | 説明                                      |
| ------------ | ----------------------------------------- |
| id           |                                           |
| character_id | スタート動画を設定したいキャラクターの ID |
| video_id     | スタート動画                              |
| block_id     | スタート動画後に入るブロックの ID         |
