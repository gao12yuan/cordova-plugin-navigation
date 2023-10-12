# cordova-plugin-navigation

#### 介绍
导航插件 （只支持百度 、腾讯、高德三个地图）

#### 软件架构
软件架构说明


#### 安装教程

1. cordova plugin add 插件地址


#### 使用说明

1.  android 10以上 获取本地的导航插件 需要在androidManifest.xml里添加一下代码
     <package android:name="com.baidu.BaiduMap" />
     <package android:name="com.autonavi.minimap" />
     <package android:name="com.tencent.map" />

2. ios  需要在plist里LSApplicationQueriesSchemes加入
        <string>baidumap</string>
        <string>iosamap</string>
        <string>qqmap</string>


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
