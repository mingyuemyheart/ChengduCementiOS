//
//  ModifyPwdViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/12.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

class ModifyPwdViewController: BaseViewController {
    
    var tfPwdOld:UITextField?
    var tfPwdNew:UITextField?
    var tfPwdConfirm:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //原密码
        let pwdStr1 = UILabel(frame: CGRect(x: 30, y: 100, width: 100, height: 50))
        pwdStr1.text = "请输入原密码"
        pwdStr1.textColor = .black
        pwdStr1.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(pwdStr1)
        let pwdStr1Height = pwdStr1.frame.height
        
        tfPwdOld = UITextField(frame: CGRect(x: 140, y: 100, width: screenW-30, height: 50))
        tfPwdOld!.placeholder = "请输入原密码"
        tfPwdOld!.textColor = .gray
        tfPwdOld!.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(tfPwdOld!)
        
        let start1 = UILabel(frame: CGRect(x: 20, y: 100+pwdStr1Height/2-5, width: 10, height: 10))
        start1.text = "*"
        start1.textColor = .red
        start1.textAlignment = .center
        self.view.addSubview(start1)
        
        let divider1 = UIView(frame: CGRect(x: 0, y: 150, width: screenW, height: 0.5))
        divider1.backgroundColor = UIColor.MyColor.lightGray
        self.view.addSubview(divider1)
        
        //新密码
        let pwdStr2 = UILabel(frame: CGRect(x: 30, y: 150, width: 100, height: 50))
        pwdStr2.text = "设置登录密码"
        pwdStr2.textColor = .black
        pwdStr2.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(pwdStr2)
        let pwdStr2Height = pwdStr2.frame.height
        
        tfPwdNew = UITextField(frame: CGRect(x: 140, y: 150, width: screenW-30, height: 50))
        tfPwdNew!.placeholder = "请输入新密码"
        tfPwdNew!.textColor = .gray
        tfPwdNew!.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(tfPwdNew!)
        
        let start2 = UILabel(frame: CGRect(x: 20, y: 150+pwdStr2Height/2-5, width: 10, height: 10))
        start2.text = "*"
        start2.textColor = .red
        start2.textAlignment = .center
        self.view.addSubview(start2)
        
        let divider2 = UIView(frame: CGRect(x: 0, y: 200, width: screenW, height: 0.5))
        divider2.backgroundColor = UIColor.MyColor.lightGray
        self.view.addSubview(divider2)
        
        //确认密码
        let pwdStr3 = UILabel(frame: CGRect(x: 30, y: 200, width: 100, height: 50))
        pwdStr3.text = "确认登录密码"
        pwdStr3.textColor = .black
        pwdStr3.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(pwdStr3)
        let pwdStr3Height = pwdStr3.frame.height
        
        tfPwdConfirm = UITextField(frame: CGRect(x: 140, y: 200, width: screenW-30, height: 50))
        tfPwdConfirm!.placeholder = "请再次输入新密码"
        tfPwdConfirm!.textColor = .gray
        tfPwdConfirm!.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(tfPwdConfirm!)
        
        let start3 = UILabel(frame: CGRect(x: 20, y: 200+pwdStr3Height/2-5, width: 10, height: 10))
        start3.text = "*"
        start3.textColor = .red
        start3.textAlignment = .center
        self.view.addSubview(start3)
        
        let divider3 = UIView(frame: CGRect(x: 0, y: 250, width: screenW, height: 0.5))
        divider3.backgroundColor = UIColor.MyColor.lightGray
        self.view.addSubview(divider3)
        
        //确认修改
        let btnModify = UIButton(type: .roundedRect)
        btnModify.frame = CGRect(x: 30, y: screenH-100, width: screenW-60, height: 45)
        btnModify.setTitle("确认修改", for: UIControl.State())
        btnModify.setTitleColor(.white, for: UIControl.State.normal)
        btnModify.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btnModify.backgroundColor = UIColor.MyColor.blue
        btnModify.layer.cornerRadius = 5
        btnModify.layer.masksToBounds = true
        btnModify.addTarget(self, action: #selector(requestModify), for: .touchUpInside)
        self.view.addSubview(btnModify)
        
        addBaseWidget()
    }
    
    /**
     修改密码
     */
    @objc func requestModify() {
        if tfPwdOld!.text!.isEmpty {
            sToast.showToast(content: "请输入原密码")
            return
        }
        if tfPwdNew!.text!.isEmpty {
            sToast.showToast(content: "请输入新密码")
            return
        }
        if tfPwdConfirm!.text!.isEmpty {
            sToast.showToast(content: "请再次输入新密码")
            return
        }
        if tfPwdConfirm!.text! != tfPwdNew!.text! {
            sToast.showToast(content: "再次输入的新密码不一致")
            return
        }
        
        sToast.hideToast()
        dialog.showDialog()
        let url = URL(string: "\(CONST.init().BASE_URL)/guns-cloud-two-system/entUser/updatePassword")
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        let dic1:[String:String] = ["oldPassword":tfPwdOld!.text!.sha256(), "newPassword":tfPwdNew!.text!.sha256(), "repeatPassword":tfPwdConfirm!.text!.sha256()]
        let data1:NSData! = try? JSONSerialization.data(withJSONObject: dic1, options: []) as NSData?
        let json1Str = NSString(data:data1 as Data,encoding: String.Encoding.utf8.rawValue) as! String
        let dic2:[String:String] = ["passwordParam":json1Str]
        let data2:NSData! = try? JSONSerialization.data(withJSONObject: dic2, options: []) as NSData?
        var params = NSString(data:data2 as Data,encoding: String.Encoding.utf8.rawValue) as! String
        params = params.replacingOccurrences(of: "\\", with: "")
        params = params.replacingOccurrences(of: "\"{\"", with: "{\"")
        params = params.replacingOccurrences(of: "\"}\"", with: "\"}")
        print(params)
        request.httpBody = params.data(using: .utf8)
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
                        if let jsonObj : NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary {
                            let code:Int = (jsonObj["code"] as? Int)!
                            self.dialog.hideDialog()
                            if code == 200 {
                                self.navigationController?.popToRootViewController(animated: true)
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
