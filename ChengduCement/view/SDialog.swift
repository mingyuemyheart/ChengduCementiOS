//
//  Dialog.swift
//  ChengduCement
//
//  Created by 孙晓明 on 2020/8/9.
//  Copyright © 2020 孙晓明. All rights reserved.
//

import UIKit

class SDialog: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(dialogView)
    }
    
    public let dialogView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isHidden = true
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        
        let avi = UIActivityIndicatorView()
        avi.frame = CGRect(x: viewWidth/2-15, y: viewHeight/2-15, width: 30, height: 30)
        avi.startAnimating()
        avi.color = .white
        view.addSubview(avi)
        
        return view
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func showDialog() {
        dialogView.isHidden = false
    }
    
    @objc func hideDialog() {
        dialogView.isHidden = true
    }
    
}
