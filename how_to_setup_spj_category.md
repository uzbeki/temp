# spj_categoryとは
`spj_category`とは、動画ごとにSPJのカテゴリ設定ができることです。

# 注意点
spj_categoryの設定は `動画ごとの設定` と `Visual Studio Codeアプリの.env.localファイルでの設定`ができです。

* spj_categoryを.env.localのファイルでを指定しなくてもアプリは作動します。  

* spj_category設定の状況別の説明
  動画|.env.local|状況
  ----|----------|----
  O|O|動画のspj_categoryを使う（動画ごとの設定が優先）
  O|X|動画のspj_categoryを使う
  X|O|.env.localのspj_categoryを使う
  X|X|事前に設定した動画が再生させる
# 流れ
### [動画ごとに設定した場合]
１．動画（spj_category:100）が再生している  
２．ユーザーが "昨日からです" と言ったら  
３．該当spj_categoryの "昨日からです" の回答動画を再生する。

# 設定方法 (動画ごとの設定)
1. pgAdmin4のアプリケーションを立ち上げます。
2. pgadminブラウザでtalk-withにあるvideosテーブルを探して右クリックしてView/Edit DataのAllRowsをクリックします。    
  ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - videos )
  ![SPJカテゴリ画面1](./images/pg/pgadmin/open_the_videos_table.png)
3. `spj_category`の項目にカテゴリ番号を記入します。記入がし終わったらエンターを押してください。（記入したい欄をダブルクリックすると編集ができます）  
  ![SPJカテゴリ画面2](./images/pg/functional_description_Img/spj_category/spj_category_list.png)
4. F6ボタン又は画面上にあるボタン（下のイメージを参考）をクリックしたら保存できます。
  ![SPJカテゴリ画面3](./images/pg/pgadmin//save_data(F6).png)    
5. これで事前準備は完了しましたのでtalk-withアプリを立ち上げて確認します。
