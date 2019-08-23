//
//  WalletTableVC.swift
//  Wallet
//
//  Created by russell on 14/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import UIKit

class WalletTableVC: UITableViewController {

    var walletModel = [WalletModel]()
    var walletTransactionModel = [WalletTransactionModel]()
    var previouslyClickedSection: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWallet()
        
    }
    
    func getWallet() {
        WalletManager.sharedInstance.getWalletData { (result) in
            guard result.error == nil else {
                print("wallet.error:\(String(describing: result.error))")
                return
            }
            if let fetchedData = result.value {
                self.walletModel = fetchedData
            }
            print("walletModel: \(self.walletModel)")
            self.tableView.reloadData()
        }
    }
    
    func getWalletTransaction(key: String, completionHandler:
        
        @escaping () -> Void) {
        WalletManager.sharedInstance.getWalletTransaction(key: key) { (result) in
            guard result.error == nil else {
                print("walletTransaction.error:\(String(describing: result.error))")
                return
            }
            if let fetchedTransactionData = result.value {
                
                let reducedData = fetchedTransactionData.reduce( [WalletTransactionModel]()) { (partial, model) in
                    var partial = partial
                    
                    let matchingIndex = partial.firstIndex(where: { (existingModel) -> Bool in
                        existingModel.slug == model.slug
                    })
                    
                    if let matchingIndex = matchingIndex {
                        partial[matchingIndex].amount += model.amount
                    } else {
                        partial.append(model)
                    }
                    
                    return partial
                }
                
                self.walletTransactionModel = reducedData

            }
            
            
            print("walletTransactionModel: \(self.walletTransactionModel)")
            self.tableView.reloadData()
            
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return walletModel.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //walletTransactionModel.indices.contains(section)
        if walletModel[section].opened == true {
            if walletModel[section].key.contains("A") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("B") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("C") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("D") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("E") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("F") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("G") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("H") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("I") {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key.contains("J") {
                return walletTransactionModel.count + 1
            }else  {
                return 1
            }
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell1", for: indexPath) as! walletCell1
            let data = walletModel[indexPath.section]
            //cell.textLabel?.text = "\(data.key): \(data.value)"
            cell.alphabetImages.image = UIImage(named: "\(data.key)")
            let myNumber = doubleToIntWhenDecimalZero(number: data.value)
            cell.amountLabel.text = "\(myNumber)"
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath)
            let data = walletTransactionModel[indexPath.row - 1]
            let myNumber = doubleToIntWhenDecimalZero(number: data.amount)
            cell.textLabel?.text = "\(data.pos) | \(myNumber)"
            return cell
        }
    }
    
    func doubleToIntWhenDecimalZero(number: Double) -> Any {
        if number.truncatingRemainder(dividingBy: 1.0) == 0.0 {
            return Int(number)
        } else {
            return number
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let prev = self.previouslyClickedSection {
            print("prev: \(prev)")
            if prev != indexPath.section {
                self.walletTransactionModel = []
                self.walletModel[prev].opened = false
                let sections = IndexSet.init(integer: prev)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
        if indexPath.row == 0 {
            if walletModel[indexPath.section].opened == true {
                self.walletModel[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
             
            } else if walletModel[indexPath.section].opened == false {
                walletModel[indexPath.section].opened = true
                self.previouslyClickedSection = indexPath.section
                DispatchQueue.main.async {
                    self.getWalletTransaction(key: self.walletModel[indexPath.section].key, completionHandler: {
                        let sections = IndexSet.init(integer: indexPath.section)
                        tableView.reloadSections(sections, with: .none)
                    })
                }
            }
        }
    }


}
