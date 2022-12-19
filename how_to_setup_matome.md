# まとめモード

summary.start_video_idだったら、まとめモードに入る。
1. summary.start_video_idを再生させる。
2. サーバーからのvideoDataイベントをsummary.end_video_idがくるまで無視する。
3. 音声認識テキストをまとめる。
4. playVideoイベントでsummary.end_video_idが来たら
  4-1. まとめたテキストの中にsummary_keyword.keywordが入っているかチェックする。
  4-2. 入っている場合は、summary_keyword.scoreを加算する。
  4-3. チェックが終わったら、加算した値をsummary.conclusion.total_high_score, total_low_score, otherと比べて、一致する動画を再生させる
5. サーバーからのplayVideoイベントをsummary.end_video_idがくるまで無視する処理を止める。

# 設定方法

## テーブルの作成
下記コマンドをpgAdminから実行してテーブルを作成する。
```sql
CREATE TABLE IF NOT EXISTS summary (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY, 
  user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  start_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  end_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  high_score INT DEFAULT 80 NOT NULL,
  high_score_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  low_score INT DEFAULT 50 NOT NULL,
  low_score_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  other_score_video_id UUID REFERENCES videos(id) ON DELETE CASCADE NOT NULL,
  CHECK(high_score >= low_score)
);

CREATE TABLE IF NOT EXISTS summary_keyword (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY, 
  summary_id UUID REFERENCES summary(id) ON DELETE CASCADE NOT NULL,
  keyword TEXT[] NOT NULL, -- {痛い,痛む,痛く,痛かった}
  score INT NOT NULL
);
```

## データの登録

### summaryテーブル
* id：自動で挿入される
* user_id：usersテーブルのid
* start_id：まとめモードに入るvideoテーブルのid
* end_video_id：まとめモードを終了するvideosテーブルのid
* high_score：このスコア以上のスコアだったらhigh_score_video_idを再生する (32767まで入力できます。)
* low_score：このスコア以下のスコアだったらlow_score_video_idを再生する (32767まで入力できます。)
* other_score_video_id：high_scoreからlow_scoreの間のスコアで再生されるvideosテーブルのid

### summary_keywordテーブル
* id：自動で挿入される
* summary_id：summaryテーブルのid
* keyword：(例) {痛い,痛む,痛く}
* score：keywordに一致した場合に加算するスコア (32767まで入力できます。)