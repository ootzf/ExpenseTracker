//
//  ViewCollection.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/9/21.
//

import UIKit

public class ViewCollection {
    public struct Nib{}
}

extension ViewCollection.Nib {
    static func expenseTableViewCellNib() -> UINib {
        return UINib(nibName: ExpenseTableViewCell.identifier, bundle: Bundle.main)
    }
}
