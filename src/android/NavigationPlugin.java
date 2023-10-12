package cordova.plugin.navigation;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.pm.PackageInfo;
import android.content.Intent;
/**
 * This class echoes a string called from JavaScript.
 */
public class NavigationPlugin extends CordovaPlugin {
    private String longitude; // 经度
    private String latitude;  // 纬度
    private String tName;  // 目的地
    private String type;  // 打开地图的类型
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("coolMethod")) {
            String message = args.getString(0);
            this.coolMethod(message, callbackContext);
            return true;
        }  else if (action.equals("getMapSoftwareList")) {
             this.MapSoftwareList(callbackContext);
             return true;
        } else if (action.equals("wakeUpNavigation")) {
            this.longitude= args.optString(0);
            this.latitude= args.optString(1);
            this.tName= args.optString(2);
            this.type = args.optString(3);
            System.out.println(args);
            System.out.println(Double.parseDouble(this.longitude));
            if (this.type.equals("gaode")) {
               this.toGaodeNavi();
            }
            if (this.type.equals("baidu")) {
                this.toBaidu();
            }
            if (this.type.equals("tengxun")) {
                this.toTencent();
            }
            return true;
        }
        return false;
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
    // 百度地图
    public void toBaidu(){
        System.out.println("百度==");
        System.out.println(this.latitude);
        System.out.println(this.longitude);
        Intent intent= new Intent("android.intent.action.VIEW", android.net.Uri.parse("baidumap://map/geocoder?location=" + this.latitude + "," + this.longitude));
        cordova.getActivity().startActivity(intent);
    }
    // 高德地图
    public void toGaodeNavi(){
        Intent intent= new Intent("android.intent.action.VIEW", android.net.Uri.parse("androidamap://route?sourceApplication=appName&slat=&slon=&dlat="+ this.latitude +"&dlon="+ this.longitude+"&dname=" + this.tName + "&dev=0&t=2"));
        System.out.println("androidamap://route?sourceApplication=appName&slat=&slon=&dlat="+ this.latitude +"&dlon="+ this.longitude+"&dname=" + this.tName + "&dev=0&t=2");
        cordova.getActivity().startActivity(intent);
    }
    // 腾讯地图
    public void toTencent(){
        Intent intent = new Intent("android.intent.action.VIEW", android.net.Uri.parse("qqmap://map/routeplan?type=drive&from=&fromcoord=&to=" + this.tName + "&tocoord=" + this.latitude + "," + this.longitude + "&policy=0&referer=appName"));
        cordova.getActivity().startActivity(intent);
    }
    private void MapSoftwareList(CallbackContext callbackContext) {
        List<Object> mapsList = this.hasMap();
        JSONObject returnObj = new JSONObject();
        System.out.println("地图列表");
        System.out.println(mapsList);
        try {
          returnObj.put("status", "success");
          returnObj.put("value", mapsList);
        } catch (JSONException e) {
          e.printStackTrace();
        }
        callbackContext.success(returnObj);
    }
    public  boolean isAvilible(String packageName){
        //获取packagemanager
        final PackageManager packageManager = this.cordova.getActivity().getPackageManager();
        //获取所有已安装程序的包信息
        List<PackageInfo> packageInfos = packageManager.getInstalledPackages(0);
        //用于存储所有已安装程序的包名
        List<String> packageNames = new ArrayList<String>();
        //从pinfo中将包名字逐一取出，压入pName list中
        if(packageInfos != null){
            for(int i = 0; i < packageInfos.size(); i++){
              String packName = packageInfos.get(i).packageName;
              packageNames.add(packName);
            }
        }
        //判断packageNames中是否有目标程序的包名，有TRUE，没有FALSE
        return packageNames.contains(packageName);
    }


    public List<String> mapsList (){
      List<String> maps = new ArrayList<>();
      maps.add("com.baidu.BaiduMap");
      maps.add("com.autonavi.minimap");
      maps.add("com.tencent.map");
      return maps;
    }

    // 检索筛选后返回
    public  List<Object> hasMap (){
        List<String> mapsList = mapsList();
        List<Object> backList = new ArrayList<>();
        for (int i = 0; i < mapsList.size(); i++) {
            boolean avilible = isAvilible(mapsList.get(i));
            JSONObject returnObj = new JSONObject();
            if (avilible){
               if (mapsList.get(i) == "com.baidu.BaiduMap") {
                   try {
                     returnObj.put("text", "百度地图");
                     returnObj.put("type", "baidu");
                   } catch (JSONException e) {
                     e.printStackTrace();
                   }
                   backList.add(returnObj);
               }
               if (mapsList.get(i) == "com.autonavi.minimap") {
                  try {
                     returnObj.put("text", "高德地图");
                     returnObj.put("type", "gaode");
                   } catch (JSONException e) {
                     e.printStackTrace();
                   }
                   backList.add(returnObj);
               }
               if (mapsList.get(i) == "com.tencent.map") {
                   try {
                     returnObj.put("text", "腾讯地图");
                     returnObj.put("type", "tengxun");
                   } catch (JSONException e) {
                     e.printStackTrace();
                   }
                   backList.add(returnObj);
               }
//              backList.add(mapsList.get(i));
            }
        }
        return backList;

    }
}
