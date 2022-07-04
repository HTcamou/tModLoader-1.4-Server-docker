#!/bin/bash
apt -y install wget unzip libicu-dev
versiontxt=/home/tModLoader/version.txt
#获取本地版本号
localversion=$(cat $versiontxt)
if [ "$Autoupdate" == "true" ]
    then
        #最终路径注意更换
        #获取最新版本号
        newversion=$(wget -qO- version.txt -t1 -T2 "https://api.github.com/repos/tModLoader/tModLoader/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')
        #输出最新版本号
        echo "latest version: $newversion"
        #输出本地版本号
        echo "local version: $localversion"
        #版本号对比，一致开始启动服务器，不一致开始下载最新版本文件，解压后删除并记录版本号
        if [ "$localversion" == "$newversion" ]
            then
                echo "local version already is latest version"
            else
    	        #进入下载目录
                cd /home
                echo "starting download latest tModLoader version..."
                #下载最新版压缩包
                wget https://github.com/tModLoader/tModLoader/releases/download/$newversion/tModLoader.zip
                echo "Completed download"
                if [ -f /home/tModLoader/serverconfig.txt ]
                    then 
                        #覆盖解压，不解压serverconfig配置文件（保留配置文件）
                        unzip -o tModLoader.zip -d tModLoader/ -x "serverconfig.txt"
                    else
                        unzip -o tModLoader.zip -d tModLoader/
                fi
        fi
        #删除下载压缩包
        rm -f tModLoader.zip
        #注释当前版本
        echo "$newversion" > "$versiontxt"
    else
        if [ "$localversion" == "$TMOD_VERSION" ]
            then
                echo "local version already is ENV TMOD_VERSION:$TMOD_VERSION"
            else
    	        #进入下载目录
                cd /home
                echo "starting download ENV TMOD_VERSION:$TMOD_VERSION tModLoader version..."
                #下载最新版压缩包
                wget https://github.com/tModLoader/tModLoader/releases/download/$TMOD_VERSION/tModLoader.zip
                echo "Completed download"
                if [ -f /home/tModLoader/serverconfig.txt ]
                    then 
                        #覆盖解压，不解压serverconfig配置文件（保留配置文件）
                        unzip -o tModLoader.zip -d tModLoader/ -x "serverconfig.txt"
                    else
                        unzip -o tModLoader.zip -d tModLoader/
                fi
        fi
        #删除下载压缩包
        rm -f tModLoader.zip
        #注释当前版本
        echo "$TMOD_VERSION" > "$versiontxt"
fi
#创建MOD WORLD目录
cd /home/tModLoader
if [ ! -d "Mods" ]
    then
    mkdir Mods Mods/ModPacks Worlds
fi
#自定义配置文件提前放入
cd /root
if [ -f "serverconfig.txt" ]
    then
    mv serverconfig.txt /home/tModLoader
fi
#执行开服脚本
cd /home/tModLoader
chmod +x start-tModLoaderServer.sh
./start-tModLoaderServer.sh
