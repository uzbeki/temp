@echo OFF
if exist C:\talk_with_block rmdir /s /q C:\talk_with_block

git -C C:\ clone git@github.com:uzbeki/talk_with.git talk_with_block && cd C:\talk_with_block && git checkout block && copy app\.env.sample app\.env.local && notepad app\.env.local

echo "notepadアプリが開かれました。必要な値を入れ保存し、notepadを閉じてください。閉じたら、こちらのコマンドプロンプトでEnterを押してお待ちください。"

pause
call setup_block.bat
