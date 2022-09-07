#!/bin/bash
set -e

function dockerRipository() {
    # 必要なファイルをインストール
    sudo apt install -y                     \\
                        curl                \\
                        gnupg-agent         \\
                        ca-certificates     \\
                        apt-transport-https \\
                        software-properties-common
    # リポジトリのセット
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
}

function dockerNewVersionGet() {
    sudo apt update
    sudo apt install docker-ce
}

function dockerVersionInstall() {
    sudo apt update
    sudo apt install -y docker-engine="$1~xenial"
}

function DockerGroupIdSet() {
    sudo usermod -aG docker ${USER}
    su - ${USER}
}

function packageCheck() {
    if printf '%s\n' `ls /usr/share` | grep -qx $1; then
        echo "true";
    else
        echo "false";
    fi
}


main() {
    DOCKER_INSTALL_TARGET_VERSION=$1
    # インストール済みをチェック
    if `packageCheck docker`; then
        # バージョンをチェック
        # 結果の代入
        RESULT=$(docker -v)
        # 置換後に配列として代入
        RESULT=(${RESULT//','/''})
        DOCKER_VERSION=${RESULT[2]}
        if [ DOCKER_VERSION = DOCKER_INSTALL_TARGET_VERSION ]; then
            exit 0;
        else 
            sudo apt remove docker docker-engine docker.io docker*
            
        fi
    else 
        dockerRipository
        dockerVersionInstall $DOCKER_INSTALL_TARGET_VERSION
        DockerGroupIdSet
    fi
}

# オプションの解析
# DOCKER_INSTALL: optin -n で最新の docker をインストール
while getopts n OPT
do
    case $OPT in 
        -n) 
            # 最新のバージョンでダウンロード
            dockerRipository
            dockerNewVersionGet
            DockerGroupIdSet
            exit 0
            ;;
        *)  main "20.10.17"
            ;;
    esac
done