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

# new_videos テーブル
[🔗機能説明書へ](./table_new_videos.md)
| カラム                                     | 型            | 説明                                                 | 機能するか |
| ------------------------------------------ | ------------- | ---------------------------------------------------- | ---------- |
| id                                         | UUID          | 主キー。自動で生成される。                           | ✔️       |
| character_id                               | SERIAL        | characters テーブルの id                             | ✔️       |
| path                                       | VARCAHAR(255) | 動画があるディレクトリのパス                         | ✔️       |
| original_id                                | INTEGER       | α 版で使っている動画 ID                              | ✔️       |
| title                                      | VARCHAR(255)  | 拡張子無しの動画のファイル名                         | ✔️       |
| play_end                                   | BOOLEAN       | 再生し終わったら、対話が終了するか                   | ✔️       |
| loop                                       | BOOLEAN       | loopするかどうか                                     | ✔️       |
| loop_count                                 | SMALLINT      | loopする場合、何回までするか                         | ✔️       |
| mic_on                                     | BOOLEAN       | 動画再生中にマイクをオンにするか                     | ✔️       |
| [play_now](./table_new_videos.md#play_now) | BOOLEAN       | すぐに再生するか。ブロックであんまり使わなくなった。 | ✔️       |
| mic_on_millisecond                         | SMALLINT      | マイクオンにするまでの時間(ミリ秒)                   | ✔️       |
| comment                                    | VARCHAR(255)  | 分かりやすくするためのコメント                       | ✔️       |

# character_setting テーブル

| カラム                       | 型           | 説明                                                                       | 機能するか |
| ---------------------------- | ------------ | -------------------------------------------------------------------------- | ---------- |
| character_id                 | SERIAL       | 主キー。characters テーブルの id                                           | ✔️       |
| ~~listening_video_id~~       | UUID[]       | 聞く動画ID。ブロック機能追加後、使わなくなった。仕様が無ければ**廃止予定** | ✔️       |
| speech_unrecognized_video_id | UUID[]       | 動画ID。言葉を認識できなかった場合に流す動画                               | ✔️       |
| silence_time_limit           | SMALLINT     | 無言時間                                                                   | ✔️       |
| silence_video_id             | UUID[]       | 無言時間を超えた場合に流す動画                                             | ✔️       |
| silence_count                | SMALLINT     | 無言回数                                                                   | ✔️       |
| silence_final_video_id       | UUID[]       | 動画ID。無言回数を超えた場合に流す動画。                                   | ✔️       |
| silence_enabled              | BOOLEAN      | silence 機能を有効にするか。                                               | ✔️       |
| chatbot_score                | FLOAT(2)     | 0~...                                                                      | ✔️       |
| chatbot_score_video_id       | UUID         | chatbot_scoreより低いスコア時に再生する動画ID                              | ✔️       |
| spj_url                      | VARCHAR(100) | SPJ へのアクセス用の URL。後ろに `/retrieve?` は不要                       | ✔️       |
| spj_api_key                  | VARCHAR(100) | SPJ へのアクセス用 API キー                                                | ✔️       |
| google_key                   | JSON         | Google へのアクセス用の API キー。JSON 式                                  | ✔️       |

# project_settings テーブル
| 項目                           | データ式 | 説明                                                             | 機能対応済み |
| :----------------------------- | :------- | :--------------------------------------------------------------- | :----------- |
| id                             | UUID     | 主キー                                                           |              |
| use_web_speech_api             | BOOLEAN  | ブラウザの音声認識機能・Google Cloud Speech to Text APIを使うか  | ✔️         |
| landscape_mode                 | BOOLEAN  | アプリの画面が横か縦か                                           | ✔️         |
| max_recognition_time           | INTEGER  | 音声認識の強制確定期間：ミリ秒                                   | ✔️         |
| hide_cursor                    | BOOLEAN  | カーソルを隠すか                                                 | ✔️         |
| show_speech_recognition_result | BOOLEAN  | 音声認識の状況確認画面を表示するか：マイクアイコンと認識テキスト | ✔️         |
| standby_video_id               | UUID     | プロジェクト全体の待機動画（廃止予定）                           | ✔️         |
| default_character_id           | INTEGER  | デフォルトキャラクター（予定）                                   |              |
			


# conversations テーブル
対話成立データを持つテーブル
| カラム               | 型          | 説明                                                                     | 機能対応済み |
| -------------------- | ----------- | ------------------------------------------------------------------------ | :----------- |
| character_id         | INTEGER     | characters テーブルの id。ブロック追加後動作確認がまだ                   |              |
| start_count_video_id | UUID        | 対話成立のカウンターを始める動画。ブロック追加後動作確認がまだ           |              |
| count                | SMALLSERIAL | 対話成立のカウンターする数。ブロック追加後動作確認がまだ                 |              |
| play_video_id        | UUID        | 対話成立のカウンターが終わった場合流す動画。ブロック追加後動作確認がまだ |              |


# slots テーブル
（パターン）過去に再生した「A、B、C」動画があれば、Dを再生する機能用のテーブルです。

| カラム        | 型     | 説明                                                   | 機能対応済み |
| ------------- | ------ | ------------------------------------------------------ | :----------- |
| play_video_id | UUID   | check_ids が全部再生された場合流す動画。               |              |
| check_ids     | UUID[] | チェックしたい動画の id。ブロック追加後動作確認がまだ  |              |
| character_id  | SERIAL | characters テーブルの id。ブロック追加後動作確認がまだ |              |

# play_logs テーブル

| カラム       | 型           | 説明                     | 機能対応済み |
| ------------ | ------------ | ------------------------ | :----------- |
| id           | BIGSERIAL    | 主キー                   | ✔️         |
| character_id | SERIAL       | characters テーブルの id | ✔️         |
| video_id     | INTEGER      | videos テーブルの id     | ✔️         |
| start_time   | TIMESTAMP    | ログの時間               | ✔️         |
| title        | VARCHAR(255) | ログのタイトル           | ✔️         |
| comment      | TEXT         | ログのコメント           | ✔️         |

# connection_logs テーブル

| カラム       | 型          | 説明                     | 機能対応済み |
| ------------ | ----------- | ------------------------ | :----------- |
| id           | BIGSERIAL   | 主キー                   | ✔️         |
| origin       | VARCHAR(50) | 接続元                   | ✔️         |
| destination  | VARCHAR(50) | 接続先                   | ✔️         |
| character_id | SERIAL      | characters テーブルの id | ✔️         |
| time         | TIMESTAMP   | ログの時間               | ✔️         |
| action       | VARCHAR(50) | socket 通信の有無        | ✔️         |
| payload      | TEXT        | ログの内容               | ✔️         |

# error_logs テーブル

| カラム       | 型           | 説明                     | 機能対応済み |
| ------------ | ------------ | ------------------------ | :----------- |
| id           | BIGSERIAL    | 主キー                   | ✔️         |
| character_id | SERIAL       | characters テーブルの id | ✔️         |
| time         | TIMESTAMP    | エラーの時間             | ✔️         |
| origin       | VARCHAR(50)  | エラーの発生源           | ✔️         |
| code         | VARCHAR(255) | エラーコード             | ✔️         |
| message      | TEXT         | メッセージ               | ✔️         |
| stack        | TEXT         | エラースタック           | ✔️         |

# summary テーブル

| カラム               | 型       | 説明                                                   | 機能対応済み |
| -------------------- | -------- | ------------------------------------------------------ | ------------ |
| id                   | SERIAL   | 主キー                                                 |              |
| character_id         | SERIAL   | characters テーブルの id                               |              |
| start_video_id       | UUID     | スタート動画。videos テーブルの id                     |              |
| end_video_id         | UUID     | end 動画。videos テーブルの id                         |              |
| high_score           | SMALLINT | 基準の高いスコア                                       |              |
| high_score_video_id  | UUID     | high_score 以上の場合に流す動画。videos テーブルの id  |              |
| low_score            | SMALLINT | 基準の低いスコア                                       |              |
| low_score_video_id   | UUID     | low_score 以下の場合に流す動画。videos テーブルの id   |              |
| other_score_video_id | UUID     | それ以外のスコアの場合に流す動画。videos テーブルの id |              |

# summary_keyword テーブル

| カラム     | 型       | 説明                                   | 機能対応済み |
| ---------- | -------- | -------------------------------------- | ------------ |
| id         | SERIAL   | 主キー                                 |              |
| summary_id | SERIAL   | summary テーブルの id                  |              |
| keyword    | TEXT[]   | (例){痛い,痛む,痛く,痛かった}          |              |
| score      | SMALLINT | keyword に一致した場合に加算するスコア |              |

# kikiwasure テーブル

| カラム                 | 型        | 説明                                                                   | 機能対応済み |
| ---------------------- | --------- | ---------------------------------------------------------------------- | ------------ |
| id                     | BIGSERIAL | 主キー                                                                 |              |
| character_id           | SERIAL    | characters テーブルの id                                               |              |
| start_video_id         | UUID      | スタート動画。videos テーブルの id                                     |              |
| connecting_video_id    | UUID      | 再生していない動画が複数ある場合に、間に流す動画。videos テーブルの id |              |
| kikiwasure_positive_id | UUID      | kikiwasure_check の check_played_id を全部再生していない場合に流す動画 |              |
| kikiwasure_negative_id | UUID      | kikiwasure_check の check_played_id を全部再生していた場合に流す動画   |              |

# kikiwasure_check テーブル

| カラム          | 型        | 説明                                                                | 機能対応済み |
| --------------- | --------- | ------------------------------------------------------------------- | ------------ |
| id              | BIGSERIAL | 主キー                                                              |              |
| kikiwasure_id   | BIGSERIAL | kikiwasure テーブルの id                                            |              |
| check_played_id | UUID      | 再生していたか確認する動画。videos テーブルの id                    |              |
| play_video_id   | UUID      | check_played_id で再生していない場合に再生する videos テーブルの id |              |

# blocks テーブル

| カラム                     | 説明                                                                | 機能対応済み |
| -------------------------- | ------------------------------------------------------------------- | ------------ |
| id                         | 主キー                                                              | ✔️         |
| character_id               | どのキャラクターのブロックか                                        | ✔️         |
| title                      | ブロックの説明文                                                    | ✔️         |
| trigger_video_id           | ブロックの初めに流れる動画                                          | ✔️         |
| invalid_max_count          | 関係ない話の回数。指定した番号を超えたらブロックから出る            | ✔️         |
| invalid_final_video_id     | invalid_max_countが超えたら、飛ぶブロックのtrigger_video_id         | ✔️         |
| force_next_video_id        | 話し始めたら、強制で飛ぶブロックのtrigger_video_id                  | ✔️         |
| tag                        | 音声認識テキストに追加して送るテキスト                              | ✔️         |
| play_again                 | true:同じブロックに入る、false:同じブロックに入らない               | ✔️         |
| play_final_video           | ブロックに入らない時に流す動画                                      | ✔️         |
| max_recognition_time       | 音声認識テキストの自動確定時間                                      | ✔️         |
| spj_category               | spjのカテゴリーID                                                   | ✔️         |
| spj_empty_video_id         | spjからの回答が空白の場合に流す動画                                 | ✔️         |
| ~~listen_video_number~~    | 聞く動画の何番目を流すかの番号。個別設定に変更で、廃止予定          | ✔️         |
| chatbot_score_end          | スコアが低い時、ブロックを出るか（true）、聞く動画に戻るか（false） | ✔️         |
| chatbot_score_end_video_id | スコアが低かったら飛ぶブロックのtrigger_video_id                    | ✔️         |
| silence_time_limit         | 無言時間                                                            | ✔️         |
| silence_count              | 無言回数カウント                                                    | ✔️         |

# block_chatbot_scores テーブル
spjスコア。各ブロックで複数のスコア設定のため
| カラム              | 説明                                                         | 機能対応済み |
| ------------------- | ------------------------------------------------------------ | ------------ |
| id                  | 主キー                                                       | ✔️         |
| block_id            | ブロックID。何のブロックのchatbot_scoreか                    | ✔️         |
| low_video_id        | spj のスコアがチャットボットのスコアより低かった時に流す動画 | ✔️         |
| score               | チャットボットのスコア                                       | ✔️         |
| listen_video_number | 戻る聞く動画の順番                                           | ✔️         |


# block_invalid_responses テーブル（ランダム選択）
関係ない話があった時に再生する動画と戻る聞く動画の番号を設定するテーブル
| カラム                    | 説明                                                | 機能対応済み |
| ------------------------- | --------------------------------------------------- | ------------ |
| id                        | 主キー                                              | ✔️         |
| block_id                  | ブロックID。何のブロックのchatbot_scoreか           | ✔️         |
| invalid_response_video_id | 関係ない話に対して再生する動画ID                    | ✔️         |
| listen_video_number       | invalid_response_video_id後に戻る聞く動画の順番番後 | ✔️         |


# block_listen_videos テーブル
ブロックの聞き待ち動画テーブル。各ブロックで複数の聞き待ち動画設定のため
| カラム          | 説明                                     | 機能対応済み |
| --------------- | ---------------------------------------- | ------------ |
| id              | 主キー                                   | ✔️         |
| block_id        | ブロックID。どのブロックの聞き待ち動画か | ✔️         |
| listen_video_id | 聞き待ち動画                             | ✔️         |
| play_order      | ブロックで流す聞き待ち動画の順番         | ✔️         |



# block_nod_videos テーブル
うなずき動画を設定するテーブル（ランダム選択）
| カラム       | 説明         | 機能対応済み |
| ------------ | ------------ | ------------ |
| id           | 主キー       | ✔️         |
| block_id     | ブロックID。 | ✔️         |
| nod_video_id | うなずき動画 | ✔️         |

# block_replacement_videos テーブル
ブロックごとに設定できる動画ID・変換IDの機能のテーブル（ランダム選択）
| カラム                | 説明                                                                                                    | 機能対応済み |
| --------------------- | ------------------------------------------------------------------------------------------------------- | ------------ |
| id                    | 主キー                                                                                                  | ✔️         |
| block_id              | ブロックID。何のブロックのreplacement_videosか                                                          | ✔️         |
| video_id              | SPJからの変換される動画                                                                                 | ✔️         |
| converted_video_id    | 変換動画                                                                                                | ✔️         |
| check_played_video_id | 過去に再生した動画のチェック。B-5：過去再生動画IDによって、特定動画が来た時に、強制で動画を分岐させる。 | ✔️         |


# block_silence_final_videos テーブル
何回か無言になった後に、違うブロックに飛ぶ先を設定するテーブル（ランダム選択）
| カラム                 | 説明                                    | 機能対応済み |
| ---------------------- | --------------------------------------- | ------------ |
| id                     | 主キー                                  | ✔️         |
| block_id               | ブロックID。                            | ✔️         |
| silence_final_video_id | 飛ぶ先の動画ID：blocks.trigger_video_id | ✔️         |


# block_silence_videos テーブル
無言時に再生する動画と次に飛ぶ聞く動画の順番番号（ランダム選択）
| カラム              | 説明                                                                 | 機能対応済み |
| ------------------- | -------------------------------------------------------------------- | ------------ |
| id                  | 主キー                                                               | ✔️         |
| block_id            | ブロックID。                                                         | ✔️         |
| silence_video_id    | 無言時に再生する動画                                                 | ✔️         |
| listen_video_number | silence_video_id後に戻る聞く動画の順番番号（対応予定、今は頭に戻る） | ✔️         |


# block_skip_videos テーブル
スキップする動画のテーブル（ランダム選択）
| カラム        | 説明           | 機能対応済み |
| ------------- | -------------- | ------------ |
| id            | 主キー         | ✔️         |
| block_id      | ブロックID。   | ✔️         |
| skip_video_id | スキップ動画ID | ✔️         |


# block_valid_responses テーブル
関係ある動画を設定するテーブル
| カラム                  | 説明                                                                         | 機能対応済み |
| ----------------------- | ---------------------------------------------------------------------------- | ------------ |
| id                      | 主キー                                                                       | ✔️         |
| block_id                | ブロックID。                                                                 | ✔️         |
| valid_response_video_id | trigger動画に対して期待する（関係ある）動画。次に飛ぶblockのtrigger_video_id | ✔️         |


# block_words テーブル
spjに送る前にチェックする単語のテーブル
| カラム   | 説明                                           | 機能対応済み |
| -------- | ---------------------------------------------- | ------------ |
| id       | 主キー                                         | ✔️         |
| block_id | ブロックID。                                   | ✔️         |
| word     | 単語                                           | ✔️         |
| video_id | wordが一致したら飛ぶブロックのtrigger_video_id | ✔️         |

# block_word_parent_relationships テーブル
block_wordsの単語の関係性を設定するテーブル
| カラム    | 説明                          | 機能対応済み |
| --------- | ----------------------------- | ------------ |
| id        | 主キー                        | ✔️         |
| word_id   | 単語ID。block_wordsのid       | ✔️         |
| parent_id | 単語の親のID。block_wordsのid | ✔️         |


# character_start_buttons テーブル
キャラクターのスタートボタンデータを持つテーブル
| カラム       | 説明                                         | 機能対応済み |
| ------------ | -------------------------------------------- | ------------ |
| id           | 主キー                                       | ✔️         |
| character_id | スタート動画を設定したいキャラクターの ID    | ✔️         |
| video_id     | スタート動画（ブロックで存在する必要がある） | ✔️         |
| block_id     | video_id後に入るブロックの ID                | ✔️         |
