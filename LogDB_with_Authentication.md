# ログに関するデータベースついて
管理画面のログページで表示されていたログをデータベースに更新する機能を作成しました。
下記のテーブルを作成しました。
1. エラーログテーブル：エラー発生箇所を発生時間と共に確認することができます。
2. 接続ログテーブル：音声認識から動画ＩＤ取得までの流れを確認することができます。
3. 再生動画ログテーブル：どのパートナーの動画が再生されたかを確認することができます。
   
4. セッションログテーブル：ログインしたユーザーのログイン状況を確認します。ログイン済みではない場合、ログイン後セッションが作成されます。



# 認証機能について
ログ機能を制作するにあたり、ユーザーの個人情報も管理している為、セキュリティの観点から認証機能を追加しました。ユーザーがログインした場合、一定期間であれば再度ログインすることがなく使用することができるようになりました。

その際、ご自身でして頂く設定がございます。
1. 上記４つのテーブル作成をお願いします。

  ＊データベースの操作方法についてはこちらを参考にしてください。 [DBの操作方法](./how_to_install_pg.md)

  ```sql
-- 再生動画ログテーブル
CREATE TABLE IF NOT EXISTS PLAY_LOG (
ID UUID DEFAULT gen_random_uuid() PRIMARY KEY,
SESSION_ID UUID,
USER_ID UUID,
VIDEO_ID INTEGER,
START_TIME TIMESTAMP NOT NULL,
TITLE VARCHAR(255),
COMMENT VARCHAR(255),
CONSTRAINT PLAY_LOG__USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(ID) ON DELETE CASCADE,
CONSTRAINT PLAY_LOG__SESSION_ID_FK FOREIGN KEY(SESSION_ID) REFERENCES SESSIONS(ID) ON DELETE CASCADE
);

-- 接続ログテーブル
CREATE TABLE IF NOT EXISTS CONNECTION_LOG (
ID UUID DEFAULT gen_random_uuid() PRIMARY KEY, 
SESSION_ID UUID,
ORIGIN VARCHAR(50),
DESTINATION VARCHAR(50),
TIME TIMESTAMP NOT NULL,
ACTION VARCHAR(50),
PAYLOAD VARCHAR(255),
CONSTRAINT CONNECTION_LOG__SESSION_ID_FK FOREIGN KEY(SESSION_ID) REFERENCES SESSIONS(ID) ON DELETE CASCADE
);

-- エラーログテーブル
CREATE TABLE IF NOT EXISTS ERROR_LOG (
ID UUID DEFAULT gen_random_uuid() PRIMARY KEY,
SESSION_ID UUID,
TIME TIMESTAMP NOT NULL, 
ORIGIN VARCHAR(50), 
CODE VARCHAR(255), 
MESSAGE VARCHAR(255), 
STACK VARCHAR(255),
CONSTRAINT ERROR_LOG__SESSION_ID_FK FOREIGN KEY(SESSION_ID) REFERENCES SESSIONS(ID) ON DELETE CASCADE
);

-- セッションログテーブル
CREATE TABLE SESSIONS (
ID UUID DEFAULT GEN_RANDOM_UUID() PRIMARY KEY,
USER_ID UUID NOT NULL, 
START_TIME TIMESTAMP NOT NULL, 
END_TIME TIMESTAMP, 
SESSION_TOKEN TEXT NOT NULL,
CONSTRAINT SESSIONS__USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES USERS(ID) ON DELETE CASCADE
);
  ```

2. .env.localにTOKEN_SECRET, NODE_ENV, USERNAME, PASSWORDを追加してください。

```
TOKEN_SECRET = qwjzcjkjvkjcjvjuvvvvvodpvpdvpodovdvodovodvdpvdvdvdvdvvfvkfvkvkxvvxovdpitink

NODE_ENV = production
USER_NAME = user_name
USER_PASSWORD = user_password
```
TOKEN_SECRETは24文字以上を使用していただければ問題ありません。NODE_ENVはそのまま使用してください。USER_NAMEとUSER_PASSWORDはご自身のユーザーテーブルの情報に修正してください。

3. 動作確認。

