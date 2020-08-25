//
//  SettingViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/12.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    var laCache:UILabel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //修改密码
        let pwdStr = UILabel()
        pwdStr.frame = CGRect(x: 40, y: 100, width: screenW-45, height: 50)
        pwdStr.text = "修改密码"
        pwdStr.textColor = .gray
        pwdStr.font = UIFont.systemFont(ofSize: 15)
        pwdStr.isUserInteractionEnabled = true
        pwdStr.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(modifyPwd)))
        self.view.addSubview(pwdStr)
        let pwdHeight = pwdStr.frame.height
        
        let ivPwd = UIImageView(image: UIImage(named: "icon_modify_pwd"))
        ivPwd.frame = CGRect(x: 15, y: pwdHeight/2+100-7.5, width: 15, height: 15)
        self.view.addSubview(ivPwd)
        
        let arPwd = UIImageView(image: UIImage(named: "icon_arrow"))
        arPwd.frame = CGRect(x: screenW-20, y: pwdHeight/2+100-8, width: 8, height: 16)
        self.view.addSubview(arPwd)
        
        let divider1 = UIView(frame: CGRect(x: 0, y: 150, width: screenW, height: 0.5))
        divider1.backgroundColor = UIColor.MyColor.lightGray
        self.view.addSubview(divider1)
        
        //清除缓存
        let cacheStr = UILabel()
        cacheStr.frame = CGRect(x: 40, y: 150, width: screenW-45, height: 50)
        cacheStr.text = "清除缓存"
        cacheStr.textColor = .gray
        cacheStr.font = UIFont.systemFont(ofSize: 15)
        cacheStr.isUserInteractionEnabled = true
        cacheStr.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cacheAlert)))
        self.view.addSubview(cacheStr)
        let cacheHeight = cacheStr.frame.height
        
        let ivCache = UIImageView(image: UIImage(named: "icon_cache"))
        ivCache.frame = CGRect(x: 15, y: cacheHeight/2+150-7.5, width: 15, height: 15)
        self.view.addSubview(ivCache)
        
        laCache = UILabel()
        laCache!.frame = CGRect(x: screenW-90, y: cacheHeight/2+150-10, width: 60, height: 20)
        laCache!.text = getCacheSize()
        laCache!.textColor = UIColor.MyColor.blue
        laCache!.font = UIFont.systemFont(ofSize: 13)
        laCache!.adjustsFontSizeToFitWidth = true
        self.view.addSubview(laCache!)
        
        let arCache = UIImageView(image: UIImage(named: "icon_arrow"))
        arCache.frame = CGRect(x: screenW-20, y: cacheHeight/2+150-8, width: 8, height: 16)
        self.view.addSubview(arCache)
        
        let divider2 = UIView(frame: CGRect(x: 0, y: 200, width: screenW, height: 0.5))
        divider2.backgroundColor = UIColor.MyColor.lightGray
        self.view.addSubview(divider2)
        
        //退出登录
        let btnLogout = UIButton(type: .roundedRect)
        btnLogout.frame = CGRect(x: 30, y: screenH-100, width: screenW-60, height: 45)
        btnLogout.setTitle("退出登录", for: UIControl.State())
        btnLogout.setTitleColor(.white, for: UIControl.State.normal)
        btnLogout.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btnLogout.backgroundColor = UIColor.MyColor.blue
        btnLogout.layer.cornerRadius = 5
        btnLogout.layer.masksToBounds = true
        btnLogout.addTarget(self, action: #selector(logoutAlert), for: .touchUpInside)
        self.view.addSubview(btnLogout)
    }
    
    /**
     修改密码
     */
    @objc func modifyPwd() {
        let modifyVC = ModifyPwdViewController()
        modifyVC.title = "修改密码"
        self.navigationController?.pushViewController(modifyVC, animated: true)
    }
    
    /**
     获取缓存数据大小
     */
    @objc func getCacheSize() -> String {
        // 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)

        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            // 把文件名拼接到路径中
            let path = cachePath! + ("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (key, fileSize) in floder {
                // 累加文件大小
                if key == FileAttributeKey.size {
                    size += (fileSize as AnyObject).integerValue
                }
            }
        }
        let totalCache = Double(size) / 1024.00 / 1024.00
        return String(format: "%.2f", totalCache)+"MB"
    }
    
    /**
     清除缓存
     */
    @objc func clearCache() {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)

        // 遍历删除
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                }
            }
        }
        laCache!.text = getCacheSize()
    }
    
    /**
     清除缓存alert
     */
    @objc func cacheAlert() {
        let alert = UIAlertController(title: "清除缓存", message: "确定清除缓存？", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .default, handler: {(alerts:UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        let sure = UIAlertAction(title: "确定", style: .default, handler: {(alerts:UIAlertAction) -> Void in
            self.clearCache()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancel)
        alert.addAction(sure)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     退出登录
     */
    @objc func logout() {
        UserUtil.init().clearUserInfo()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     退出登录alert
     */
    @objc func logoutAlert() {
        let alert = UIAlertController(title: "退出登录", message: "确定要退出登录？", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .default, handler: {(alerts:UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        })
        let sure = UIAlertAction(title: "确定", style: .default, handler: {(alerts:UIAlertAction) -> Void in
            self.logout()
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancel)
        alert.addAction(sure)
        self.present(alert, animated: true, completion: nil)
    }

}
