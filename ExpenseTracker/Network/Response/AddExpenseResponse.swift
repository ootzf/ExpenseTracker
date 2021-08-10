//
//  AddExpenseResponse.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/10/21.
//

import Foundation

class AddExpenseResponse: Codable {
    var expenseID: String?
    
    enum CodingKeys: String, CodingKey  {
        case expenseID
    }
}

