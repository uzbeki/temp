# 強制再生とは
`強制再生`とは、ユーザーが何を言っても事前に指定した動画を強制的に再生させる機能です。

# 設定方法
1. pgAdmin4のアプリケーションを立ち上げます。
2. pgadminブラウザでtalk-withにあるvideosテーブルを探して右クリックしてView/Edit DataのAllRowsをクリックします。    
  ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - videos )
  ![強制再生画面1](./images/pg/pgadmin/open_the_videos_table.png)
3. `force_video_id`の項目に下記のような型式でデータを記入します。記入がし終わったらOKボタンを押してください。（記入したい欄をダブルクリックすると編集ができます）   
  ![強制再生画面2](./images/pg/functional_description_Img/force_video_id/force_video_id_list.png)    
4. F6ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
  ![強制再生画面3](./images/pg/pgadmin/save_data(F6).png)    
5. これで事前準備は完了しましたのでtalk-withアプリを立ち上げて確認します。