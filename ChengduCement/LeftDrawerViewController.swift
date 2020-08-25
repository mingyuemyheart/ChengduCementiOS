//
//  LeftDrawerViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/10.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

class LeftDrawerViewController: UIViewController {
    
    var laUser:UILabel?
    var laName:UILabel?
    var laSex:UILabel?
    var laCount:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        
        self.view.backgroundColor = .white
        
        let userStr = UILabel()
        userStr.frame = CGRect(x: 10, y: 60, width: 80, height: 40)
        userStr.text = "账号"
        userStr.textColor = .black
        userStr.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(userStr)
        
        laUser = UILabel()
        laUser!.frame = CGRect(x: screenW*4/5-80, y: 60, width: 70, height: 40)
        laUser!.textColor = .gray
        laUser?.textAlignment = .right
        laUser!.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(laUser!)
        
        let nameStr = UILabel()
        nameStr.frame = CGRect(x: 10, y: 100, width: 80, height: 40)
        nameStr.text = "姓名"
        nameStr.textColor = .black
        nameStr.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(nameStr)
        
        laName = UILabel()
        laName!.frame = CGRect(x: screenW*4/5-80, y: 100, width: 70, height: 40)
        laName!.textColor = .gray
        laName?.textAlignment = .right
        laName!.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(laName!)
        
        let sexStr = UILabel()
        sexStr.frame = CGRect(x: 10, y: 140, width: 80, height: 40)
        sexStr.text = "性别"
        sexStr.textColor = .black
        sexStr.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(sexStr)
        
        laSex = UILabel()
        laSex!.frame = CGRect(x: screenW*4/5-80, y: 140, width: 70, height: 40)
        laSex!.textColor = .gray
        laSex!.textAlignment = .right
        laSex!.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(laSex!)
        
        let divider1 = UILabel()
        divider1.frame = CGRect(x: 0, y: 190, width: screenW, height: 0.5)
        divider1.backgroundColor = .lightGray
        self.view.addSubview(divider1)
        
