# チャットボットスコアついて
SPJから回答のscoreが来たら、chatbot_scoresに設定されているものと比較し、低かったら:
chatbot_score_endをチェックし、
- trueだったら、low_video_idを再生した後に、chatbot_score_end_video_idで設定されているtrigger_video_idのブロックに移動。
chatbot_score_end_video_idが設定されていなかったら、エラーログに「スコア。。。が低く、別のブロックに移動しようとしたが、移動先のchatbot_score_end_video_idが設定されていません。」みたいに出す。
- falseだったら、low_video_idを再生した後に、listen_video_idsのplay_orderがlisten_video_numberの聞く動画に戻ります。playLogに「スコア。。。が。。。より低いため、。。。を再生します。」みたいに出す。


# 設定方法
`block_chatbot_scores`テーブルと`character_settings`テーブルを設定します。`block_chatbot_scores`の設定が優先されます。
## block_chatbot_scoresテーブル
複数段階のspjスコア判定が可能。
 例）スコア判定を２段階設定することでスコアによって流す動画を切り替えることができます。
 　一段階スコア：0.3未満
 　二段階スコア：0.6未満
＊スコアが低いものから判定スタート。
   
  spjからのスコアが0.5だった場合、一段階突破、二段階目で設定されたらlow_video_idの動画が流れます。
  
* id - 自動作成される番号
* block_id - blocksテーブルのID
* score: 0.1 - 1.0のスケール
* low_video_id - spjスコアがチャットボットスコアより低かった場合に流す動画。new_videosテーブルのid

## character_settingsテーブル
　spjのスコアが選択したパートナーのチャットボットスコアより低い場合の処理。

* chatbot_score: 0.1 - 1.0のスケール
* chatbot_low_score_video_id: スコアが低かった時に再生したい動画IDを入れてください。
＊chatbot_low_score_video_idが空の場合、何も処理されません。

