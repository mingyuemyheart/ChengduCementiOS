//
//  CONST.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/11.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import Foundation

class CONST: NSObject {
    public let CLIENDID:String = "10006"
//    public let BASE_URL:String = "http://192.168.1.242:8306"
    public let BASE_URL:String = "http://192.168.1.243:8306"

    public let WEB_URL:String = "web_Url"//网页地址的标示
    public let ACTIVITY_NAME:String = "activity_name"//界面名称

    //加载的html地址
//    public let HTMLURL:String = "http://192.168.1.223:9104/#/realTime"
//    public let HTMLURL_WARNING:String = "http://192.168.1.223:9104/#/alarmList"//设备警告
//    public let HTMLURL:String = "http://192.168.1.242:9104/#/realTime"
//    public let HTMLURL_WARNING:String = "http://192.168.1.242:9104/#/alarmList"//设备警告
    public let HTMLURL:String = "http://192.168.1.243:9104/#/realTime"
    public let HTMLURL_WARNING:String = "http://192.168.1.243:9104/#/alarmList"//设备警告
    
    //通知名称
    public let NOTIFICATION_SWITCHURL = "notification_switchurl"//切换加载地址
}
