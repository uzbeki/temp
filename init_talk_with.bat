@echo OFF
if exist C:\talk_with rmdir /s /q C:\talk_with

git -C C:\ clone -b main git@github.com:uzbeki/talk_with.git && cd C:\talk_with && copy app\.env.sample app\.env.local && notepad app\.env.local

echo "notepadアプリが開かれました。必要な値を入れ保存し、notepadを閉じてください。閉じたら、こちらのコマンドプロンプトでEnterを押してお待ちください。"

pause
call setup.bat
