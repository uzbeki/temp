# 聞き忘れモード

kikiwasure.start_video_idだったら、聞き忘れモードに入る。：動画の再生中にマイクはOFFになることが前提（マイクはOFF）。
1. playLogsの中にsummary.end_video_idが存在したら＋playLogsの中にkikiwasure.start_video_idが存在しなかったら
2. kikiwasure.start_video_idを再生させる。
3-A. playLogsの中にkikiwasure.check_idsのキーが全部あれば、kikiwasure_negative_idを再生させる。終わり。対話に戻る。
3-B. 一つでもplayLogsの中にkikiwasure.check_idsのキーが足りなければ（再生していないのがあれば）、
    1. サーバーからのplayVideoイベントを無視する。
    2. 足りないキーのvalue（kikiwasure.check_ids.key）の動画を再生させる。複数あったら、間にkikiwasure.connecting_video_idを入れてをすべて再生させる。
    3. kikiwasure_positive_idを再生させる。
    4. サーバーからのplayVideoイベントを無視する処理を停止する。

# 設定方法

## テーブルの作成
下記コマンドをpgAdminから実行する。
```sql
CREATE TABLE IF NOT EXISTS kikiwasure (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY, 
  user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  start_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  connecting_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  kikiwasure_positive_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  kikiwasure_negative_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE IF NOT EXISTS kikiwasure_check (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY, 
  kikiwasure_id UUID REFERENCES kikiwasure(id) ON DELETE CASCADE NOT NULL,
  check_played_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  play_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL
);
```

## データの登録

### kikiwasureテーブル
* id：自動で挿入される
* user_id：usersテーブルのid
* start_video_id：聞き忘れモードに入るvideosテーブルのid
* connecting_video_id：複数再生させる場合に間に再生させるvideosテーブルのid
* kikiwasure_positive_id：再生していない動画があった場合に最後に再生させるvideosテーブルのid
* kikiwasure_negative_id：再生していない動画がなかった場合に再生させるvideosテーブルのid

### kikiwasure_checkテーブル
* id：自動で挿入される
* kikiwasure_id：kikiwasureテーブルのid
* check_played_id：再生したかを判定するvideosテーブルのid
* play_video_id：check_played_idで再生していないという判定の場合に再生するvideosテーブルのid
