//
//  MiddleViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/10.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit
import SideMenu

class MiddleViewController: BaseWebviewViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主界面"
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(notifacationListener), name: NSNotification.Name(rawValue: CONST.init().NOTIFICATION_SWITCHURL), object: nil)
        
        //自定义leftBar
        let leftBar = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(self.openDrawer))
        self.navigationItem.leftBarButtonItem = leftBar
        
        // 定义一个侧栏菜单
        let leftDrawer = SideMenuNavigationController(rootViewController: LeftDrawerViewController())
        leftDrawer.isNavigationBarHidden = true //侧栏菜单不显示导航栏
        leftDrawer.menuWidth = screenW*4/5
        SideMenuManager.default.leftMenuNavigationController = leftDrawer
        // 开启通过边缘滑动打开侧栏菜单的功能
        SideMenuManager.default.addPanGestureToPresent(toView:
            self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView:
            self.navigationController!.view)
    }
    
    /**
     显示侧栏菜单
     */
    @objc func openDrawer(){
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)
    }
    
    //实现通知监听方法
    @objc func notifacationListener(nofi : Notification){
        let url = nofi.userInfo!["post"]
        loadWebView(url: (url as? String)!)
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)//移除通知
    }
    
}
