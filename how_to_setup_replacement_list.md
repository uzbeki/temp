# replacement（動画ID → 変換ID）
`replacement（動画ID → 変換ID）`とは、SPJから来た動画IDが来たら動画IDの代わりに変換IDの動画を再生させる機能です。

# データベース
> 注意：　video_idとconverted_video_idにはUUIDを記入してください。
### `block_replacement_videos`のテーブル
* `id` : serial number  
* `block_id` : blockのid  
* `video_id` : new_videosのid、変換したい動画のID  
* `converted_video_id` : new_videosのid、video_idの代わりに再生させる動画のID  
# 設定方法
1. pgAdmin4のアプリケーションを立ち上げます。
2. pgadminブラウザでtalk-withにあるblock_replacement_videosテーブルを探して右クリックしてView/Edit DataのAllRowsをクリックします。   
( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - block_replacement_videos )
3. 上記にある`データベース`を参考にしてデータを記入してください。    
4. F6ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
  ![代替リスト画面3](./images/pg/pgadmin/save_data(F6).png)
1. これで事前準備は完了しましたのでtalk-withアプリを立ち上げて確認します。