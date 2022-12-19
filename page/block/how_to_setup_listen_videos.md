# listen_video

ブロックのトリガー動画を流した後、ブロック毎に設定した聞き動画を順番に流していく。

# 流れ

1. トリガー動画が流れた後、最初の聞き動画を再生。
   → 　聞き動画が無限ループ動画の場合、次の聞き動画にはいかない。
2. 2 番目の聞き動画再生。
3. 聞く動画がなくなったら停止。
   → 　 mic が off か、on でユーザーが何も話さない、無限ループではない動画の前提

# 設定方法

`block_listen_videos`テーブルに登録する。

## 例

- `id`：自動で登録される。
- `block_id`：`blocks`テーブルのトリガー動画の id。listen_video_id を複数登録する場合は、同じ block_id を用いる。
- `listen_video_id`：`new_videos`テーブルの id。聞き動画の id
- `play_order`：聞き動画を流す順番。(32767まで入力できます。)

# 追加設定
listen_video_idをloop設定するためには、videoごとに設定が必要。  

`new_videos`テーブに設定
* `loop` : true（loopになる）/ false（loopにならない）
* `loop_count` : loopする回数  

## 例
listen_videoを2回loopする場合  
* loop : true  
* loop_count : 2

listen_videoを無限loopにする場合  
* loop : true
* loop_count : 0

listen_videoをloopしない場合
* loop : false