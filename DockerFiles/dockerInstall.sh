#!/bin/bash
set -e

DOCKER_INSTALL_TARGET_VERSION="20.10.17"

sudo apt update
sudo apt -y upgrade
sudo apt-get update
sudo apt-get -y upgrade

# オプションの解析
# DOCKER_INSTALL: optin n で最新の docker をインストール
DOCKER_INSTALL=true
while getopts n OPT
do
    case $OPT in 
        n) DOCKER_INSTALL=false ;;
        *) ;;
    esac
done

# 常に存在する場合
if $DOCKER_INSTALL; then
    # Docker インストール 確認
    ## whichでコマンドの存在確認
    DOCKER_CHECK=false
    if which docker > /dev/null; then DOCKER_CHECK=true; fi
    # # Docker バージョン 確認
    if $DOCKER_CHECK; then
        # 結果の代入
        RESULT=$(docker -v)
        # 置換後に配列として代入
        RESULT=(${RESULT//','/''})
        DOCKER_VERSION=${RESULT[2]}
    fi

    # 現在のバージョンを削除
    if [ DOCKER_INSTALL_TARGET_VERSION -eq DOCKER_VERSION ]; then 
        exit 0
    else 
        sudo apt-get remove docker docker-engine docker.io
        sudo apt-get install -y docker-engine=$DOCKER_INSTALL_TARGET_VERSION
    fi
    exit 0
else
    # 最新のバージョンをダウンロード
    curl https://get.docker.com | sh && sudo systemctl --now enable docker
    sudo usermod -aG docker ${USER}
    exit 0
fi

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-engine=$DOCKER_INSTALL_TARGET_VERSION
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG