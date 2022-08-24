  1. [Install ](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui#install-openssh-for-windows)  
    `Settings` => `Apps` => `Optional Features` => `OpenSSH Client`をインストール
  2. Powershellで管理者になって以下のコマンドを実行し、`OpenSSH-Client`を自動起動するように設定する：
    ```powershell
    # Set the sshd service to be started automatically
    Get-Service -Name sshd | Set-Service -StartupType Automatic

    # Now start the sshd service
    Start-Service sshd
    ```
  3. [新しいSSHキーの作成](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement#host-key-generation)  コマンドで以下を実行
    ```powershell
    ssh-keygen -t ed25519
    ```
  4. Give public key to `beki@asterone.co.jp` to set up ssh read access to source code