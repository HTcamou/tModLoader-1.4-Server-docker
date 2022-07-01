# tModLoader-1.4-Server-docker

这是一个tmodloader1.4版本的Dockerfile文件以及所需sh脚本文件。

## 当前功能及特性

1、容器启动自动检查tmodloader官方最新版本并进行更新；

2、所有tml文件放在 `/home/tModLoader` 文件夹下；

3、建议在网络状态良好的情况下进行布置，过程中会下载部分依赖以及dotnet，网络状态不佳极容易导致部署失败；

4、20220701增加两个环境变量，`ENV Autoupdate=false`可修改是否开启开机自动检查更新，`ENV TMOD_VERSION=v2022.05.103.34`可自定义指定版本文件

## 声明

1、现只适用于未发行正式版的tml1.4，根据文件结构进行的简单脚本编写，非专业人员，见谅；

2、如有需求会逐步删除多余代码。
