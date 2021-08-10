//
//  ExpenseService.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/10/21.
//

import Alamofire

protocol ExpenseServiceProtocol {
    func getExpenses(handler:@escaping (_ result: APIResult)-> Void)
    func addExpense(expense: ExpenseEntry, handler:@escaping (_ result: APIResult)-> Void)
    func deleteExpense(expenseID: String, handler:@escaping (_ result: APIResult)-> Void)
}

enum APIResult {
    case success(response: Codable)
    case failure(error: Error)
}

class ExpenseService: ExpenseServiceProtocol {
    
    let headers: HTTPHeaders = [
        "apikey": "",
      ]
    var manager: Alamofire.Session!
    
    func getExpenses(handler: @escaping (APIResult) -> Void) {
        let url = Endpoint.getExpenses.url
        manager.request(url, method: .get, parameters: [:], encoding: JSONEncoding(options: []), headers: nil).validate().responseDecodable(of: ExpenseListResponse.self, decoder: JSONDecoder()) { (response) in
            switch(response.result) {
            case .success(let result):
                handler(.success(response: result))
            case .failure(let errorMsg):
                handler(.failure(error: errorMsg))
            }
        }
    }
    
    func addExpense(expense: ExpenseEntry, handler:@escaping (_ result: APIResult)-> Void) {
        let url = Endpoint.addExpense.url
        manager.request(url, method: .post, parameters: [:], encoding: JSONEncoding(options: []), headers: nil).validate().responseDecodable(of: AddExpenseResponse.self, decoder: JSONDecoder()) { (response) in
            switch(response.result) {
            case .success(let result):
                handler(.success(response: result))
            case .failure(let errorMsg):
                handler(.failure(error: errorMsg))
            }
        }
    }
    
    func deleteExpense(expenseID: String, handler: @escaping (APIResult) -> Void) {
        let url = Endpoint.deleteExpense.url
        let param = ["expenseID" : expenseID]
        manager.request(url, method: .post, parameters: param, encoding: JSONEncoding(options: []), headers: nil).validate().responseDecodable(of: DeleteExpenseResponse.self, decoder: JSONDecoder()) { (response) in
            switch(response.result) {
            case .success(let result):
                handler(.success(response: result))
            case .failure(let errorMsg):
                handler(.failure(error: errorMsg))
            }
        }
    }
    
    
}
