//
//  WalletTableVC.swift
//  Wallet
//
//  Created by russell on 14/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var value = String()
    var sectionData = [String]()
    
}

class WalletTableVC: UITableViewController {

    var walletModel = [WalletModel]()
    var walletTransactionModel = [WalletTransactionModel]()
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWallet()
        getWalletTransaction()
        
        tableViewData = [cellData(opened: false, title: "title1", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title2", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title3", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title3", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title3", value: "10.5", sectionData: ["cell1", "cell2", "cell3"])]
        
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
    
    func getWalletTransaction() {
        WalletManager.sharedInstance.getWalletTransaction { (result) in
            guard result.error == nil else {
                print("walletTransaction.error:\(String(describing: result.error))")
                return
            }
            if let fetchedTransactionData = result.value {
                self.walletTransactionModel = fetchedTransactionData
                print("walletTransactionModel: \(fetchedTransactionData)")
            }
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
            if tableViewData.indices.contains(section) {
                return tableViewData[section].sectionData.count + 1
            } else {
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
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if walletModel[indexPath.section].opened == true {
                walletModel[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                walletModel[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                }
        }
    }


}
