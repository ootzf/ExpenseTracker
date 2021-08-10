//
//  Endpoint.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/10/21.
//

import Foundation

enum Endpoint {
    case getExpenses
    case addExpense
    case deleteExpense
    
    var base: String {
        return ""   //For UAT replace sit with uat
    }
    
    var path: String {
        switch self {
        case .getExpenses:
            return "/getExpenses"
        case .addExpense:
            return "/addExpense"
        case .deleteExpense:
            return "/deleteExpense"
        }
    }
    
    var url: String {
        return "\(base)\(path)"
    }
}
