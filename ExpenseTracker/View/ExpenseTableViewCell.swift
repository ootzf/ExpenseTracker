//
//  ExpenseTableViewCell.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/9/21.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    static let identifier = "ExpenseTableViewCell"
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func config(model: ExpenseEntry) {
        expenseLabel.text = model.name ?? ""
        amountLabel.text = "$ \(model.amount)"
    }
}
