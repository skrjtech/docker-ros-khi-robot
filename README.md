# docker-ros 
### スムーズな環境づくりを目的にDockerに挑戦!!

## 0. Dockerのインストール

```
. DockerFiles/dockerInstall.sh
```
パスワードを求められたらパスワードを入力
* パスワードはパッケージのインストールとグループ権限をdockerに追加するために必要
## 1. Docker Rosイメージの作成
Ros環境構築の為にDockerfileからイメージ作成していく
```
docker build -t ros/melodic:cpu DockerFiles
```
作成したイメージの確認
```
docker images
```
|REPOSITORY|TAG|IMAGE ID|CREATED|SIZE|
|:---|:---|:---|:---|:---|
|ros/melodic|cpu|XXXXXXXX|X minutes ago|XXXXGB|
上記と似たような結果が出たら成功
## 2. Docker Ros環境の立ち上げ
### gazeboやrvizを使うこと想定するのでGUIの表示ができるように前もって次の動作を行う
```
xhost +local:$USER
```
### 上記の動作を行わないと下記の様な注意が表示されます 
`venv@pc:~$ rosrun rviz rviz` \
`QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-venv'` \
`Authorization required, but no authorization protocol specified` \
`qt.qpa.screen: QXcbConnection: Could not connect to display :0.0` \
`Could not connect to any X display.` 
### GUIの表示設定後に環境の立ち上げ
```
. DockerFiles/RosEnvRun.sh
```
以下の内容がDockerFiles/RosEnvRun.shに記述してある
```
docker run --rm                                 \
            -it                                 \
            --net=host                          \
            --ipc=host                          \
            --privileged                        \
            -e ROS_IP=127.0.0.1                 \
            -e DISPLAY=$DISPLAY                 \
            --env="QT_X11_NO_MITSHM=1"          \
            --device=/dev/dri:/dev/dri          \
            -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
            ros/melodic:cpu
```
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
計算機の環境、ホスト側がDockerの仮想環境に影響を与えている場合があることでしょう\
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