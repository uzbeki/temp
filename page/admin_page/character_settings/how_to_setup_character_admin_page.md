# character_settingsテーブルの更新方法
`character_settingsテーブルの更新方法`とは、管理画面で追加されたキャラクターの詳細設定をすることです。（キャラクター名の右側にある詳細ボタンをクリックしてください。）

# 設定方法
* キャラー管理ボタンをクリックすると、キャラクターセッティングのページに移動されます。  
* キャラクターの情報を変更したい場合は該当キャラクターの詳細ボタンを押してください。
![admin_page9](../../../images/adminPage/character_settings_page.png)　　


## キャラクター情報（名前の変更）  
  * キャラクターの名前を変更する場合はキャラクター情報の支持を従ってください。
  ![キャラクター設定１](../../../images/add_character/character_settings/character_info.jpg)

## キャラクター設定  
  * 項目の機能は[データベース構成](./../../../DB.md)を参考にしてください。
  * `[必須] spj_url, spj_api_key, google_keyは記入`してください。
  * [動画選択] ボタンをクリックすると、動画が選択できる動画の一覧（パップアップ）が表示されます。追加したい動画はチェックボックスにチェックし、除去したい動画はチェックを外してください。（ちなみに [-]ボタンを押しても除去されます。 ）
  * 項目別の記入が終わったら、表の下にある"設定変更"保存されます。  

  <キャラクター選定画面>  
  ![キャラクター設定２](../../../images/add_character/character_settings/characterSettings.png)

  <動画の一覧（パップアップ）画面>
  ![キャラクター設定３](../../../images/add_character/character_settings/popup.png)


# 追加内容
## 設定ファイルのインポート 
  * キャラクターを追加する際にvideoSetting.csvファイルをインポートするところです。  
  ![キャラクター設定４](../../../images/add_character/character_settings/file_import.jpg)

## キャラクターの動画変換
  * キャラクターを追加する際、videoSetting.csvを送信した後、自動で開かれるディレクトリに動画を入れて"変換開始"ボタンを押しますとmp4の動画がm3u8の動画で変換させます。
  * ディレクトリ：talk-with/app/public/video/source/`(character_id)`  
    ![キャラクター設定５](../../../images/add_character/character_settings/video_conversion.jpg)

## 動画のアップロード
[動画のアップロード](./../../../how_to_setup_video_upload.md)を参考にしてください。

## 動画の設定修正・変更・削除
[動画の設定修正・変更・削除](../../../how_to_setup_video_settings.md)を参考にしてください。
