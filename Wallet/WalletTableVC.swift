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
    
//    init(title: String, value: String) {
//        self.title = title
//        self.value = value
//    }
//
//    init(sectionData: [String]) {
//        self.sectionData = sectionData
//    }
    
}

class WalletTableVC: UITableViewController {

    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WalletManager.sharedInstance.getWalletData()

        tableViewData = [cellData(opened: false, title: "title1", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title2", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title3", value: "10.5", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "title4", value: "10.5", sectionData: ["cell1", "cell2", "cell3"])]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell1", for: indexPath)
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath)
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                }
        }
    }


}
