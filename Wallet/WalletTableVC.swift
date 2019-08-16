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
                self.walletTransactionModel = fetchedTransactionData
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
        if walletModel[section].opened == true {
            if walletModel[section].key == "A" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "B" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "C" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "D" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "E" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "F" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "G" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "H" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "I" {
                return walletTransactionModel.count + 1
            } else if walletModel[section].key == "J" {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell1", for: indexPath)
            let data = walletModel[indexPath.section]
            cell.textLabel?.text = "\(data.key): \(data.value)"
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath)
            let data = walletTransactionModel[indexPath.row - 1]
            cell.textLabel?.text = "\(data.slug): \(data.name): \(data.amount)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if walletModel[indexPath.section].opened == true {
                self.walletModel[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
             
            } else if walletModel[indexPath.section].opened == false {
                walletModel[indexPath.section].opened = true
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
