# データベース構成

アプリで使用しているデータベースの一覧を説明する。

# usersテーブル
|カラム|型|説明|
|---|---|---|
|id|UUID|主キー。自動で生成される。|
|name|VARCHAR(255)|名前|
|email|VARCHAR(255)|メールアドレス|
|password|VARCHAR(255)|パスワード|
|is_admin|BOOLEAN|管理者かどうか|

# charactersテーブル
|カラム|型|説明|
|---|---|---|
|id|SERIAL|主キー。自動で生成される。|
|name|VARCHAR(255)|名前|
|owner_id|UUID|usersテーブルのid。キャラクターのオーナー。|

# videosテーブル
|カラム|型|説明|
|---|---|---|
|id|UUID|主キー。自動で生成される。|
|character_id|SERIAL|charactersテーブルのid|
|path|VARCAHAR(255)|動画があるディレクトリのパス|
|original_id|INTEGER|α版で使っている動画ID|
|original_next_id|INTEGER[]|α版で使っている動画IDのnext_id|
|title|VARCHAR(255)|拡張子無しの動画のファイル名|
|action|VARCHAR(10)| jump, loop, end, skip|
|loop_count|SMALLINT|何回ループするか|
|next_video_id|UUID[]|次に再生する動画|
|mic_on|BOOLEAN|動画再生中にマイクをオンにするか|
|play_now|BOOLEAN|すぐに再生するか|
|mic_on_millisecond|SMALLINT|マイクオンにするまでの時間(ミリ秒)|
|comment|VARCHAR(255)|分かりやすくするためのコメント|
|play_again|BOOLEAN|2度再生するのを許可するか|
|nod_video_id|UUID[]|videosテーブルのid。うなずき動画|
|force_video_id|UUID[]|強制再生動画（SPJから戻ってきたIDを無視し、これを再生させる。）|
|silence_time_limit|SMALLINT|無言時間,|
|silence_video_id|UUID[]|videosテーブルのid。無言時間を超えた場合に流す動画。|
|silence_count|SMALLINT|無言回数|
|silence_final_video_id|UUID[]|videosテーブルのid。無言回数を超えた場合に流す動画。|
|tag|VARCHAR(255)|SPJにタグを付けて送信する|
|spj_category|SMALLINT|SPJのカテゴリー|
|hit_words|JSON|認識された音声に特定単語がある場合、事前に用意した動画を流すための特定単語|
|replacement_list|JSON|spjから来た動画のidを他の動画のidに変換する|
|max_recognition_time|SMALLINT|設定した時間になったら認識した音声を強制的にSPJへ送る|

# character_settingテーブル
|カラム|型|説明|
|---|---|---|
|character_id|SERIAL|主キー。charactersテーブルのid|
|start_video_id|UUID[]|videosテーブルのid。start動画|
|listening_video_id|UUID[]|videosテーブルのid。listen動画|
|speech_unrecognized_video_id:|UUID[]|videosテーブルのid。言葉を認識できなかった場合に流す動画|
|silence_time_limit|SMALLINT|無言時間|
|silence_video_id|UUID[]|無言時間を超えた場合に流す動画|
|silence_count|SMALLINT|無言回数|
|silence_final_video_id|UUID[]|videosテーブルのid。無言回数を超えた場合に流す動画。|
|silence_enabled|BOOLEAN|silence機能を有効にするか|
|chatbot_score|FLOAT(2)|0~1。|
|chatbot_score_video_id|UUID|videosテーブルのid|  


# project_settingsテーブル
|カラム|型|説明|
|---|---|---|
|id|smallserial|主キー|
|use_web_speech_api|BOOLEAN|ブラウザのSpeech-to-Textを使うか|
|landscape_mode|BOOLEAN|ディスプレイが横型で使用するか|
|max_recognition_time|INTEGER|音声認識が確定されない場合、強制的に送るための時間設定|
|show_speech_recognition_result|BOOLEAN|音声認識の結果を画面に表示するか|
|hide_cursor|BOOLEAN|カーソルを隠すか|
|standby_video_id|UUID|videosテーブルのid。待機中に流す動画。|

