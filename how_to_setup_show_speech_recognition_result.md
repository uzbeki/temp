# show_speech_recognition_resultとは
`show_speech_recognition_result`とは、画面上でマイク及びテキストの表示/非表示を設定する機能です。

# 設定方法
1. pgAdmin4のアプリケーションを立ち上げます。
2. pgadminブラウザでtalk-withにあるproject_settingsテーブルを探して右クリックしてView/Edit DataのAllRowsをクリックします。      
   ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - project_settings )
   ![音声認識結果画面1](./images/pg/pgadmin/open_the_project_settings_table.png)
3. `show_speech_recognition_result`の項目にチェックの有無で操作できます。チェックがし終わったらエンターをクリックしてください。（記入したい欄をダブルクリックすると編集ができます）  
   ![音声認識結果画面2](./images/pg/functional_description_Img/fullscreen/fullscreen_list.png)
4. F6ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
  ![音声認識結果画面3](./images/pg/pgadmin/save_data(F6).png)
5. これで事前準備は完了しましたのでtalk-withアプリを立ち上げて確認します。
