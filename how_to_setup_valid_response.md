# valid_response_video
ブロックに対する、有効な回答の動画を指定する。

# 例
「お腹が痛いです。」のブロックで、valid_response_videoの一部は以下である。
* 「昨日から」の動画
* 「先週から」の動画
* 「ずっと痛い」動画

# 流れ
1. SPJから来た動画をvalid_response_idsの中にあるかチェックする
あれば、
2. その動画のブロックを探して、移動します。
    - ブロックがなければエラーログを出力。「想定したことが話されたが、その回答動画。。。のブロックが存在しません。」
3. playLogに「想定したことが話されたため、その回答動画。。。のブロック。。。に移動します。」みたいに出力する。

# 設定方法
`block_valid_responses`テーブルに登録する。

## 例
* `id`：自動で登録される。
* `block_id`：`blocks`テーブルの「お腹が痛いです。」のid。valid_response_video_idを複数登録する場合は、同じblock_idを用いる。
* `valid_response_video_id`：`new_videos`テーブルのid。「昨日から」の動画のid