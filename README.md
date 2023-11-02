# cordova-plugin-navigation

#### 介绍
导航插件 （只支持百度 、腾讯、高德、苹果自带导航）


#### 安装教程

cordova plugin add https://github.com/gao12yuan/cordova-plugin-navigation.git


#### 使用说明

1.  android 10以上 获取本地的导航插件 需要在androidManifest.xml里添加以下代码
     <package android:name="com.baidu.BaiduMap" />
     <package android:name="com.autonavi.minimap" />
     <package android:name="com.tencent.map" />

2. ios  需要在plist里LSApplicationQueriesSchemes加入
        <string>baidumap</string>
        <string>iosamap</string>
        <string>qqmap</string>

3. 唤醒导航参数说明 
```java
   navOptions = {
        longitude: number, //  经度
        latitude: number, // 纬度
        tName: string, // 目的地
        mapType: string, // 打开的软件 只支持 腾讯：tengxun 高德：gaode 百度： baidu  苹果： apple
   }
```
示例：
  #### 唤醒地图：（高德）
  ```java
  // mapType： tengxun 腾讯地图  baidu 百度地图 
  let navOptions = {
        longitude: 116.315666,
        latitude: 39.885679,
        tName: "北京电力医院",
        mapType: "gaode"
  }
  window.cordova.plugins['NavigationPlugin'].wakeUpNavigation(navOptions).then( (res:any) => {})
 ```
  #### 获取导航列表
  ```java
  window.cordova.plugins['NavigationPlugin'].getMapSoftwareList().then( (res:any) => {
    // res.value 是导航集

 })
 ```

#### 参与贡献
GAOYUAN
