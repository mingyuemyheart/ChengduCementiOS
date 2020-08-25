//
//  UserUtil.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/11.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import Foundation
import UIKit

class UserUtil: NSObject {
    //保存用户信息
    func saveUserInfo(userName: String, passWord: String, token: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(userName, forKey: "userName")
        userDefaults.set(passWord, forKey: "passWord")
        userDefaults.set(token, forKey: "token")
    }

    //获取用户信息
    func getUserInfo() -> [String] {
        let userDefaults = UserDefaults.standard
        let userName:String = userDefaults.string(forKey: "userName") ?? ""
        let passWord:String = userDefaults.string(forKey: "passWord") ?? ""
        let token:String = userDefaults.string(forKey: "token") ?? ""
        let result:[String] = [userName, passWord, token]
        return result
    }
    
    //获取用户名
    func getUserName() -> String {
        let userDefaults = UserDefaults.standard
        let userName:String = userDefaults.string(forKey: "userName") ?? ""
        return userName
    }
    
    //获取密码
    func getPassWord() -> String {
        let userDefaults = UserDefaults.standard
        let passWord:String = userDefaults.string(forKey: "passWord") ?? ""
        return passWord
    }
    
    //获取token
    func getToken() -> String {
        let userDefaults = UserDefaults.standard
        let token:String = userDefaults.string(forKey: "token") ?? ""
        return token
    }
    
    //清空用户信息
    func clearUserInfo() {
        let userDefaults = UserDefaults.standard
        let dics = userDefaults.dictionaryRepresentation()
        for key in dics {
            userDefaults.removeObject(forKey: key.key)
        }
    }
    
}



