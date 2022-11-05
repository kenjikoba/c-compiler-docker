これは、[この教科書](https://www.sigbus.info/compilerbook#docker)を用いてCのコンパイラを作成するためのレポジトリです。

自分のPCがM1 Macなので元々アーキテクチャがarm式で、amd64(x86_64)に対応していなく、[参考にして進めている教科書](https://www.sigbus.info/compilerbook#docker)は基本的にintelのamd64ベースで書かれていたので、それが動くようにDockerを用いて環境構築を行いました。amd64式が動くように、Dockerfileで`amd64/Ubuntu:latest`と記述しました。加えてDockerfileでgccなど必要そうなコマンドをインストールしておきました。

そしてimageを下のコマンドで作成しました。ここで、Dockerfile内の`apt-get install -y tzdata` の部分はこれがないとタイムゾーンの部分で`image build`が止まってしまうため付け加えたものです。
```
$ docker image build --tag compiler-docker:docker .
```
そして下のコマンドでこのimageを用いてコンテナを作りました。
```
$ docker container run --name compiler-container --rm --interactive --tty --mount type=bind,src=$(pwd),dst=/src compiler-docker:docker bash
```
このdockerディレクトリをバインドしたので、dockerから参照できるのはこのディレクトリです。よってこのディレクトリで作業を進めて行きます。

あとbashで起動させたので、`:/#`のような表記になります。ここから/srcディレクトリに入ればローカルでのこのdockerディレクトリと同じようになるので、作業ができます。

これからは、基本的に作業は全部Dockerでやっていこうと思っています。

作業するときは、ターミナルでこのディレクトリ（docker）に移動して、
```
$ docker container run --name compiler-container --rm --interactive --tty --mount type=bind,src=$(pwd),dst=/src compiler-docker:docker bash
```
のコマンドを叩けばいいはずです。今回`docker compose`を使うほど複雑じゃないと思ったので使ってないです。