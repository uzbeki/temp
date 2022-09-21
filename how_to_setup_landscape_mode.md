# Landscape_modeとは
`landscape_mode`とはキャラクターを選択する画面及びマイクを横モードまたは縦モードに設定する機能です。   
データベースのproject_settingsにあるlandscape_mode項目の設定によりコントロールが可能です。


方向 | landscape_mode
---------------|---------- 
横モード | true   
縦モード | false



# 使い方 (二つの方法：管理画面及びpgAdmin4アプリ)

[管理画面での設定]
1. talk-withのアプリケーションを立ち上げます。
2. ブラウザでlocalhost:3000/adminにアクセスします。
3. talk-withアプリの画面を縦にしたいとlandscape_modeをチェックせずに更新ボタンを押してください。
   ![インストール画面2](./images/landscape_mode/landscape_admin_false.png)
4. [ landscape_mode : 縦モード ]
![インストール画面2](./images/landscape_mode/selectPerson(false).png)
![インストール画面2](./images/landscape_mode/chat(false).png)
5. talk-withアプリの画面を横にしたいとlandscape_modeをチェックして更新ボタンを押してください。
   ![インストール画面2](./images/landscape_mode/landscape_admin_true.png)
6. [ landscape_mode : 横モード ]
![インストール画面2](./images/landscape_mode/selectPerson(true).png)
![インストール画面2](./images/landscape_mode/chat(true).png)

  

[pgAdmin4アプリでの設定]

1. pgAdmin4のアプリケーションを立ち上げます。
2. pgadminブラウザでtalk-withにあるproject_settingsテーブルを探します。   
   ( Servers - PostgreSQL - Databases - Talk-With - Schemas - public - Tables - project_settings )
3. project_settingsを右クリックしてView/Edit DataのAllRowsをクリックします。
   ![インストール画面2](./images/pg/pgadmin/open_the_project_settings_table.png)
4. 下の画面が見えます。
   ![インストール画面2](./images/landscape_mode/project_settings.png)
5. landscape_modeの項目の下にあるtrueが書いている欄をダブルクリックすると変更が可能になります。
   ![インストール画面2](./images/landscape_mode/landscape_mode(true).png)
   * trueの場合  
   ![インストール画面2](./images/landscape_mode/check(true).png)
   * falseの場合  
   ![インストール画面2](./images/landscape_mode/check(false).png)
6. 変更したら、エンターを押して赤いボックスでチェックされたところを押すか、F6ボタンを押してください。
   ![インストール画面2](./images/pg/pgadmin/save_data1.png)
7. これでデータベースのlandscape_nodeの設定は完了です。
8. talk-withのアプリケーションを立ち上げて確認してください。
> lnadscape_modeがtrueの場合　　　　
![インストール画面2](./images/landscape_mode/selectPerson(true).png)
![インストール画面2](./images/landscape_mode/chat(true).png)

> lnadscape_modeがfasleの場合
![インストール画面2](./images/landscape_mode/selectPerson(false).png)
![インストール画面2](./images/landscape_mode/chat(false).png)