# conversationsテーブル
|カラム|型|説明|
|---|---|---|
|character_id|INTEGER|charactersテーブルのid|
|start_count_video_id|UUID|対話成立のカウンターを始める動画|
|count|SMALLSERIAL|対話成立のカウンターする数|
|play_video_id|UUID|対話成立のカウンターが終わった場合流す動画|

# chatbot_scoresテーブル
|カラム|型|説明|
|---|---|---|
|id|SERIAL|主キー|
|video_id|UUID|videosテーブルのid。どの動画のscoreか。|
|score|FLOAT(2)|0~1。|
|low_video_id|UUID|videosテーブルのid。scoreより低い場合に流す動画|

# slotsテーブル
|カラム|型|説明|
|---|---|---|
|play_video_id|UUID|check_idsが全部再生された場合流す動画|
|check_ids|UUID[]|チェックしたい動画のid|
|character_id|SERIAL|charactersテーブルのid。|

# play_logsテーブル
|カラム|型|説明|
|---|---|---|
|id|BIGSERIAL|主キー|
|character_id|SERIAL|charactersテーブルのid|
|video_id|INTEGER|videosテーブルのid|
|start_time|TIMESTAMP|ログの時間|
|title|VARCHAR(255)|ログのタイトル|
|comment|TEXT|ログのコメント|

# connection_logsテーブル
|カラム|型|説明|
|---|---|---|
|id|BIGSERIAL|主キー|
|origin|VARCHAR(50)|接続元|
|destination|VARCHAR(50)|接続先|
|character_id|SERIAL|charactersテーブルのid|
|time|TIMESTAMP|ログの時間|
|action|VARCHAR(50)||
|payload|TEXT|ログの内容|

# error_logsテーブル
|カラム|型|説明|
|---|---|---|
|id|BIGSERIAL|主キー|
|character_id|SERIAL|charactersテーブルのid|
|time|TIMESTAMP|エラーの時間|
|origin|VARCHAR(50)|エラーの発生源|
|code|VARCHAR(255)|エラーコード|
|message|TEXT|メッセージ|
|stack|TEXT|エラースタック|

# summaryテーブル
|カラム|型|説明|
|---|---|---|
|id|SERIAL|主キー|
|character_id|SERIAL|charactersテーブルのid|
|start_video_id|UUID|スタート動画。videosテーブルのid|
|end_video_id|UUID|end動画。videosテーブルのid|
|high_score|SMALLINT|基準の高いスコア|
|high_score_video_id|UUID|high_score以上の場合に流す動画。videosテーブルのid|
|low_score|SMALLINT|基準の低いスコア|
|low_score_video_id|UUID|low_score以下の場合に流す動画。videosテーブルのid|
|other_score_video_id|UUID|それ以外のスコアの場合に流す動画。videosテーブルのid|

# summary_keywordテーブル
|カラム|型|説明|
|---|---|---|
|id|SERIAL|主キー|
|summary_id|SERIAL|summaryテーブルのid|
|keyword|TEXT[]|(例){痛い,痛む,痛く,痛かった}|
|score|SMALLINT|keywordに一致した場合に加算するスコア|

# kikiwasureテーブル
|カラム|型|説明|
|---|---|---|
|id|BIGSERIAL|主キー|
|character_id|SERIAL|charactersテーブルのid|
|start_video_id|UUID|スタート動画。videosテーブルのid|
|connecting_video_id|UUID|再生していない動画が複数ある場合に、間に流す動画。videosテーブルのid|
|kikiwasure_positive_id|UUID|kikiwasure_checkのcheck_played_idを全部再生していない場合に流す動画
|kikiwasure_negative_id|UUID|kikiwasure_checkのcheck_played_idを全部再生していた場合に流す動画|

# kikiwasure_checkテーブル
|カラム|型|説明|
|---|---|---|
|id|BIGSERIAL|主キー|
|kikiwasure_id|BIGSERIAL|kikiwasureテーブルのid|
|check_played_id|UUID|再生していたか確認する動画。videosテーブルのid|
|play_video_id|UUID|check_played_idで再生していない場合に再生するvideosテーブルのid|

# blockテーブル
未定
