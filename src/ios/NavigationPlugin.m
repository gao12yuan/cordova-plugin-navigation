/********* NavigationPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
@interface NavigationPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)getMapSoftwareList:(CDVInvokedUrlCommand*)command;
- (void)wakeUpNavigation:(CDVInvokedUrlCommand*)command;
@end

@implementation NavigationPlugin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)getMapSoftwareList:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSMutableArray *maps = [NSMutableArray array];
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
     iosMapDic[@"text"] = @"苹果地图";
     iosMapDic[@"type"] = @"apple";
     [maps addObject:iosMapDic];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSLog(@"百度地图");
//        [maps addObject:@"百度地图"];
        NSMutableDictionary *baiMapDic = [NSMutableDictionary dictionary];
        baiMapDic[@"text"] = @"百度地图";
        baiMapDic[@"type"] = @"baidu";
        [maps addObject:baiMapDic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSLog(@"高德地图");
        NSMutableDictionary *gaoMapDic = [NSMutableDictionary dictionary];
        gaoMapDic[@"text"] = @"高德地图";
        gaoMapDic[@"type"] = @"gaode";
        [maps addObject:gaoMapDic];
//        [maps addObject:@"高德地图"];

    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSLog(@"腾讯地图");
//        [maps addObject:@"腾讯地图"];
        NSMutableDictionary *tengMapDic = [NSMutableDictionary dictionary];
        tengMapDic[@"text"] = @"腾讯地图";
        tengMapDic[@"type"] = @"tengxun";
        [maps addObject:tengMapDic];
    }
    NSMutableDictionary *mapRes = [NSMutableDictionary dictionary];
    mapRes[@"status"] = @"success";
    mapRes[@"value"] = maps;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:mapRes];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)wakeUpNavigation:(CDVInvokedUrlCommand*)command
{
    NSString* longitude = [command.arguments objectAtIndex:0];
    NSString* latitude = [command.arguments objectAtIndex:1];
    NSString* tName = [command.arguments objectAtIndex:2];
    NSString* type = [command.arguments objectAtIndex:3];
    if ([type isEqual:@"gaode"]) {
        NSLog(@"高德地图");
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dname=%@&dev=0&style=2",@"导航功能",@"nav123456",latitude, longitude, tName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    if ([type isEqual:@"baidu"]) {
        NSLog(@"百度地图");
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=name:%@|latlng:%@,%@&mode=driving&coord_type=bd09ll&src=ios.jianghu.jianhao",tName,latitude, longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    if ([type isEqual:@"tengxun"]) {
        NSLog(@"腾讯地图");
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=%@&coord_type=1&policy=0",latitude, longitude, tName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    if ([type isEqual:@"apple"]) {
        NSLog(@"苹果地图");
        double dlong = [longitude doubleValue];
        double dLat = [latitude doubleValue];
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(dLat, dlong);
        
        //用户位置
        MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
        //终点位置
        MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
        // NSLog(@"boolValue:\"%@\" => %@", toLocation);
        toLocation.name = tName;
        NSArray *items = @[currentLoc,toLocation];
        NSDictionary *dic = @{
                              MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                              MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                              MKLaunchOptionsShowsTrafficKey : @(YES)
                            };
        [MKMapItem openMapsWithItems:items launchOptions:dic];
        

    }
    
}



@end
