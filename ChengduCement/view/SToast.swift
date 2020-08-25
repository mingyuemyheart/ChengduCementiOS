//
//  SToast.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/9.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

var label = UILabel()

class SToast: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(toastView)
    }
    
    public let toastView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.isHidden = true
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        
        label.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(label)
        
        return view
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func showToast(content: String) {
        toastView.isHidden = false
        label.text = content
        print(content)
    }
    
    @objc func hideToast() {
        toastView.isHidden = true
        label.text = ""
    }
    
}
