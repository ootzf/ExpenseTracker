//
//  LandingPageViewModel.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/10/21.
//

import Foundation
import Charts

class LandingPageViewModel {
    var dataSource: [ExpenseEntry]!
    var contentDidChangeHandler: ([ExpenseEntry])->Void = {sender in }
    
    init() {
        dataSource = []
    }
    
    func loadExpenses() {
        let list = CoreDataManager.shared.loadExpenses()
        dataSource = list
        contentDidChangeHandler(list)
    }
    
    func getChartData(expenses: [ExpenseEntry]) -> [PieChartDataEntry] {
        let dataset = expenses.map { expense in PieChartDataEntry(value: expense.amount, label: expense.name)  }
        return dataset
    }
    
    func saveExpenseEntry(name: String, amount: Double) {
        CoreDataManager.shared.saveEvent(name: name, amount: amount)
    }
    
    func deleteExpense(expense: ExpenseEntry) {
        CoreDataManager.shared.deleteOneExpense(objectId: expense.objectID)
    }
}
