//
//  RoundButton.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/9/21.
//

import UIKit

class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        let height = self.frame.height
        layer.cornerRadius = height / 2
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = false
            self.layer.shadowRadius = abs(shadowRadius)
            self.layer.shadowOffset.height = shadowRadius //this is your offset
            self.layer.shadowOpacity = abs(shadowRadius) > 0 ? 0.3 : 0.0
        }
    }
    
}

