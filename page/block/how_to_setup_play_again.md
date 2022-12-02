# play_again
play_againはブロックが2回目から再度再生していいかどうかのフラグです。
trueの場合は、何回もブロックを再生できます。
falseの場合は、blocksテーブルのplay_final_video_idで設定しているtrigger_video_idのブロックに移動します。

# 設定方法
`blocks`テーブルを編集する。
* play_again: true / false
* play_final_video_id: play_againがfalseの場合に、このidのtrigger_video_idのブロックに移動する。