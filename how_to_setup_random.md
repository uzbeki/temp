# ランダム再生とは

テーブルに指定する動画を複数設定でき、その中からランダムで1つ再生される。

# 対象項目

## videosテーブル
* original_next_id
* next_video_id
* nod_video_id
* force_video_id
* silence_video_id
* silence_final_video_id

## user_settingsテーブル
* start_video_id
* listening_video_id
* speech_unrecognized_video_id
* silence_video_id
* silence_final_video_id

# 設定方法

1. テーブルの型の変更
**変更していない場合に1度だけ実行する。**
* 確認方法
　上記の対象項目を`pgAdmin`で開き、カラムのヘッダーに`uuid[]`と記載されていれば変更されている。
* 変更方法
　下記のSQLをpgAdminから実行する。Servers > ... > Databases > Talk-With > Schemas > public > Tables > 右クリック > Query Tool
 ```sql
 -- start_video_id
ALTER TABLE user_settings DROP CONSTRAINT user_settings__start_video_fk;
ALTER TABLE user_settings ALTER COLUMN start_video_id TYPE VARCHAR(255); -- tmp
UPDATE user_settings SET start_video_id = '{'||start_video_id||'}';
ALTER TABLE user_settings ALTER COLUMN start_video_id TYPE UUID[] USING start_video_id::UUID[];
-- silence_video_id
ALTER TABLE user_settings ALTER COLUMN silence_video_id TYPE VARCHAR(255); -- tmp
UPDATE user_settings SET silence_video_id = '{'||silence_video_id||'}';
ALTER TABLE user_settings ALTER COLUMN silence_video_id TYPE UUID[] USING silence_video_id::UUID[];
-- silence_final_video_id
ALTER TABLE user_settings ALTER COLUMN silence_final_video_id TYPE VARCHAR(255); -- tmp
UPDATE user_settings SET silence_final_video_id = '{'||silence_final_video_id||'}';
ALTER TABLE user_settings ALTER COLUMN silence_final_video_id TYPE UUID[] USING silence_final_video_id::UUID[];
-- listening_video_id
ALTER TABLE user_settings DROP CONSTRAINT user_settings__listening_video_fk;
ALTER TABLE user_settings ALTER COLUMN listening_video_id TYPE VARCHAR(255); -- tmp
UPDATE user_settings SET listening_video_id = '{'||listening_video_id||'}';
ALTER TABLE user_settings ALTER COLUMN listening_video_id TYPE UUID[] USING listening_video_id::UUID[];
-- speech_unrecognized_video_id
ALTER TABLE user_settings ALTER COLUMN speech_unrecognized_video_id TYPE VARCHAR(255); -- tmp
UPDATE user_settings SET speech_unrecognized_video_id = '{'||speech_unrecognized_video_id||'}';
ALTER TABLE user_settings ALTER COLUMN speech_unrecognized_video_id TYPE UUID[] USING speech_unrecognized_video_id::UUID[];

ALTER TABLE videos ALTER COLUMN nod_video_id TYPE VARCHAR(255); -- tmp
UPDATE videos SET nod_video_id = '{'||nod_video_id||'}';
ALTER TABLE videos ALTER COLUMN nod_video_id TYPE UUID[] USING nod_video_id::UUID[];
-- force_video_id
ALTER TABLE videos ALTER COLUMN force_video_id TYPE VARCHAR(255); -- tmp
UPDATE videos SET force_video_id = '{'||force_video_id||'}';
ALTER TABLE videos ALTER COLUMN force_video_id TYPE UUID[] USING force_video_id::UUID[];
-- silence_video_id
ALTER TABLE videos ALTER COLUMN silence_video_id TYPE VARCHAR(255); -- tmp
UPDATE videos SET silence_video_id = '{'||silence_video_id||'}';
ALTER TABLE videos ALTER COLUMN silence_video_id TYPE UUID[] USING silence_video_id::UUID[];
-- silence_final_video_id
ALTER TABLE videos ALTER COLUMN silence_final_video_id TYPE VARCHAR(255); -- tmp
UPDATE videos SET silence_final_video_id = '{'||silence_final_video_id||'}';
ALTER TABLE videos ALTER COLUMN silence_final_video_id TYPE UUID[] USING silence_final_video_id::UUID[];
-- next_video_id
ALTER TABLE videos ALTER COLUMN next_video_id TYPE VARCHAR(255); -- tmp
UPDATE videos SET next_video_id = '{'||next_video_id||'}';
ALTER TABLE videos ALTER COLUMN next_video_id TYPE UUID[] USING next_video_id::UUID[];
-- original_next_id
ALTER TABLE videos ALTER COLUMN original_next_id TYPE VARCHAR(255); -- tmp
UPDATE videos SET original_next_id = '{'||original_next_id||'}';
ALTER TABLE videos ALTER COLUMN original_next_id TYPE INT[] USING original_next_id::INT[];
```

2. 新規登録する場合
テーブルに新規に値を登録する場合は、全体を`{}`で囲む

3. 追加する場合
値を追加する場合は、値を`,`で区切る。(空白は入れない)