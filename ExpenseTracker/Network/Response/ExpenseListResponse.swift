//
//  ExpenseListResponse.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/10/21.
//

import Foundation


class ExpenseListResponse: Codable {
    var entries: [ExpenseItem]?
    
    enum CodingKeys: String, CodingKey  {
        case entries
    }
}

class ExpenseItem: Codable {
    var name: String?
    var amount: Double?
    enum CodingKeys: String, CodingKey  {
        case name
        case amount
    }
}
