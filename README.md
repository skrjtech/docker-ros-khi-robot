# Docker Ros khi-robot 
## NEDO特別講座 
NEDO特別講座で扱う川崎重工株式会社公開のパッケージkhi-robotを動かす為の環境づくりを提供します.

# Docker Engine Install
講座内容に合わせる為に指定のバージョンでDocker Engineをインストールすることができます. \
もし既にインストールされている場合は, 指定のバージョンで簡単に再インストールができるようにスクリプトを用意しています. \
注意) Docker Engineの再インストールの際にイメージファイルが削除されます．
※ Ubuntu 18.04
```
. installer/docker.sh 5:20.10.21~3-0~ubuntu-bionic
```
※ Ubuntu OS が異なる場合 (18.04 ~ 22.10まで確認済み)
```
. installer/docker.sh 5:20.10.21~3-0~ubuntu-$(lsb_release -sc)
```
# Docker Engine Ros環境イメージの構築
Ros環境イメージを構築するDockerfileをビルドします. \
ビルドの際にDocker Composeでymlファイルを経由してビルドします.
```
docker compose -f docker/docker-compose.yml build
```
しばらく経つとビルドが終わり, 下記の様に環境イメージが作成される.
```
docker images
```
|REPOSITORY|TAG|IMAGE ID|CREATED|SIZE|
|:---|:---|:---|:---|:---|
|ros/melodic|latest|XXXXXXXX|X minutes ago|XXXXGB|

## Docker Engine Ros環境イメージの起動
Ros環境イメージの起動には, Docker Composeでymlファイルを指定して仮想環境
を起動します. \
Docker Composeでの起動の際には, バックグランドオプションの'-d'を指定して起動します.
```
docker compose -f docker/docker-compose.yml up -d
```
仮想環境内でgazebo/rvizその他のGUI系アプリを使用していく為, ホスト側で仮想環境内のアプリを表示する許可を行います.
```
xhost +local:
```
上記の動作を行わないと下記の様な注意が表示されます \
`root@virtualenv:~$ rosrun rviz rviz` \
`QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-venv'` \
`Authorization required, but no authorization protocol specified` \
`qt.qpa.screen: QXcbConnection: Could not connect to display :0.0` \
`Could not connect to any X display.` 

### 環境が立ち上がったらgazeboとrvizの起動の確認
### いくつかのステップを踏んで動作をさしていく
tmuxの立ち上げ
```
tmux  
```
立ち上げ先でroscoreを起動
```
roscore 
```
[ Ctrl+b ]を押した後に[ c ]を押し新しいウィンドウを起動
新しいウィンドウを起動したrvizを起動する
```
rosrun rviz rviz
```
gazeboの起動もrvizの立ち上げと同様に行う
## 注意 GUIが正常に起動しない時の対処
計算機の環境, ホスト側がDockerの仮想環境に影響を与えている場合があることでしょう\
以下の例で
* GUIが起動するが一瞬で立ち上がって消える現象 \
    exportに`SVGA_VGPU10=0`を追加することで表示が可能になった \
    ホスト側とコンテナ側に追加
* 立ち上がる前にグラフィックの影響でエラーがでる現象 \
    ホスト側のグラフィックドライバーを消すことによって表示が可能になった \
    グラフィックドライバーを消すことでCPUのみの動作になってしまうことが難点 \
    只今模索中
* VMWare上でのGUIの表示でうまくいかない現象 \
    exportに`SVGA_VGPU10=0`を追加することで表示が可能になった \
    ホスト側とコンテナ側に追加
* など...

# 構築環境・途中構築環境のコミット
環境内で何かしらの構築が終わった場合(パッケージのインストール, など), 作業のやり直しを防げます
```
docker ps -a
```
|CONTAINER ID|IMAGE|COMMAND|CREATED|STATUS|PORTS|NAMES|
|---|---|---|---|---|---|---|
|1a057534c395|ros/melodic:cpu|"/bin/bash"|0 minutes ago|Up 0 minutes||gifted_shaw|

$ `docker commit CONTAINERID IMAGE` 
```
docker commit 1a057534c395 ros/melodic:cpu-step1
```

# エラー発生・原因・対処について
