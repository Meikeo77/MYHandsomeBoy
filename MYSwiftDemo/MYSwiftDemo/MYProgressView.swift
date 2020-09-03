//
//  MYProgressView.swift
//  MYSwiftDemo
//
//  Created by Meikeo on 2020/9/3.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import UIKit

class MYProgressView: UIView {
    
    var progress: String!
    var label: UILabel!
    
    init(progress: String) {
        super.init(frame: .init(origin: CGPoint(x: 0, y: 0), size:CGSize(width: 500, height: 50)))
        self.progress = progress
        
        self.label = UILabel()
        self.label.textColor = .black
        self.label.font = .systemFont(ofSize: 12)
        self.label.text = self.progress
        self.addSubview(self.label)
        self.backgroundColor = .lightGray
        self.label.frame = CGRect(origin: CGPoint(x: 15, y: 0), size: CGSize(width: 400, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
