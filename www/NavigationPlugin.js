var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'NavigationPlugin', 'coolMethod', [arg0]);
};
// 获取手机里安装导航的软件
exports.getMapSoftwareList = function (success, error) {
    exec(success, error, 'NavigationPlugin', 'getMapSoftwareList');
}
// 拉取导航地图 只支持 腾讯 百度 高德
exports.wakeUpNavigation = function (options, success, error) {
    options = options || {};
    var longitude = options.longitude; // 经度
    var latitude = options.latitude; // 纬度
    var tName = options.tName; // 目的地
    var type = options.mapType; // 地图软件类型
    var args = [longitude, latitude, tName, type];   
    exec(success, error, 'NavigationPlugin', 'wakeUpNavigation', args);
}