        //实时监控
        let monitorStr = UILabel()
        monitorStr.frame = CGRect(x: 35, y: 210, width: screenW*4/5-40, height: 50)
        monitorStr.text = "实时监控"
        monitorStr.textColor = .black
        monitorStr.font = UIFont.systemFont(ofSize: 15)
        monitorStr.isUserInteractionEnabled = true
        monitorStr.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.clickMonitor)))
        self.view.addSubview(monitorStr)
        let monitorHeight = monitorStr.frame.height
        
        let ivMonitor = UIImageView(image: UIImage(named: "icon_monitor"))
        ivMonitor.frame = CGRect(x: 10, y: monitorHeight/2+210-7.5, width: 15, height: 15)
        self.view.addSubview(ivMonitor)
        
        let arMonitor = UIImageView(image: UIImage(named: "icon_arrow"))
        arMonitor.frame = CGRect(x: screenW*4/5-20, y: monitorHeight/2+210-8, width: 8, height: 16)
        self.view.addSubview(arMonitor)
        
        //设备警告
        let warningStr = UILabel()
        warningStr.frame = CGRect(x: 35, y: 260, width: screenW*4/5-40, height: 50)
        warningStr.text = "设备警告"
        warningStr.textColor = .black
        warningStr.font = UIFont.systemFont(ofSize: 15)
        warningStr.isUserInteractionEnabled = true
        warningStr.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.clickWarning)))
        self.view.addSubview(warningStr)
        let warningHeight = warningStr.frame.height
        
        let ivWarning = UIImageView(image: UIImage(named: "icon_warning"))
        ivWarning.frame = CGRect(x: 10, y: warningHeight/2+260-7.5, width: 15, height: 15)
        self.view.addSubview(ivWarning)
        
        laCount = UILabel()
        laCount!.frame = CGRect(x: screenW*4/5-55, y: warningHeight/2+260-13, width: 26, height: 26)
        laCount!.textColor = .white
        laCount!.font = UIFont.systemFont(ofSize: 13)
        laCount!.adjustsFontSizeToFitWidth = true
        laCount!.textAlignment = .center
        laCount!.backgroundColor = .red
        laCount!.layer.cornerRadius = 13
        laCount!.layer.masksToBounds = true
        laCount!.isHidden = true
        self.view.addSubview(laCount!)
        
        let arWarning = UIImageView(image: UIImage(named: "icon_arrow"))
        arWarning.frame = CGRect(x: screenW*4/5-20, y: warningHeight/2+260-8, width: 8, height: 16)
        self.view.addSubview(arWarning)
        
        //系统设置
        let setStr = UILabel()
        setStr.frame = CGRect(x: 35, y: 310, width: screenW*4/5-40, height: 50)
        setStr.text = "系统设置"
        setStr.textColor = .black
        setStr.font = UIFont.systemFont(ofSize: 15)
        setStr.isUserInteractionEnabled = true
        setStr.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.clickSetting)))
        self.view.addSubview(setStr)
        let setHeight = setStr.frame.height
        
        let ivSet = UIImageView(image: UIImage(named: "icon_setting"))
        ivSet.frame = CGRect(x: 10, y: setHeight/2+310-7.5, width: 15, height: 15)
        self.view.addSubview(ivSet)
        
        let arSet = UIImageView(image: UIImage(named: "icon_arrow"))
        arSet.frame = CGRect(x: screenW*4/5-20, y: setHeight/2+310-8, width: 8, height: 16)
        self.view.addSubview(arSet)
        
        requestUserInfo()
        requestWarning()
    }
    
    //实时监控点击
    @objc func clickMonitor() {
        self.dismiss(animated: true, completion: nil)
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(CONST.init().NOTIFICATION_SWITCHURL), object: self, userInfo: ["post": CONST.init().HTMLURL])
    }
    
    //设备警告点击
    @objc func clickWarning() {
        self.dismiss(animated: true, completion: nil)
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(CONST.init().NOTIFICATION_SWITCHURL), object: self, userInfo: ["post": CONST.init().HTMLURL_WARNING])
    }
    
    //系统设置点击
    @objc func clickSetting() {
        let settingVC = SettingViewController()
        settingVC.title = "系统设置"
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    /**
     获取用户信息
     */
    @objc func requestUserInfo() {
        let url = URL(string: "\(CONST.init().BASE_URL)/guns-cloud-two-system/entUser/getCurrentUser")
        let request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Dictionary<String, String>(dictionaryLiteral: ("Authorization", UserUtil.init().getToken()))
        let session = URLSession.init(configuration: configuration)
//        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {(data, response, error)
            -> Void in
            if error != nil {
                print(error.debugDescription)
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary {
                            let code:Int = (jsonObj["code"] as? Int)!
                            if code == 200 {
                                if let dataObj:NSDictionary = jsonObj["data"] as? NSDictionary {
                                    self.laUser?.text = UserUtil.init().getUserName()
                                    
                                    let name:String = (dataObj["userName"] as? String)!
                                    if !name.isEmpty {
                                        self.laName?.text = name
                                    }
                                    
                                    let sex:String = (dataObj["sex"] as? String)!
                                    if sex.elementsEqual("M") {
                                        self.laSex?.text = "男"
                                    } else {
                                        self.laSex?.text = "女"
                                    }
                                }
                            } else {
                                let msg = jsonObj["message"] as? String
                                print("requestUserInfo:\(msg)")
                            }
                        }
                    } catch {
                        print("Error")
                    }
                })
            }
        })
        task.resume()
    }
    
    /**
     获取设备警告数量
     */
    @objc func requestWarning() {
        let url = URL(string: "\(CONST.init().BASE_URL)/guns-cloud-cdsncioc/cdsnciockzjk/getIocAlarmQuantity")
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.httpMethod = "POST"
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Dictionary<String, String>(dictionaryLiteral: ("Authorization", UserUtil.init().getToken()))
        let session = URLSession.init(configuration: configuration)
//        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {(data, response, error)
            -> Void in
            if error != nil {
                print(error.debugDescription)
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary {
                            let code:Int = (jsonObj["code"] as? Int)!
                            if code == 200 {
                                let count:Int = (jsonObj["data"] as? Int)!
                                self.laCount!.text = "\(count)"
                                self.laCount!.isHidden = false
                            } else {
                                let msg = jsonObj["message"] as? String
                                print("requestWarning:\(msg)")
                            }
                        }
                    } catch {
                        print("Error")
                    }
                })
            }
        })
        task.resume()
    }

}
