//
//  BaseView.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/9/21.
//

import UIKit

class BaseView: UIView {
    var identifier: String { get { return "" } }
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func commonInit() {
        contentView = UINib(nibName: self.identifier, bundle: Bundle(for:
            type(of: self))).instantiate(withOwner: self, options: nil)[0] as? UIView
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
