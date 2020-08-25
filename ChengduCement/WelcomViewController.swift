//
//  WelcomViewController.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/13.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

class WelcomViewController: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "bg_welcome"))
        imageView.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH)
        self.view.addSubview(imageView)
    }

}
