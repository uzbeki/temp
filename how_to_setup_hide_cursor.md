# hide_cursorとは
`hide_cursor`とは、マウスのカーソルを表示/非表示するかの機能です。

# 設定方法
1. pgAdmin4のアプリケーションを立ち上げます。
2. pgadminブラウザでtalk-withにあるproject_settingsテーブルを探して右クリックしてView/Edit DataのAllRowsをクリックします。      
   ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - project_settings )
   ![マウスカーソル画面1](./images/pg/pgadmin/open_the_project_settings_table.png)
3. `hide_cursor`の項目にチェックの有無で操作できます。チェックがし終わったらエンターをクリックしてください。（記入したい欄をダブルクリックすると編集ができます）  
   ![マウスカーソル画面2](./images/pg/functional_description_Img/hide_cursor/hide_cursor_list.png)
4. F6ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
  ![マウスカーソル画面3](./images/pg/pgadmin/save_data(F6).png)
5. これで事前準備は完了しましたのでtalk-withアプリを立ち上げて確認します。
