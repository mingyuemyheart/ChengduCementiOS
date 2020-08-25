//
//  LoginViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/7.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

/*
 登录界面
 */
class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    var tfUser = UITextField()
    var tfPwd = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    /**
     设置状态栏主题
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ivBanner = UIImageView(image: UIImage(named: "banner_login"))
        ivBanner.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH/3)
        self.view.addSubview(ivBanner)
        let bannerHeight = ivBanner.frame.height
        
        let ivLogo = UIImageView(image: UIImage(named: "icon_app"))
        ivLogo.frame = CGRect(x: screenW/2-60, y: bannerHeight-60, width: 120, height: 120)
        self.view.addSubview(ivLogo)
        let logoHeight = ivLogo.frame.height
        
        let ivUser = UIImageView(image: UIImage(named: "icon_user"))
        ivUser.frame = CGRect(x: 30, y: 12, width: 20, height: 24)
        
        tfUser.frame = CGRect(x: 40, y: bannerHeight+logoHeight/2+40, width: screenW-80, height: 50)
        tfUser.background = UIImage(named: "bg_corner_pwd")
        tfUser.placeholder = "请输入您的用户名"
        tfUser.autocapitalizationType = .none
        tfUser.textAlignment = .center
        tfUser.adjustsFontSizeToFitWidth = true
        tfUser.returnKeyType = .done
        tfUser.clearButtonMode = .whileEditing
        tfUser.delegate = self
        tfUser.addSubview(ivUser)
        self.view.addSubview(tfUser)
        
        let ivPwd = UIImageView(image: UIImage(named: "icon_pwd"))
        ivPwd.frame = CGRect(x: 30, y: 12, width: 20, height: 24)
        
        tfPwd.frame = CGRect(x: 40, y: bannerHeight+logoHeight/2+100, width: screenW-80, height: 50)
        tfPwd.background = UIImage(named: "bg_corner_pwd")
        tfPwd.placeholder = "请输入您的密码"
        tfPwd.autocapitalizationType = .none
        tfPwd.textAlignment = .center
        tfPwd.adjustsFontSizeToFitWidth = true
        tfPwd.returnKeyType = .done
        tfPwd.clearButtonMode = .whileEditing
        tfPwd.isSecureTextEntry = true
        tfPwd.delegate = self
        tfPwd.addSubview(ivPwd)
        self.view.addSubview(tfPwd)
        
        let btnLogin = UIButton(type: .roundedRect)
        btnLogin.frame = CGRect(x: 50, y: bannerHeight+logoHeight/2+200, width: screenW-100, height: 50)
        btnLogin.backgroundColor = .blue
        btnLogin.tintColor = .white
        btnLogin.setTitle("登 录", for: UIControl.State())
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        btnLogin.layer.masksToBounds = true
        btnLogin.layer.cornerRadius = 25
        btnLogin.addTarget(self, action: #selector(requestLogin), for: .touchUpInside)
        self.view.addSubview(btnLogin)
        
        addBaseWidget()
        
        let userInfo = UserUtil.init().getUserInfo()
        let userName = userInfo[0]
        let passWord = userInfo[1]
        if !userName.isEmpty && !passWord.isEmpty {
            tfUser.text = userName
            tfPwd.text = passWord
            requestLogin()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func checkInfo(userName:String, passWord:String) -> Bool {
//        if userName.isEmpty {
//            sToast.showToast(content: "用户名或密码不能为空")
//            return false
//        }
//        if passWord.isEmpty {
//            sToast.showToast(content: "用户名或密码不能为空")
//            return false
//        }
//        return true
//    }
    
    @objc func requestLogin() {
        if tfUser.text!.isEmpty {
            sToast.showToast(content: "用户名或密码不能为空")
            return
        }
        if tfPwd.text!.isEmpty {
            sToast.showToast(content: "用户名或密码不能为空")
            return
        }
        
        sToast.hideToast()
        dialog.showDialog()
        let url = URL(string: "\(CONST.init().BASE_URL)/reLogin/loginToken")
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.httpMethod = "POST"
        let secretPwd = tfPwd.text!.sha256()
        let params = "account=\(tfUser.text!)&password=\(secretPwd)&clientId=\(CONST.init().CLIENDID)"
        request.httpBody = params.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {(data, response, error)
            -> Void in
            if error != nil {
                print(error.debugDescription)
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    do {
                        if let jsonObj : NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary {
                            let code:Int = (jsonObj["code"] as? Int)!
                            self.dialog.hideDialog()
                            if code == 200 {
                                let token:String = (jsonObj["data"] as? String)!
                                UserUtil.init().saveUserInfo(userName: self.tfUser.text! as String, passWord: self.tfPwd.text! as String, token: token)

                                //跳转至主界面
                                let middleViewController = MiddleViewController()
                                self.navigationController?.pushViewController(middleViewController, animated: true)
                            } else {
                                let msg = jsonObj["message"] as? String
                                self.sToast.showToast(content: msg!)
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
