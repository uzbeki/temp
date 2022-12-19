# max_recognition_time とは

`max_recognition_time`とは、音声認識が確定されなかった場合、強制的に時間を測って SPJ へ送る機能です。

# 注意点

- max_recognition_time の設定はプロジェクト全体の設定とブロックごとの設定ができます。
- 優先順位は動画ごとの設定が優先です。  
  (プロジェクト全体の設定とブロックごとの設定、二つ全部あったら動画ごとの設定が作動)
- 設定するところ  
  プロジェクト全体の設定　：　 project_settings のテーブル  
  ブロックごとの設定　：　 blocks のテーブル
- 0 に設定した場合、機能しない。

# 設定方法 (プロジェクト全体の設定及び動画別の設定)

### [ プロジェクト全体の設定 ]

1. talk-with のアプリケーションを立ち上げてブラウザで localhost:3000/admin にアクセスします。
2. 管理画面のプロジェクト設定の max_recognition_time に設定したい数字を記入して変更ボタンを押してください。(　単位　：　１秒 = 1000 　)
   ![インストール画面2](./images/pg/functional_description_Img/max_recognition_time/max_recognition_admin_setting.png)

### [ 動画別の設定 ]

1. pgAdmin4 のアプリケーションを立ち上げます。
2. pgadmin ブラウザで talk-with にある blocks テーブルを探して右クリックして View/Edit Data の AllRows をクリックします。  
   ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - blocks )
3. `max_recognition_time`の項目に設定したい数字を記入します。記入がし終わったらエンター押してください。記入したい欄をダブルクリックすると編集ができます。(32767まで入力できます。)　 　　　
   ![インストール画面2](./images/pg/functional_description_Img/max_recognition_time/max_recognition_time_insert_data.png)
4. F6 ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
   ![インストール画面2](<./images/pg/pgadmin/save_data(F6).png>)
5. これで事前準備は完了しましたので talk-with アプリを立ち上げて確認します。
