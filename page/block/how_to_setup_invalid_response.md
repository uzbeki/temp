# invalid_response_video
ブロックに対する、関係ない回答をした際に、再生する動画を指定する。



## 関係ない動画をどのように判断するか
ブロックのvalid_responses（期待している回答）に設定されている回答以外の全てが`関係ない回答`として扱われます。そのため、ブロックのvalid_responses（期待している回答）に何も設定していなかった場合、`全て有効な回答`として扱われ、本機能は機能しませんので、ご注意ください。また、合わせて、block_invalid_responseテーブルのinvalid_response_video_idを設定しないと、関係ない回答時に何も再生できないため、機能しません。

### 機能する条件
1. block_valid_responsesテーブルに期待している回答を登録する
2. block_invalid_responsesテーブルに関係ない回答時に再生する動画を登録する
3. invalid_max_countを設定する（何回まで関係ない回答を許すか。）
4. invalid_final_video_idを設定する（期待している回答でなかった回数がinvalid_max_countを超えた場合に、遷移するブロックのtrigger_video_idを入れる）

### `blocks`テーブルの invalid_max_count と invalid_final_video_id について

- `invalid_max_count`：`invalid_final_video_id`を関係ない話の何回目に流すかのカウント。(32767まで入力できます。)
- `invalid_final_video_id`：関係ない回答の最後に流す動画。

ブロックの中に上記の内容がセットされていない場合、関係ない話を何回してもブロックから出ない。

## 関係ない回答の回数はどのようにカウントされるか

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
