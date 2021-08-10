//
//  LandingPageViewController.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/9/21.
//

import UIKit
import Charts
import RandomColorSwift

class LandingPageViewController: UIViewController {
    @IBOutlet weak var addButton: RoundButton!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noExpenseView: UIView!
    @IBOutlet weak var expenseStackView: UIStackView!
    var viewModel: LandingPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.shadowRadius = 5.0
        // Do any additional setup after loading the view.
        viewModel = LandingPageViewModel()
        setupHandler()
        viewModel.loadExpenses()
        setTableView()
    }
    
    func setupHandler() {
        viewModel.contentDidChangeHandler = {[self] list in
            noExpenseView.isHidden = !list.isEmpty
            expenseStackView.isHidden = list.isEmpty
            if(!list.isEmpty) {
                let chartData = viewModel.getChartData(expenses: list)
                setChartData(chartData: chartData)
                tableView.reloadData()
            }
        }
    }
    
    func setChartData(chartData: [PieChartDataEntry]) {
        let set = PieChartDataSet(entries: chartData, label: "Expense Report")
        set.entryLabelFont = .systemFont(ofSize: 0.0)
        set.valueTextColor = .darkGray
        let colors = chartData.map { _ in return randomColor(hue: .blue, luminosity: .light) }
        set.colors = colors
        let l = pieChart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .currency
        pFormatter.maximumFractionDigits = 2
        pFormatter.currencySymbol = "$"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.darkGray)
        pieChart.data = data
    }
    
    func setTableView() {
        tableView.register(ViewCollection.Nib.expenseTableViewCellNib(), forCellReuseIdentifier: ExpenseTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
    }
    
    @IBAction func didTap(_ sender: Any) {
        let alertController = UIAlertController(title: "Fill in your expense", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Expense"
            textField.keyboardType = .asciiCapable
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Amount"
            textField.keyboardType = .decimalPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            guard let expenseTextField = alertController.textFields?.first else { return }
            guard let amountTextField = alertController.textFields?.last else { return }
            let name = expenseTextField.text ?? ""
            guard let amount = Double(amountTextField.text ?? "") else { return }
            self.viewModel.saveExpenseEntry(name: name, amount: amount)
            self.viewModel.loadExpenses()
        })
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}



extension LandingPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpenseTableViewCell.identifier, for: indexPath) as? ExpenseTableViewCell else { return UITableViewCell() }
        let model = viewModel.dataSource[indexPath.row]
        cell.config(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let expense = viewModel.dataSource[indexPath.row]
            viewModel.deleteExpense(expense: expense)
            viewModel.loadExpenses()
        }
    }
}

