//
//  BaseViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/13.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var screenW:CGFloat = 0
    var screenH:CGFloat = 0
    var sToast = SToast()
    var dialog = SDialog()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.MyColor.blue
        self.navigationController?.navigationBar.tintColor = .white//文字颜色
        self.navigationController?.navigationBar.barStyle = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        screenW = UIScreen.main.bounds.width
        screenH = UIScreen.main.bounds.height
        
    }
    
    /**
     添加通用控件，保证在view最上层
     */
    @objc func addBaseWidget() {
        sToast.frame = CGRect(x: screenW/2-75, y: screenH-110, width: 150, height: 30)
        self.view.addSubview(sToast)
        
        dialog.frame = CGRect(x: screenW/2-25, y: screenH/2-25, width: 50, height: 50)
        self.view.addSubview(dialog)
    }

}
