# invalid_response_video

ブロックに対する、関係ない回答の動画を指定する。

### `blocks`テーブルの invalid_max_count と invalid_final_video_id について

- `invalid_max_count`：`invalid_final_video_id`を関係ない話の何回目に流すかのカウント。(32767まで入力できます。)
- `invalid_final_video_id`：関係ない回答の最後に流す動画。

ブロックの中に上記の内容がセットされていない場合、関係ない話を何回してもブロックから出ない。

### カウントされる条件

- spj からのスコアが chatbot_score より低かった場合
- invalid_response 動画を再生した場合

# 流れ

1. SPJ から来た動画を invalid_response_ids の中にあるかチェックする
2. ランダムで invalid_response_ids の中の動画を再生
3. `invalid_max_count`が 0 になったら、invalid_final 動画を再生して、そのブロックから出る。

# 設定方法

`block_invalid_responses`テーブルに登録する。

## 例

- `id`：自動で登録される。
- `block_id`：`blocks`テーブルの id。invalid_response_video_id を複数登録する場合は、同じ block_id を用いる。
- `invalid_response_video_id`：`new_videos`テーブルの id。関係ないことを言ったときに流したい動画の id
