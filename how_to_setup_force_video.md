# 強制再生とは

`強制再生`とは、ユーザーが何を言っても事前に指定した動画を強制的に再生させる。

ブロックの聞き待ち動画が再生中、音声認識が確定し SPJ にテキストを送る前：
force_next_video_id.play_now が true だったら、すぐにブロックを移動。false だったら、再生中の動画が終わってから違うブロックに移動。

# 設定方法

強制再生させたいブロックの force_next_video_id に設定。

```
質問動画 => 待ち受け動画 => 強制再生動画(違うブロックへ)
trigger_video => listen_video => force_next_video
```

# DB 設定方法

1. pgAdmin4 のアプリケーションを立ち上げます。
2. pgadmin ブラウザで talk-with にある blocks テーブルを探して右クリックして View/Edit Data の AllRows をクリックします。  
   ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - blocks )
   ![強制再生画面1](./images/pg/pgadmin/open_the_videos_table.png)
3. `force_video_id`の項目に下記のような型式でデータを記入します。記入がし終わったら OK ボタンを押してください。（記入したい欄をダブルクリックすると編集ができます）  
   ![強制再生画面2](./images/pg/functional_description_Img/force_video_id/force_video_id_list.png)
4. F6 ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
   ![強制再生画面3](<./images/pg/pgadmin/save_data(F6).png>)
5. これで事前準備は完了しましたので talk-with アプリを立ち上げて確認します。
